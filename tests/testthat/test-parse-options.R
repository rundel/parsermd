test_that("option parsing", {
  expect_equal(parsermd:::check_option_parser("x=1"), list(x = "1"))
  expect_equal(parsermd:::check_option_parser("x=TRUE"), list(x = "TRUE"))
  expect_equal(parsermd:::check_option_parser("x='y'"), list(x = "'y'"))
  expect_equal(parsermd:::check_option_parser("x=\"y\""), list(x = "\"y\""))
  expect_equal(parsermd:::check_option_parser("x=log(1)"), list(x = "log(1)"))
  expect_equal(parsermd:::check_option_parser("x=exp(log(1))"), list(x = "exp(log(1))"))
  expect_equal(parsermd:::check_option_parser("x=1+1/1"), list(x = "1+1/1"))

  expect_equal(parsermd:::check_option_parser('"x"=1'), list(x = "1"))
  expect_equal(parsermd:::check_option_parser("'x'=1"), list(x = "1"))
  expect_equal(parsermd:::check_option_parser("'123'=1"), list("123" = "1"))
  expect_equal(parsermd:::check_option_parser('"123"=1'), list("123" = "1"))
  expect_equal(parsermd:::check_option_parser("`x`=1"), list(x = "1"))
  expect_equal(parsermd:::check_option_parser("`123`=1"), list("123" = "1"))
  expect_equal(parsermd:::check_option_parser(".x=1"), list(.x = "1"))
  expect_equal(parsermd:::check_option_parser("..1=1"), list(..1 = "1"))

  expect_equal(parsermd:::check_option_parser("x=1, y=2"), list(x="1", y="2"))
  expect_equal(parsermd:::check_option_parser("x=log(1), y=log(2)"), list(x="log(1)", y="log(2)"))
  expect_equal(parsermd:::check_option_parser("x=exp(log(1)), y=exp(log(2))"), list(x="exp(log(1))", y="exp(log(2))"))
})

test_that("option parsing - bad input", {
  expect_snapshot_error(parsermd:::check_option_parser("x=")) # no expr
  expect_snapshot_error(parsermd:::check_option_parser("=1")) # no rname
  expect_snapshot_error(parsermd:::check_option_parser("x y")) # no equal
  expect_snapshot_error(parsermd:::check_option_parser(".1 = x")) # bad name
  expect_snapshot_error(parsermd:::check_option_parser("1 = x")) # bad name
  expect_snapshot_error(parsermd:::check_option_parser("x = 1, y ="))
  expect_snapshot_error(parsermd:::check_option_parser("x = , y = 1"))
  expect_snapshot_error(parsermd:::check_option_parser("x = 1 y = 1"))
  expect_snapshot_error(parsermd:::check_option_parser("x = 1, .1 = 1"))
  expect_snapshot_error(parsermd:::check_option_parser(".1 = 1, y = 1"))

  # Matching parens
  expect_snapshot_error(parsermd:::check_option_parser("x = log(y"))
  expect_snapshot_error(parsermd:::check_option_parser("x = log(y))"))
  expect_snapshot_error(parsermd:::check_option_parser("x = log(y"))
  expect_snapshot_error(parsermd:::check_option_parser("x = log(y))"))

  # Matching quotes
  # TODO - fix these cases
  #expect_snapshot_error(parsermd:::check_option_parser("x = 'y"))
  #expect_snapshot_error(parsermd:::check_option_parser("x = 'y''"))
  #expect_snapshot_error(parsermd:::check_option_parser("x = ''y'"))
})
