test_that("has_type works with single type", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test selecting rmd_chunk nodes
  chunk_subset = rmd_select(rmd, has_type("rmd_chunk"))
  chunk_types = rmd_node_type(chunk_subset)
  
  expect_true(all(chunk_types == "rmd_chunk"))
  expect_true(length(chunk_subset) > 0)
})

test_that("has_type works with multiple types", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test selecting both rmd_chunk and rmd_heading nodes
  selected_subset = rmd_select(rmd, has_type(c("rmd_chunk", "rmd_heading")))
  selected_types = rmd_node_type(selected_subset)
  
  expect_true(all(selected_types %in% c("rmd_chunk", "rmd_heading")))
  expect_true(length(selected_subset) > 0)
})

test_that("has_type returns empty ast when no matches", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test with non-existent type
  result = rmd_select(rmd, has_type("nonexistent_type"))
  
  expect_equal(length(result), 0)
  expect_s3_class(result, "rmd_ast")
})

test_that("has_type works with specific node types", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test rmd_yaml nodes
  yaml_subset = rmd_select(rmd, has_type("rmd_yaml"))
  yaml_types = rmd_node_type(yaml_subset)
  expect_true(all(yaml_types == "rmd_yaml"))
  
  # Test rmd_heading nodes
  heading_subset = rmd_select(rmd, has_type("rmd_heading"))
  heading_types = rmd_node_type(heading_subset)
  expect_true(all(heading_types == "rmd_heading"))
  
  # Test rmd_markdown nodes
  markdown_subset = rmd_select(rmd, has_type("rmd_markdown"))
  markdown_types = rmd_node_type(markdown_subset)
  expect_true(all(markdown_types == "rmd_markdown"))
})

test_that("has_type validates input", {
  # Test that has_type requires character input
  expect_snapshot_error(has_type(123))
  expect_snapshot_error(has_type(NULL))
  expect_snapshot_error(has_type(NA))
  expect_snapshot_error(has_type(c("valid", NA)))
})

test_that("has_type subset contains correct nodes", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Get all chunk nodes
  chunk_subset = rmd_select(rmd, has_type("rmd_chunk"))
  
  # Verify that the subset contains only chunks and all expected chunks
  all_types = rmd_node_type(rmd)
  expected_chunk_count = sum(all_types == "rmd_chunk")
  
  expect_equal(length(chunk_subset), expected_chunk_count)
  expect_true(all(rmd_node_type(chunk_subset) == "rmd_chunk"))
})