test_that("Single quoted strings are parsed correctly", {
  expect_equal(
    check_qstring_parser("'hello'"),
    "hello"
  )
  
  expect_equal(
    check_qstring_parser("'hello world'"),
    "hello world"
  )
  
  expect_equal(
    check_qstring_parser("'with spaces and numbers 123'"),
    "with spaces and numbers 123"
  )
  
  expect_equal(
    check_qstring_parser("'special chars !@#$%^&*()'"),
    "special chars !@#$%^&*()"
  )
  
  expect_equal(
    check_qstring_parser("''"),
    ""
  )
})

test_that("Double quoted strings are parsed correctly", {
  expect_equal(
    check_qstring_parser('"hello"'),
    "hello"
  )
  
  expect_equal(
    check_qstring_parser('"hello world"'),
    "hello world"
  )
  
  expect_equal(
    check_qstring_parser('"with spaces and numbers 123"'),
    "with spaces and numbers 123"
  )
  
  expect_equal(
    check_qstring_parser('"special chars !@#$%^&*()"'),
    "special chars !@#$%^&*()"
  )
  
  expect_equal(
    check_qstring_parser('""'),
    ""
  )
})

test_that("Back quoted strings are not supported by q_string parser", {
  expect_error(
    check_qstring_parser("`hello`"),
    info = "Back quoted strings should fail with q_string parser"
  )
  
  expect_error(
    check_qstring_parser("`hello world`"),
    info = "Back quoted strings should fail"
  )
  
  expect_error(
    check_qstring_parser("``"),
    info = "Empty back quoted strings should fail"
  )
})

test_that("Escaped quotes in strings are preserved as-is", {
  expect_equal(
    check_qstring_parser("'can\\'t'"),
    "can\\'t"
  )
  
  expect_equal(
    check_qstring_parser('"she said \\"hello\\""'),
    'she said \\"hello\\"'
  )
  
  expect_equal(
    check_qstring_parser("'multiple \\'escaped\\' quotes'"),
    "multiple \\'escaped\\' quotes"
  )
  
  expect_equal(
    check_qstring_parser('"multiple \\"escaped\\" quotes"'),
    'multiple \\"escaped\\" quotes'
  )
})

test_that("Mixed content in quoted strings works", {
  expect_equal(
    check_qstring_parser("'contains \"double\" quotes'"),
    'contains "double" quotes'
  )
  
  expect_equal(
    check_qstring_parser('"contains \'single\' quotes"'),
    "contains 'single' quotes"
  )
  
  expect_equal(
    check_qstring_parser('"`backticks` inside double quotes"'),
    "`backticks` inside double quotes"
  )
  
  expect_equal(
    check_qstring_parser("'`backticks` inside single quotes'"),
    "`backticks` inside single quotes"
  )
})

test_that("Newlines and special characters in quoted strings", {
  expect_equal(
    check_qstring_parser("'line1\nline2'"),
    "line1\nline2"
  )
  
  expect_equal(
    check_qstring_parser('"line1\nline2"'),
    "line1\nline2"
  )
  
  expect_equal(
    check_qstring_parser("'tab\there'"),
    "tab\there"
  )
  
  expect_equal(
    check_qstring_parser("'unicode: ñ é ü'"),
    "unicode: ñ é ü"
  )
})

test_that("Error cases for malformed strings", {
  expect_error(
    check_qstring_parser("'unterminated"),
    info = "Single quote: unterminated string"
  )
  
  expect_error(
    check_qstring_parser('"unterminated'),
    info = "Double quote: unterminated string"
  )
  
  expect_error(
    check_qstring_parser("`unterminated"),
    info = "Back quote: unterminated string"
  )
  
  expect_error(
    check_qstring_parser("hello"),
    info = "Unquoted string should fail"
  )
  
  expect_error(
    check_qstring_parser("'mixed quotes\""),
    info = "Mismatched quote types"
  )
  
  expect_error(
    check_qstring_parser('"mixed quotes\''),
    info = "Mismatched quote types"
  )
})

test_that("Edge cases and boundary conditions", {
  expect_equal(
    check_qstring_parser("'   '"),
    "   ",
    info = "String with only spaces"
  )
  
  expect_equal(
    check_qstring_parser("'123'"),
    "123",
    info = "Numeric string"
  )
  
  expect_equal(
    check_qstring_parser("'true'"),
    "true",
    info = "Boolean-like string"
  )
  
  expect_equal(
    check_qstring_parser("'NULL'"),
    "NULL",
    info = "NULL-like string"
  )
})

test_that("Raw parameter works correctly", {
  expect_equal(
    check_qstring_parser("'hello'", raw = FALSE),
    "hello"
  )
  
  expect_equal(
    check_qstring_parser("'hello'", raw = TRUE),
    "'hello'"
  )
  
  expect_equal(
    check_qstring_parser('"world"', raw = TRUE),
    '"world"'
  )
})