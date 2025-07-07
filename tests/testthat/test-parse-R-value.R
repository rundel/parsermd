test_that("parse_R_value_cpp() parses logical values correctly", {
  expect_equal(parse_R_value_cpp("TRUE"), TRUE)
  expect_equal(parse_R_value_cpp("FALSE"), FALSE)
})

test_that("parse_R_value_cpp() parses integer values correctly", {
  expect_equal(parse_R_value_cpp("100L"), 100L)
  expect_equal(parse_R_value_cpp("-25L"), -25L)
  expect_equal(parse_R_value_cpp("0L"), 0L)
})

test_that("parse_R_value_cpp() parses numeric values without L suffix as doubles", {
  expect_equal(parse_R_value_cpp("42"), 42.0)
  expect_equal(parse_R_value_cpp("-17"), -17.0)
  expect_equal(parse_R_value_cpp("0"), 0.0)
})

test_that("parse_R_value_cpp() parses double values correctly", {
  expect_equal(parse_R_value_cpp("3.14"), 3.14)
  expect_equal(parse_R_value_cpp("-2.718"), -2.718)
  expect_equal(parse_R_value_cpp("5.0"), 5.0)
  expect_equal(parse_R_value_cpp("1.5e-3"), 1.5e-3)
  expect_equal(parse_R_value_cpp("2.5e+2"), 2.5e+2)
  expect_equal(parse_R_value_cpp("1.2e3"), 1.2e3)
})

test_that("parse_R_value_cpp() parses string values correctly", {
  expect_equal(parse_R_value_cpp("hello"), "hello")
  expect_equal(parse_R_value_cpp("test123"), "test123")
  expect_equal(parse_R_value_cpp("my-file_name.txt"), "my-file_name.txt")
  expect_equal(parse_R_value_cpp(""), "")
  expect_equal(parse_R_value_cpp("hello world"), "hello world")
  expect_equal(parse_R_value_cpp("abc123"), "abc123")
  expect_equal(parse_R_value_cpp("false"), "false")  # lowercase
})

test_that("parse_R_value_cpp() type precedence works correctly", {

  expect_equal(parse_R_value_cpp("TRUE"), TRUE)
  expect_equal(parse_R_value_cpp("FALSE"), FALSE)
  

  expect_equal(parse_R_value_cpp("5.0"), 5.0)
  expect_equal(parse_R_value_cpp("3.14"), 3.14)
  

  expect_equal(parse_R_value_cpp("42"), 42.0)
  

  expect_equal(parse_R_value_cpp("100L"), 100L)
  

  expect_equal(parse_R_value_cpp("not_a_number"), "not_a_number")
  expect_equal(parse_R_value_cpp("true"), "true")  # lowercase
})

test_that("parse_R_value_cpp() handles edge cases", {

  expect_equal(parse_R_value_cpp("1"), 1.0)
  expect_equal(parse_R_value_cpp("1."), 1.0)
  expect_equal(parse_R_value_cpp("1.0"), 1.0)
  

  expect_equal(parse_R_value_cpp("1L"), 1L)
  

  expect_equal(parse_R_value_cpp("1e5"), 1e5)
  expect_equal(parse_R_value_cpp("1E5"), 1E5)
  

  expect_equal(parse_R_value_cpp("999999999"), 999999999.0)
  expect_equal(parse_R_value_cpp("999999999L"), 999999999L)
  

  expect_equal(parse_R_value_cpp("0.0001"), 0.0001)
})

test_that("parse_R_value_cpp() handles mixed content correctly with fixed parser", {

  expect_equal(parse_R_value_cpp("123abc"), "123abc")
  expect_equal(parse_R_value_cpp("42test"), "42test")
  expect_equal(parse_R_value_cpp("3.14xyz"), "3.14xyz")
  expect_equal(parse_R_value_cpp("TRUE_VALUE"), "TRUE_VALUE")
  expect_equal(parse_R_value_cpp("FALSE123"), "FALSE123")
  expect_equal(parse_R_value_cpp("my-var_name"), "my-var_name")
  expect_equal(parse_R_value_cpp("variable"), "variable")
})