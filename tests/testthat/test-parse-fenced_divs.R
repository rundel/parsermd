test_that("Basic parser tests - open", {

  expect_equal(
    check_fdiv_open_parser("::: test\n"),
    rmd_fenced_div_open(".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: {test}\n"),
    rmd_fenced_div_open("test")
  )

  expect_equal(
    check_fdiv_open_parser("::: {#test}\n"),
    rmd_fenced_div_open("#test")
  )
  expect_equal(
    check_fdiv_open_parser(":::: test\n"),
    rmd_fenced_div_open(".test")
  )

  expect_equal(
    check_fdiv_open_parser(":::: {test}\n"),
    rmd_fenced_div_open("test")
  )

  expect_equal(
    check_fdiv_open_parser("::: test \n"),
    rmd_fenced_div_open(".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: test ::::\n"),
    rmd_fenced_div_open(".test")
  )

  expect_equal(
    check_fdiv_open_parser("::: test :: \n"),
    rmd_fenced_div_open(".test")
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
  expect_snapshot(
    check_fdiv_open_parser(":::\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_open_parser("::: a x\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_open_parser(":: {}\n"), error=TRUE
  )

  expect_snapshot(
    check_fdiv_open_parser(":: \n"), error=TRUE
  )

})

test_that("Basic parser tests - close", {
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
      rmd_fenced_div_open(".test1"),
      rmd_fenced_div_open(".test2"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ) )
  )
  expect_equal(
    parse_rmd_cpp("::: test1\n::: test2\n::: test3\n:::\n:::\n:::\n"),
    rmd_ast( list(
      rmd_fenced_div_open(".test1"),
      rmd_fenced_div_open(".test2"),
      rmd_fenced_div_open(".test3"),
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
      rmd_fenced_div_open(c("#special",".sidebar")),
      rmd_markdown("Here is a paragraph."),
      rmd_markdown("And another."),
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
      rmd_fenced_div_open(".Warning"),
      rmd_markdown("This is a warning."),
      rmd_fenced_div_open(".Danger"),
      rmd_markdown("This is a warning within a warning."),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ) )
  )

})

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
  
  expect_equal(
    check_fdiv_open_parser("::: {.warning}\n"),
    rmd_fenced_div_open(".warning")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.my-class}\n"),
    rmd_fenced_div_open(".my-class")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.class_with_underscores}\n"),
    rmd_fenced_div_open(".class_with_underscores")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#special}\n"),
    rmd_fenced_div_open("#special")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#my-id}\n"),
    rmd_fenced_div_open("#my-id")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#id_with_underscores}\n"),
    rmd_fenced_div_open("#id_with_underscores")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-toggle=collapse}\n"),
    rmd_fenced_div_open("data-toggle=collapse")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {style=color:red}\n"),
    rmd_fenced_div_open("style=color:red")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {title=\"My Title\"}\n"),
    rmd_fenced_div_open("title=\"My Title\"")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-content=\"Hello World\"}\n"),
    rmd_fenced_div_open("data-content=\"Hello World\"")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {title='Single Quoted'}\n"),
    rmd_fenced_div_open("title='Single Quoted'")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {alt='Image description'}\n"),
    rmd_fenced_div_open("alt='Image description'")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {warning}\n"),
    rmd_fenced_div_open("warning")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {callout-note}\n"),
    rmd_fenced_div_open("callout-note")
  )
})

test_that("Enhanced attribute parsing - combinations", {
  
  expect_equal(
    check_fdiv_open_parser("::: {.primary .large}\n"),
    rmd_fenced_div_open(c(".primary", ".large"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#myid .myclass}\n"),
    rmd_fenced_div_open(c("#myid", ".myclass"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.myclass #myid}\n"),
    rmd_fenced_div_open(c(".myclass", "#myid"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {warning .red}\n"),
    rmd_fenced_div_open(c("warning", ".red"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-value=test .highlight}\n"),
    rmd_fenced_div_open(c("data-value=test", ".highlight"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#section .important note}\n"),
    rmd_fenced_div_open(c("#section", ".important", "note"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-role=button #submit .primary}\n"),
    rmd_fenced_div_open(c("data-role=button", "#submit", ".primary"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {#main .container data-test=value callout}\n"),
    rmd_fenced_div_open(c("#main", ".container", "data-test=value", "callout"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {width=100 height=200}\n"),
    rmd_fenced_div_open(c("width=100", "height=200"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {title=\"Main Section\" data-id=section1 .highlighted}\n"),
    rmd_fenced_div_open(c("title=\"Main Section\"", "data-id=section1", ".highlighted"))
  )
})

test_that("Enhanced attribute parsing - edge cases", {
  
  expect_equal(
    check_fdiv_open_parser("::: {}\n"),
    rmd_fenced_div_open()
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {  .class1   .class2  }\n"),
    rmd_fenced_div_open(c(".class1", ".class2"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {data-url=\"https://example.com/path?q=test\"}\n"),
    rmd_fenced_div_open("data-url=\"https://example.com/path?q=test\"")
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.my-class_name #my-id_value}\n"),
    rmd_fenced_div_open(c(".my-class_name", "#my-id_value"))
  )
  
  expect_equal(
    check_fdiv_open_parser("::: {.class1 #id2 data-level=3}\n"),
    rmd_fenced_div_open(c(".class1", "#id2", "data-level=3"))
  )
})

test_that("Enhanced attribute parsing - error cases", {
  
  expect_snapshot(
    check_fdiv_open_parser("::: {.}\n"), error=TRUE
  )
  
  expect_snapshot(
    check_fdiv_open_parser("::: {#}\n"), error=TRUE
  )
  
  expect_snapshot(
    check_fdiv_open_parser("::: {key=}\n"), error=TRUE
  )
  
  
  expect_snapshot(
    check_fdiv_open_parser("::: {.class\n"), error=TRUE
  )
})
