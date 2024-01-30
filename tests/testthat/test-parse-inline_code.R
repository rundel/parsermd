
test_that("Inline code", {

  ## Valid inputs

  expect_equal(
    check_inline_code_parser("`r 1+1`"),
    create_inline_code(engine = "r", code = "1+1")
  )

  expect_equal(
    check_inline_code_parser("`{r} 1+1`"),
    create_inline_code(engine = "r", code = "1+1")
  )

  expect_equal(
    check_inline_code_parser("`python 1+1`"),
    create_inline_code(engine = "python", code = "1+1")
  )

  expect_equal(
    check_inline_code_parser("`{python} 1+1`"),
    create_inline_code(engine = "python", code = "1+1")
  )

  expect_equal(
    check_inline_code_parser("``r 1+1``"),
    create_inline_code(engine = "r", code = "1+1", n_ticks = 2L)
  )

  expect_equal(
    check_inline_code_parser("``{r} 1+1``"),
    create_inline_code(engine = "r", code = "1+1", n_ticks = 2L)
  )

  expect_equal(
    check_inline_code_parser("````r ```{r} ````"),
    create_inline_code(engine = "r", code = "```{r} ", n_ticks = 4L)
  )
})
