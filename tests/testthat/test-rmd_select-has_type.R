test_that("has_type works with single type", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2")
    )
  )
  
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = FALSE)
  expected_subset = original_ast[c(3, 5)]
  
  expect_equal(chunk_subset, expected_subset)
})

test_that("has_type works with multiple types", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Section 2", level = 2L)
    )
  )
  
  selected_subset = rmd_select(original_ast, has_type(c("rmd_chunk", "rmd_heading")), keep_yaml = FALSE)
  expected_subset = original_ast[c(2, 3, 5)]
  
  expect_equal(selected_subset, expected_subset)
})

test_that("has_type returns empty ast when no matches", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section 1", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"))
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_type works with specific node types", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test", output = "html_document")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Section 2", level = 2L),
      rmd_markdown(lines = "More text")
    )
  )
  
  yaml_subset = rmd_select(original_ast, has_type("rmd_yaml"))
  expect_equal(yaml_subset, original_ast[1])
  
  heading_subset = rmd_select(original_ast, has_type("rmd_heading"), keep_yaml = FALSE)
  expect_equal(heading_subset, original_ast[c(2, 5)])
  
  markdown_subset = rmd_select(original_ast, has_type("rmd_markdown"), keep_yaml = FALSE)
  expect_equal(markdown_subset, original_ast[c(4, 6)])
})

test_that("has_type validates input", {
  expect_snapshot_error(has_type(123))
  expect_snapshot_error(has_type(NULL))
  expect_snapshot_error(has_type(NA))
  expect_snapshot_error(has_type(c("valid", NA)))
})

test_that("has_type preserves node order", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "First", level = 1L),
      rmd_chunk(engine = "r", name = "chunk1", code = "x = 1"),
      rmd_markdown(lines = "Text 1"),
      rmd_chunk(engine = "r", name = "chunk2", code = "y = 2"),
      rmd_heading(name = "Second", level = 2L),
      rmd_chunk(engine = "python", name = "chunk3", code = "z = 3")
    )
  )
  
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"))
  expected_chunks = original_ast[c(2, 4, 6)]
  expect_equal(chunk_subset, expected_chunks)
  

  expect_equal(
    rmd_node_attr(chunk_subset, "name"),
    list("chunk1", "chunk2", "chunk3")
  )
})

test_that("has_type works with complex node properties", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "setup", 
        code = "library(ggplot2)",
        options = list(include = FALSE)
      ),
      rmd_markdown(lines = "Introduction text"),
      rmd_chunk(
        engine = "python", 
        name = "analysis", 
        code = "import pandas as pd",
        options = list(eval = TRUE)
      ),
      rmd_heading(name = "Results", level = 1L)
    )
  )
  
  chunk_subset = rmd_select(original_ast, has_type("rmd_chunk"))
  expected_chunks = original_ast[c(1, 3)]
  expect_equal(chunk_subset, expected_chunks)
  

  expect_equal(
    rmd_node_attr(chunk_subset, "engine"), 
    list("r", "python")
  )
})

test_that("has_type works with empty AST", {
  empty_ast = rmd_ast(nodes = list())
  result = rmd_select(empty_ast, has_type("rmd_chunk"))
  
  expect_equal(result, empty_ast)
})

test_that("keep_yaml defaults to TRUE", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"))
  expected = original_ast[c(1, 3)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml = TRUE includes YAML nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  expected = original_ast[c(1, 3)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml = FALSE excludes YAML nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = FALSE)
  expected = original_ast[3]
  
  expect_equal(result, expected)
})

test_that("keep_yaml works with multiple YAML nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_yaml(yaml = list(output = "html_document")),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  expected = original_ast[c(1, 3, 4)]
  
  expect_equal(result, expected)
})

test_that("keep_yaml works when no YAML nodes exist", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = TRUE)
  expected = original_ast[2]
  
  expect_equal(result, expected)
})

test_that("keep_yaml removes duplicates when YAML explicitly selected", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1")
    )
  )
  
  result = rmd_select(original_ast, has_type("rmd_yaml"), keep_yaml = TRUE)
  expected = original_ast[1]
  
  expect_equal(result, expected)
})

test_that("keep_yaml validates input", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1")
    )
  )
  
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = "true"))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = 1))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = NA))
  expect_snapshot_error(rmd_select(original_ast, has_type("rmd_chunk"), keep_yaml = c(TRUE, FALSE)))
})