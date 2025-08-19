test_that("has_type works with single type", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  # Test selecting rmd_chunk nodes (without YAML for this test)
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = FALSE)
  
  # Expected result: chunks at positions 3 and 5
  expected_subset = original_ast[c(3, 5)]
  
  expect_equal(chunk_subset, expected_subset)
})

test_that("has_type works with multiple types", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Section 2", level = 2L)
    )
  )
  
  # Test selecting both rmd_chunk and rmd_heading nodes (without YAML for this test)
  selected_subset = rmd_select(original_ast, has_type(c("rmd_chunk", "rmd_heading")), keep_yaml = FALSE)
  
  # Expected result: headings at 2, 5 and chunk at 3
  expected_subset = original_ast[c(2, 3, 5)]
  
  expect_equal(selected_subset, expected_subset)
})

test_that("has_type returns empty ast when no matches", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section 1", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with non-existent type
  result = rmd_select(original_ast, has_type("rmd_chunk"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_type works with specific node types", {
  # Create comprehensive test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test", output = "html_document")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Section 2", level = 2L),
      rmd_markdown(lines = "More text")
    )
  )
  
  # Test rmd_yaml nodes
  yaml_subset = rmd_select(original_ast, has_type("rmd_yaml"))
  expect_equal(yaml_subset, original_ast[1])
  
  # Test rmd_heading nodes (without YAML for this test)
  heading_subset = rmd_select(original_ast, has_type("rmd_heading"), keep_yaml = FALSE)
  expect_equal(heading_subset, original_ast[c(2, 5)])
  
  # Test rmd_markdown nodes (without YAML for this test)
  markdown_subset = rmd_select(original_ast, has_type("rmd_markdown"), keep_yaml = FALSE)
  expect_equal(markdown_subset, original_ast[c(4, 6)])
})

test_that("has_type validates input", {
  # Test that has_type requires character input
  expect_snapshot_error(has_type(123))
  expect_snapshot_error(has_type(NULL))
  expect_snapshot_error(has_type(NA))
  expect_snapshot_error(has_type(c("valid", NA)))
})

test_that("has_type preserves node order", {
  # Create test AST with mixed types
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "First", level = 1L),
      rmd_chunk(engine = "r", label = "chunk1", code = "x = 1"),
      rmd_markdown(lines = "Text 1"),
      rmd_chunk(engine = "r", label = "chunk2", code = "y = 2"),
      rmd_heading(name = "Second", level = 2L),
      rmd_chunk(engine = "python", label = "chunk3", code = "z = 3")
    )
  )
  
  # Test that chunks are returned in original order
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"))
  expected_chunks = original_ast[c(2, 4, 6)]
  expect_equal(chunk_subset, expected_chunks)
  
  # Verify order by checking chunk names
  expect_equal(
    rmd_node_attr(chunk_subset, "label"),
    list("chunk1", "chunk2", "chunk3")
  )
})

test_that("has_type works with complex node properties", {
  # Create AST with varied chunk properties
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        label = "setup", 
        code = "library(ggplot2)",
        options = list(include = FALSE)
      ),
      rmd_markdown(lines = "Introduction text"),
      rmd_chunk(
        engine = "python", 
        label = "analysis", 
        code = "import pandas as pd",
        options = list(eval = TRUE)
      ),
      rmd_heading(name = "Results", level = 1L)
    )
  )
  
  # Test that all chunks are selected regardless of their specific properties
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"))
  expected_chunks = original_ast[c(1, 3)]
  expect_equal(chunk_subset, expected_chunks)
  
  # Verify different engines are both included
  expect_equal(
    rmd_node_attr(chunk_subset, "engine"), 
    list("r", "python")
  )
})

test_that("has_type works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_type("rmd_chunk"))
  
  expect_equal(result, empty_ast)
})

test_that("keep_yaml defaults to TRUE", {
  # Create test AST with YAML and other nodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test default behavior (should include YAML)
  result = rmd_select(original_ast, has_type("rmd_chunk"))
  
  # Expected result: YAML at position 1 and chunk at position 3
  expected = original_ast[c(1, 3)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml = TRUE includes YAML nodes", {
  # Create test AST with YAML and other nodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test explicit keep_yaml = TRUE
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  
  # Expected result: YAML at position 1 and chunk at position 3
  expected = original_ast[c(1, 3)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml = FALSE excludes YAML nodes", {
  # Create test AST with YAML and other nodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test keep_yaml = FALSE
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = FALSE)
  
  # Expected result: only chunk at position 3
  expected = original_ast[3]
  
  expect_equal(result, expected)
})

test_that("keep_yaml works with multiple YAML nodes", {
  # Create test AST with multiple YAML nodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_yaml(yaml = list(output = "html_document")),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test keep_yaml = TRUE with multiple YAML nodes
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  
  # Expected result: both YAML nodes (1, 3) and chunk (4)
  expected = original_ast[c(1, 3, 4)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml works when no YAML nodes exist", {
  # Create test AST without YAML nodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test keep_yaml = TRUE when no YAML exists
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  
  # Expected result: only chunk at position 2
  expected = original_ast[2]
  
  expect_equal(result, expected)
})

test_that("keep_yaml removes duplicates when YAML explicitly selected", {
  # Create test AST with YAML
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1")
    )
  )
  
  # Test selecting YAML explicitly with keep_yaml = TRUE
  result = rmd_select(original_ast, has_type("rmd_yaml"), keep_yaml = TRUE)
  
  # Expected result: only YAML at position 1 (no duplicates)
  expected = original_ast[1]
  
  expect_equal(result, expected)
})

test_that("keep_yaml validates input", {
  # Create test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1")
    )
  )
  
  # Test invalid keep_yaml values
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = "true"))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = 1))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = NA))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = c(TRUE, FALSE)))
})