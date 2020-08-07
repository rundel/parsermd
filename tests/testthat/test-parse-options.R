test_that("option parsing", {
  expect_equal(parsermd:::check_option_parser("x=1"), list(x = "1"))
  expect_equal(parsermd:::check_option_parser("x=TRUE"), list(x = "TRUE"))
  expect_equal(parsermd:::check_option_parser("x='y'"), list(x = "'y'"))
  expect_equal(parsermd:::check_option_parser("x=\"y\""), list(x = "\"y\""))
  expect_equal(parsermd:::check_option_parser("x=log(1)"), list(x = "log(1)"))
  expect_equal(parsermd:::check_option_parser("x=exp(log(1))"), list(x = "exp(log(1))"))

  expect_equal(parsermd:::check_option_parser("x=1, y=2"), list(x="1", y="2"))
  expect_equal(parsermd:::check_option_parser("x=log(1), y=log(2)"), list(x="log(1)", y="log(2)"))
  expect_equal(parsermd:::check_option_parser("x=exp(log(1)), y=exp(log(2))"), list(x="exp(log(1))", y="exp(log(2))"))
})
