test_that("Quoted string values in chunk options are parsed correctly", {
  # Assumes check_chunk_option_parser uses the q_string logic internally for values
  # The parser captures the string including its original quotes as it's part of an R expression

  expect_equal(
    check_chunk_option_parser("opt='hello'"),
    list(opt = "'hello'"),
    info = "Simple single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"world\""),
    list(opt = "\"world\""),
    info = "Simple double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='he\\'llo'"),
    list(opt = "'he\\'llo'"),
    info = "Escaped single quote in single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"wo\\\"rld\""),
    list(opt = "\"wo\\\"rld\""),
    info = "Escaped double quote in double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='a\"b\"c'"),
    list(opt = "'a\"b\"c'"),
    info = "Double quotes inside single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"a'b'c\""),
    list(opt = "\"a'b'c\""),
    info = "Single quotes inside double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='esc\\ape'"),
    list(opt = "'esc\\ape'"),
    info = "Non-delimiter escape sequence in single-quoted string"
  )

  expect_error(
    check_chunk_option_parser("opt='incomplete"),
    info = "Unterminated single-quoted string"
  )
  expect_error(
    check_chunk_option_parser("opt=\"incomplete"),
    info = "Unterminated double-quoted string"
  )
})
