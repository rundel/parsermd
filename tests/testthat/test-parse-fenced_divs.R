# Tests around basic expression parsers

test_that("Basic parser tests", {

  ## Valid inputs

  expect_equal(
    check_fenced_div_parser("::: test\n:::\n"),
    create_fenced_div(".test")
  )

  expect_equal(
    check_fenced_div_parser("::: {test}\n:::\n"),
    create_fenced_div("test")
  )

  expect_equal(
    check_fenced_div_parser("::: {#test}\n:::\n"),
    create_fenced_div("#test")
  )

  expect_equal(
    check_fenced_div_parser(":::: test\n::::\n"),
    create_fenced_div(".test")
  )

  expect_equal(
    check_fenced_div_parser("::: test\n::::\n"),
    create_fenced_div(".test")
  )

  expect_equal(
    check_fenced_div_parser(":::: test\n:::\n"),
    create_fenced_div(".test")
  )

  expect_equal(
    check_fenced_div_parser(":::: {}\n:::\n"),
    create_fenced_div("")
  )

  ## Bad inputs

  expect_snapshot( # No attribute
    check_fenced_div_parser(":::\n:::\n"), error=TRUE
  )

  expect_snapshot( # Multiple unbraced attributes
    check_fenced_div_parser("::: a x\n:::\n"), error=TRUE
  )

  expect_snapshot( # Incomplete opening fence
    check_fenced_div_parser(":: {}\n:::\n"), error=TRUE
  )

  expect_snapshot( # Incomplete closing fence
    check_fenced_div_parser("::: {}\n::\n"), error=TRUE
  )

  ## Nested inputs

  expect_equal(
    check_fenced_div_parser("::: test1\n::: test2\n:::\n:::\n"),
    create_fenced_div(".test1", list(create_fenced_div(".test2")))
  )
  expect_equal(
    check_fenced_div_parser("::: test1\n::: test2\n::: test3\n:::\n:::\n:::\n"),
    create_fenced_div(
      ".test1", list(
        create_fenced_div(".test2", list(create_fenced_div(".test3")))
      )
    )
  )

  expect_snapshot(
    check_fenced_div_parser("::: test1\n::: test2\n:::\n"), error=TRUE
  )
})

test_that("Pandoc examples", {

  ex1 = "::::: {#special .sidebar}
Here is a paragraph.

And another.
:::::
"
  expect_equal(
    check_fenced_div_parser(ex1),
    create_fenced_div(
      "#special .sidebar",
      list("Here is a paragraph.","","And another.")
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
    check_fenced_div_parser(ex2),
    create_fenced_div(
      ".Warning", list(
        "This is a warning.", "",
        create_fenced_div(
          ".Danger", list("This is a warning within a warning.")
        )
      )
    )
  )

})

