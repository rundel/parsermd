# Tests around basic expression parsers

test_that("Basic parser tests - open", {

  ## Valid inputs

  expect_equal(
    check_fdiv_open_parser("::: test\n"),
    rmd_fenced_div_open(classes = ".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: {#test}\n"),
    rmd_fenced_div_open(id = "#test")
  )

  expect_equal(
    check_fdiv_open_parser(":::: test\n"),
    rmd_fenced_div_open(classes = ".test")
  )


  ## Trailing : or " "
  expect_equal(
    check_fdiv_open_parser("::: test \n"),
    rmd_fenced_div_open(classes = ".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: test ::::\n"),
    rmd_fenced_div_open(classes = ".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: test :: \n"),
    rmd_fenced_div_open(classes = ".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: {}\n"),
    rmd_fenced_div_open()
  )

  expect_equal(
    check_fdiv_open_parser(":::{}\n"),
    rmd_fenced_div_open()
  )

  expect_equal(
    check_fdiv_open_parser("::: {   }\n"),
    rmd_fenced_div_open()
  )

  ## Bad inputs

  expect_snapshot( # No attribute
    check_fdiv_open_parser(":::\n"), error=TRUE
  )

  expect_snapshot( # Multiple unbraced attributes
    check_fdiv_open_parser("::: a x\n"), error=TRUE
  )

  expect_snapshot( # Incomplete opening fence
    check_fdiv_open_parser(":: {}\n"), error=TRUE
  )

  expect_snapshot( # Incomplete opening fence
    check_fdiv_open_parser(":: \n"), error=TRUE
  )

})

