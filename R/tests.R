test_round_trip = function(file) {
  c(
    paste0("test_that(", rlang::expr_deparse(unclass(file)), ", {"),
  
    rlang::expr_deparse( rlang::expr(
      ast <- testthat::expect_no_error(
        parse_rmd(!!!unclass(file)), 
        class = "rmd_ast"
      )
    )),
    
    rlang::expr_deparse( rlang::expr(
      expect_equal(
        ast,
        parse_rmd(as_document(ast, padding = character()))
      )
    )),

    "})"
  )
}
