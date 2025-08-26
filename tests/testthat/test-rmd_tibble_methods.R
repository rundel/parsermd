test_that("rmd_tibble core methods work correctly", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test as_ast roundtrip
  ast_from_tbl = as_ast(rmd_tbl)
  expect_s3_class(ast_from_tbl, "rmd_ast")
  expect_equal(length(ast_from_tbl), length(rmd))
  
  # Test as_document
  doc_from_tbl = as_document(rmd_tbl)
  doc_from_ast = as_document(rmd)
  expect_type(doc_from_tbl, "character")
  expect_equal(doc_from_tbl, doc_from_ast)
  
  # Test rmd_node_* methods
  expect_equal(rmd_node_type(rmd_tbl), rmd_node_type(rmd))
  expect_equal(rmd_node_label(rmd_tbl), rmd_node_label(rmd))
  expect_equal(rmd_node_length(rmd_tbl), rmd_node_length(rmd))
  
  # Test rmd_select
  chunks_tbl = rmd_select(rmd_tbl, has_type("rmd_chunk"))
  chunks_ast = rmd_select(rmd, has_type("rmd_chunk"))
  expect_s3_class(chunks_tbl, "rmd_tibble")
  expect_equal(nrow(chunks_tbl), length(chunks_ast))
  expect_equal(as_document(chunks_tbl), as_document(chunks_ast))
})

test_that("rmd_tibble insert method works correctly", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test rmd_insert 
  test_node = rmd_markdown("Test content")
  result_tbl = rmd_insert(rmd_tbl, nodes = test_node, location = "after")
  result_ast = rmd_insert(rmd, nodes = test_node, location = "after")
  
  expect_s3_class(result_tbl, "rmd_tibble")
  expect_equal(as_document(result_tbl), as_document(result_ast))
})

test_that("rmd_tibble ast_append and ast_prepend work correctly", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test rmd_ast_append
  test_node = rmd_markdown("Appended content")
  result_append_tbl = rmd_ast_append(rmd_tbl, test_node)
  result_append_ast = rmd_ast_append(rmd, test_node)
  
  expect_s3_class(result_append_tbl, "rmd_tibble")
  expect_equal(as_document(result_append_tbl), as_document(result_append_ast))
  
  # Test rmd_ast_prepend
  result_prepend_tbl = rmd_ast_prepend(rmd_tbl, test_node)
  result_prepend_ast = rmd_ast_prepend(rmd, test_node)
  
  expect_s3_class(result_prepend_tbl, "rmd_tibble")
  expect_equal(as_document(result_prepend_tbl), as_document(result_prepend_ast))
})

test_that("rmd_tibble chunk options methods work correctly", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test rmd_get_options
  options_tbl = rmd_get_options(rmd_tbl)
  options_ast = rmd_get_options(rmd)
  expect_equal(options_tbl, options_ast)
  
  # Test rmd_set_options (only on chunks)
  chunks_tbl = rmd_select(rmd_tbl, has_type("rmd_chunk"))
  if (nrow(chunks_tbl) > 0) {
    result = rmd_set_options(chunks_tbl, eval = FALSE)
    expect_s3_class(result, "rmd_tibble")
  }
})

test_that("rmd_tibble modify method works correctly", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test rmd_modify - add line numbers to markdown
  add_line_numbers = function(node) {
    if (inherits(node, "rmd_markdown")) {
      node@lines = paste(seq_along(node@lines), node@lines, sep = ". ")
    }
    node
  }
  
  result_tbl = rmd_modify(rmd_tbl, add_line_numbers)
  result_ast = rmd_modify(rmd, add_line_numbers)
  
  expect_s3_class(result_tbl, "rmd_tibble")
  expect_equal(as_document(result_tbl), as_document(result_ast))
})