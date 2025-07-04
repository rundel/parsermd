test_round_trip = function(file, skip_files = character()) {
  file_path = unclass(file)
  should_skip = file_path %in% skip_files
  
  test_lines = c(
    paste0("test_that(", rlang::expr_deparse(file_path), ", {"),
    if (should_skip) {
      paste0("  testthat::skip(\"Skipping problematic file: ", file_path, "\")")
    } else {
      c(
        rlang::expr_deparse( rlang::expr(
          ast <- testthat::expect_no_error(
            parse_rmd(!!!file_path), 
            class = "rmd_ast"
          )
        )),
        
        rlang::expr_deparse( rlang::expr(
          testthat::expect_equal(
            ast,
            parse_rmd(as_document(ast, padding = character()))
          )
        ))
      )
    },
    "})"
  )
  
  test_lines
}