test_that("Basic parser tests - close", {
  # Valid
  expect_equal(
    check_fdiv_close_parser(":::\n"),
    rmd_fenced_div_close()
  )

  expect_equal(
    check_fdiv_close_parser("::::::\n"),
    rmd_fenced_div_close()
  )

  expect_equal(
    check_fdiv_close_parser("::: \n"),
    rmd_fenced_div_close()
  )

  # Invalid

  expect_snapshot(
    check_fdiv_close_parser("::: a\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_close_parser("::: {a}\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_close_parser("::: {}\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_close_parser(":: a\n"), error=TRUE
  )

})

test_that("Nested inputs", {
  expect_equal(
    parse_rmd_cpp("::: test1\n::: test2\n:::\n:::\n"),
    rmd_ast( list(
      rmd_fenced_div_open(classes = ".test1"),
      rmd_fenced_div_open(classes = ".test2"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ) )
  )


  expect_equal(
    parse_rmd_cpp("::: test1\n::: test2\n::: test3\n:::\n:::\n:::\n"),
    rmd_ast( list(
      rmd_fenced_div_open(classes = ".test1"),
      rmd_fenced_div_open(classes = ".test2"),
      rmd_fenced_div_open(classes = ".test3"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ) )
  )
})

test_that("Bad fdivs", {
  expect_snapshot(
    parse_rmd("::: test1\n"), error=TRUE
  )

  expect_snapshot(
    parse_rmd(":::\n"), error=TRUE
  )

  expect_snapshot(
    parse_rmd("::: test1\n::: test2\n:::\n"), error=TRUE
  )

  expect_snapshot(
    parse_rmd("::: test1\n:::\n:::\n"), error=TRUE
  )
})

test_that("Pandoc examples", {

  ex1 = "::::: {#special .sidebar}
Here is a paragraph.

And another.
:::::
"
  expect_equal(
    parse_rmd(ex1),
    rmd_ast( list(
      rmd_fenced_div_open(id = "#special", classes = ".sidebar"),
      rmd_markdown(c("Here is a paragraph.", "", "And another.")),
      rmd_fenced_div_close()
    ) )
  )

  ex2 = "::: Warning ::::::
This is a warning.

::: Danger
This is a warning within a warning.
:::
::::::::::::::::::
"

  expect_equal(
    parse_rmd(ex2),
    rmd_ast( list(
      rmd_fenced_div_open(classes = ".Warning"),
      rmd_markdown("This is a warning."),
      rmd_fenced_div_open(classes = ".Danger"),
      rmd_markdown("This is a warning within a warning."),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ) )
  )

})



#test_that("Utils - fenced_div_depth()", {
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      "::: a\n:::\n"
#    ) ),
#    1
#  )
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      ":::: a\n::: b\n:::\n::::\n"
#    ) ),
#    2
#  )
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      ":::: a\n::: b1\n:::\n::: b2\n:::\n::::\n"
#    ) ),
#    2
#  )
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      ":::: a\n::: b\n::: c\n:::\n:::\n::::\n"
#    ) ),
#    3
#  )
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      ":::: a\n::: b1\n::: c\n:::\n:::\n::: b2\n:::\n::::\n"
#    ) ),
#    3
#  )
#
#  expect_equal(
#    fenced_div_depth( check_fenced_div_parser(
#      ":::: a\n::: b1\n:::\n::: b2\n::: c\n:::\n:::\n::::\n"
#    ) ),
#    3
#  )
#})


test_that("Utils - as_document()", {
  expect_round_trip_identical = function(x) {
    x = parse_rmd_cpp(x)
    expect_identical(
      x,
      parse_rmd_cpp(
        paste(c(as_document(x),""), collapse="\n")
      )
    )
  }

  expect_round_trip_identical("::: a\n:::\n")
  expect_round_trip_identical("::: a\n::: b\n:::\n:::\n")
  expect_round_trip_identical("::: a\n::: b1\n:::\n::: b2\n:::\n:::\n")
  expect_round_trip_identical("::: a\n::: b\n::: c\n:::\n:::\n:::\n")
  expect_round_trip_identical("::: a\n::: b1\n::: c\n:::\n:::\n::: b2\n:::\n:::\n")
  expect_round_trip_identical("::: a\n::: b1\n:::\n::: b2\n::: c\n:::\n:::\n:::\n")
})

test_that("Enhanced attribute parsing - individual types", {
  
  # Class attributes
  expect_equal(
    check_fdiv_open_parser("::: {.warning}\n"),
    rmd_fenced_div_open(classes = ".warning")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.my-class}\n"),
    rmd_fenced_div_open(classes = ".my-class")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.class_with_underscores}\n"),
    rmd_fenced_div_open(classes = ".class_with_underscores")
  )
  
  # ID attributes
  expect_equal(
    check_fdiv_open_parser("::: {#special}\n"),
    rmd_fenced_div_open(id = "#special")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#my-id}\n"),
    rmd_fenced_div_open(id = "#my-id")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#id_with_underscores}\n"),
    rmd_fenced_div_open(id = "#id_with_underscores")
  )
  
  # Key=value attributes - unquoted
  expect_equal(
    check_fdiv_open_parser("::: {data-toggle=collapse}\n"),
    rmd_fenced_div_open(attr = c("data-toggle" = "collapse"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {style=color:red}\n"),
    rmd_fenced_div_open(attr = c("style" = "color:red"))
  )
  
  # Key=value attributes - double quoted
  expect_equal(
    check_fdiv_open_parser("::: {title=\"My Title\"}\n"),
    rmd_fenced_div_open(attr = c("title" = "\"My Title\""))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-content=\"Hello World\"}\n"),
    rmd_fenced_div_open(attr = c("data-content" = "\"Hello World\""))
  )
  
  # Key=value attributes - single quoted
  expect_equal(
    check_fdiv_open_parser("::: {title='Single Quoted'}\n"),
    rmd_fenced_div_open(attr = c("title" = "'Single Quoted'"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {alt='Image description'}\n"),
    rmd_fenced_div_open(attr = c("alt" = "'Image description'"))
  )
  
})

test_that("Enhanced attribute parsing - combinations", {
  
  # Two classes
  expect_equal(
    check_fdiv_open_parser("::: {.primary .large}\n"),
    rmd_fenced_div_open(classes = c(".primary", ".large"))
  )
  
  # ID and class
  expect_equal(
    check_fdiv_open_parser("::: {#myid .myclass}\n"),
    rmd_fenced_div_open(id = "#myid", classes = ".myclass")
  )
  
  # Class and ID (correct order: ID first, then class)  
  expect_equal(
    check_fdiv_open_parser("::: {#myid .myclass}\n"),
    rmd_fenced_div_open(id = "#myid", classes = ".myclass")
  )
  
  # Class and key=value (correct order: class first, then key=value)
  expect_equal(
    check_fdiv_open_parser("::: {.highlight data-value=test}\n"),
    rmd_fenced_div_open(classes = ".highlight", attr = c("data-value" = "test"))
  )
  
  # Three attributes: ID, class, key=value (correct order)
  expect_equal(
    check_fdiv_open_parser("::: {#section .important data-role=note}\n"),
    rmd_fenced_div_open(id = "#section", classes = ".important", attr = c("data-role" = "note"))
  )
  
  # Three attributes: ID, class, key=value (correct order)
  expect_equal(
    check_fdiv_open_parser("::: {#submit .primary data-role=button}\n"),
    rmd_fenced_div_open(id = "#submit", classes = ".primary", attr = c("data-role" = "button"))
  )
  
  # Multiple attributes: ID, multiple classes, multiple key=value (correct order)
  expect_equal(
    check_fdiv_open_parser("::: {#main .container .highlight data-test=value data-role=section}\n"),
    rmd_fenced_div_open(id = "#main", classes = c(".container", ".highlight"), attr = c("data-test" = "value", "data-role" = "section"))
  )
  
  # Multiple key=value pairs
  expect_equal(
    check_fdiv_open_parser("::: {width=100 height=200}\n"),
    rmd_fenced_div_open(attr = c("width" = "100", "height" = "200"))
  )
  
  # Mixed quoted and unquoted values (correct order: class first, then key=value)
  expect_equal(
    check_fdiv_open_parser("::: {.highlighted title=\"Main Section\" data-id=section1}\n"),
    rmd_fenced_div_open(classes = ".highlighted", attr = c("title" = "\"Main Section\"", "data-id" = "section1"))
  )
})

test_that("Enhanced attribute parsing - edge cases", {
  
  # Empty braces (should work as before)
  expect_equal(
    check_fdiv_open_parser("::: {}\n"),
    rmd_fenced_div_open()
  )
  
  # Extra spaces
  expect_equal(
    check_fdiv_open_parser("::: {  .class1   .class2  }\n"),
    rmd_fenced_div_open(classes = c(".class1", ".class2"))
  )
  
  # Complex key=value with special characters
  expect_equal(
    check_fdiv_open_parser("::: {data-url=\"https://example.com/path?q=test\"}\n"),
    rmd_fenced_div_open(attr = c("data-url" = "\"https://example.com/path?q=test\""))
  )
  
  # Hyphenated and underscored names (correct order: ID first, then class)
  expect_equal(
    check_fdiv_open_parser("::: {#my-id_value .my-class_name}\n"),
    rmd_fenced_div_open(id = "#my-id_value", classes = ".my-class_name")
  )
  
  # Numbers in attributes (correct order: ID, class, key=value)
  expect_equal(
    check_fdiv_open_parser("::: {#id2 .class1 data-level=3}\n"),
    rmd_fenced_div_open(id = "#id2", classes = ".class1", attr = c("data-level" = "3"))
  )
})

test_that("ID and class allowed character combinations", {
  
  # Specific requested test case
  expect_equal(
    check_fdiv_open_parser(":::{#exr-var-of-binom-2-0.50}\n"),
    rmd_fenced_div_open(id = "#exr-var-of-binom-2-0.50")
  )
  
  # Letters only (a-z, A-Z)
  expect_equal(
    check_fdiv_open_parser("::: {#myId .myClass}\n"),
    rmd_fenced_div_open(id = "#myId", classes = ".myClass")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#ALLCAPS .lowercase}\n"),
    rmd_fenced_div_open(id = "#ALLCAPS", classes = ".lowercase")
  )
  
  # Letters with digits (not as first character)
  expect_equal(
    check_fdiv_open_parser("::: {#section1 .class2test}\n"),
    rmd_fenced_div_open(id = "#section1", classes = ".class2test")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#test123 .example456}\n"),
    rmd_fenced_div_open(id = "#test123", classes = ".example456")
  )
  
  # Letters with hyphens
  expect_equal(
    check_fdiv_open_parser("::: {#multi-word-id .multi-word-class}\n"),
    rmd_fenced_div_open(id = "#multi-word-id", classes = ".multi-word-class")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#start-middle-end .nav-item-active}\n"),
    rmd_fenced_div_open(id = "#start-middle-end", classes = ".nav-item-active")
  )
  
  # Letters with underscores
  expect_equal(
    check_fdiv_open_parser("::: {#snake_case_id .snake_case_class}\n"),
    rmd_fenced_div_open(id = "#snake_case_id", classes = ".snake_case_class")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#my_long_identifier .utility_class_name}\n"),
    rmd_fenced_div_open(id = "#my_long_identifier", classes = ".utility_class_name")
  )
  
  # Letters with periods (for classes)
  expect_equal(
    check_fdiv_open_parser("::: {.class.with.dots}\n"),
    rmd_fenced_div_open(classes = ".class.with.dots")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.namespace.component.modifier}\n"),
    rmd_fenced_div_open(classes = ".namespace.component.modifier")
  )
  
  # Complex combinations of all allowed characters
  expect_equal(
    check_fdiv_open_parser("::: {#complex_id-with.dots123 .complex_class-name.with123}\n"),
    rmd_fenced_div_open(id = "#complex_id-with.dots123", classes = ".complex_class-name.with123")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#section_2-test.version1 .btn-primary.size-lg.state-active2}\n"),
    rmd_fenced_div_open(id = "#section_2-test.version1", classes = ".btn-primary.size-lg.state-active2")
  )
  
  # Mixed case with all character types
  expect_equal(
    check_fdiv_open_parser("::: {#MyComplex_ID-with.Dots123 .MyClass_Name-with.Periods456}\n"),
    rmd_fenced_div_open(id = "#MyComplex_ID-with.Dots123", classes = ".MyClass_Name-with.Periods456")
  )
  
  # Edge cases with starting characters (must be letters)
  expect_equal(
    check_fdiv_open_parser("::: {#a1 .z9}\n"),
    rmd_fenced_div_open(id = "#a1", classes = ".z9")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#A_test .Z-test}\n"),
    rmd_fenced_div_open(id = "#A_test", classes = ".Z-test")
  )
})

test_that("Enhanced attribute parsing - error cases", {
  
  # Invalid class (no name after dot)
  expect_snapshot(
    check_fdiv_open_parser("::: {.}\n"), error=TRUE
  )
  
  # Invalid ID (no name after hash)
  expect_snapshot(
    check_fdiv_open_parser("::: {#}\n"), error=TRUE
  )
  
  # Invalid key=value (no value)
  expect_snapshot(
    check_fdiv_open_parser("::: {key=}\n"), error=TRUE
  )
  
  
  # Missing closing brace
  expect_snapshot(
    check_fdiv_open_parser("::: {.class\n"), error=TRUE
  )
  
  # Invalid ordering: class before ID (should be ID first)
  expect_snapshot(
    check_fdiv_open_parser("::: {.myclass #myid}\n"), error=TRUE
  )
  
  # Invalid ordering: class before ID (another example)
  expect_snapshot(
    check_fdiv_open_parser("::: {.my-class_name #my-id_value}\n"), error=TRUE
  )
  
  # Invalid ordering: class before ID (third example)
  expect_snapshot(
    check_fdiv_open_parser("::: {.class1 #id2 data-level=3}\n"), error=TRUE
  )
  
  # Invalid ordering: key=value before class
  expect_snapshot(
    check_fdiv_open_parser("::: {data-value=test .highlight}\n"), error=TRUE
  )
  
  # Invalid ordering: key=value before class (another example)
  expect_snapshot(
    check_fdiv_open_parser("::: {title=\"Main Section\" data-id=section1 .highlighted}\n"), error=TRUE
  )
  
  # Invalid ordering: key=value before ID  
  expect_snapshot(
    check_fdiv_open_parser("::: {data-role=button #submit}\n"), error=TRUE
  )
  
  # Invalid: plain attributes not allowed in braced form
  expect_snapshot(
    check_fdiv_open_parser("::: {warning}\n"), error=TRUE
  )
  
  # Invalid: plain attributes not allowed in braced form (other examples)
  expect_snapshot(
    check_fdiv_open_parser("::: {test}\n"), error=TRUE
  )
  
  # Invalid: multiple IDs
  expect_snapshot(
    check_fdiv_open_parser("::: {#id1 #id2}\n"), error=TRUE
  )

  # Invalid ordering: class after class+key=value
  expect_snapshot(
    check_fdiv_open_parser("::: {.col width='50%' .fragment}\n"), error=TRUE
  )

  # Invalid ordering: id after class+key=value
  expect_snapshot(
    check_fdiv_open_parser("::: {.col width='50%' #myid}\n"), error=TRUE
  )

  # Invalid ordering: id after id+key=value (duplicate id after kv)
  expect_snapshot(
    check_fdiv_open_parser("::: {#id1 key=val #id2}\n"), error=TRUE
  )
})


