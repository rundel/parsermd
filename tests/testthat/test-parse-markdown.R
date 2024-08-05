
test_that("markdown", {

  expect_identical(
    check_markdown_parser("test\n"),
    rmd_markdown(
      rmd_markdown_line("test")
    )
  )

  expect_identical(
    check_markdown_parser("test\ntest\n"),
    rmd_markdown(
      rmd_markdown_line("test"),
      rmd_markdown_line("test")
    )
  )

  expect_identical(
    check_markdown_parser("`r 1+1`\n"),
    rmd_markdown(
      rmd_markdown_line(
        rmd_inline_code(engine = "r", code="1+1")
      )
    )
  )

  expect_identical(
    check_markdown_parser("`{r} 1+1`\n"),
    rmd_markdown(
      rmd_markdown_line(
        rmd_inline_code(engine = "r", code="1+1")
      )
    )
  )

  expect_identical(
    check_markdown_parser("``r 1+1``\n"),
    rmd_markdown(
      rmd_markdown_line(
        "`", rmd_inline_code(engine = "r", code="1+1"), "`"
      )
    )
  )

  expect_identical(
    check_markdown_parser("``{r} 1+1``\n"),
    rmd_markdown(
      rmd_markdown_line("`", rmd_inline_code(engine = "r", code="1+1"), "`")
    )
  )
})

test_that("Mixed", {

  # FIXME - flesh this out and bring inline
  expect_equal(
    length( check_markdown_parser("hello {{< test >}} `r 1+1`\n")[[1]] ),
    4
  )
})
