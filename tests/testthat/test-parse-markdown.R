test_that("markdown", {

  expect_identical(
    check_markdown_parser("test\n"),
    create_markdown("test")
  )

  expect_identical(
    check_markdown_parser("test\ntest\n"),
    create_markdown("test", "test")
  )

  expect_identical(
    check_markdown_parser("`r 1+1`\n"),
    create_markdown(
      create_inline_code(engine = "r", code="1+1")
    )
  )

  expect_identical(
    check_markdown_parser("`{r} 1+1`\n"),
    create_markdown(
      create_inline_code(engine = "r", code="1+1")
    )
  )

  expect_identical(
    check_markdown_parser("``r 1+1``\n"),
    create_markdown(
      list("`", create_inline_code(engine = "r", code="1+1"), "`")
    )
  )

  expect_identical(
    check_markdown_parser("``{r} 1+1``\n"),
    create_markdown(
      list("`", create_inline_code(engine = "r", code="1+1"), "`")
    )
  )
})

