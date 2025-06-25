
test_that("markdown", {

  expect_identical(
    check_markdown_parser("test\n"),
    rmd_markdown("test")
  )

  expect_identical(
    check_markdown_parser("test\ntest\n"),
    rmd_markdown(c("test", "test"))
  )

  expect_identical(
    check_markdown_parser("`r 1+1`\n"),
    rmd_markdown("`r 1+1`")
  )

  expect_identical(
    check_markdown_parser("`{r} 1+1`\n"),
    rmd_markdown("`{r} 1+1`")
  )

  expect_identical(
    check_markdown_parser("``r 1+1``\n"),
    rmd_markdown("``r 1+1``")
  )

  expect_identical(
    check_markdown_parser("``{r} 1+1``\n"),
    rmd_markdown("``{r} 1+1``")
  )
})

