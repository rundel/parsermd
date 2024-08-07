
test_that("Inline code", {

  ## Valid inputs

  expect_equal(
    check_inline_code_parser("`r 1+1`"),
    rmd_inline_code(engine = "r", code = "1+1")
  )

  expect_equal(
    check_inline_code_parser("`{r} 1+1`"),
    rmd_inline_code(engine = "r", code = "1+1")
  )

  #expect_equal(
  #  check_inline_code_parser("`python 1+1`"),
  #  rmd_inline_code(engine = "python", code = "1+1")
  #)

  expect_equal(
    check_inline_code_parser("`{python} 1+1`"),
    rmd_inline_code(engine = "python", code = "1+1")
  )


  expect_snapshot(
    check_inline_code_parser("``r 1+1``"),
    error = TRUE
  )
})
