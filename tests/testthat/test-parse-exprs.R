test_that("curly brace expressions", {

  expect_equal( check_cbrace_expr_parser("{}"), "" )
  expect_equal( check_cbrace_expr_parser("{{}}"), "{}" )
  expect_equal( check_cbrace_expr_parser("{{{}}}"), "{{}}" )
  expect_equal( check_cbrace_expr_parser("{1+1;{3+3}}"), "1+1;{3+3}" )

  expect_error( check_cbrace_expr_parser("{{}") )
  expect_error( check_cbrace_expr_parser("{}}") )
  expect_error( check_cbrace_expr_parser("{") )
})
