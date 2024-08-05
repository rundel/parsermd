# Tests around basic expression parsers

test_that("Basic parser tests - open", {

  ## Valid inputs

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

  ## Trailing : or " "
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
    rmd_ast(
      rmd_fenced_div_open(".test1"),
      rmd_fenced_div_open(".test2"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )
  )


  expect_equal(
    parse_rmd_cpp("::: test1\n::: test2\n::: test3\n:::\n:::\n:::\n"),
    rmd_ast(
      rmd_fenced_div_open(".test1"),
      rmd_fenced_div_open(".test2"),
      rmd_fenced_div_open(".test3"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )
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
    rmd_ast(
      rmd_fenced_div_open(c("#special",".sidebar")),
      rmd_markdown("Here is a paragraph.","","And another."),
      rmd_fenced_div_close()
    )
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
    rmd_ast(
      rmd_fenced_div_open(".Warning"),
      rmd_markdown("This is a warning.", ""),
      rmd_fenced_div_open(".Danger"),
      rmd_markdown("This is a warning within a warning."),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )
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


