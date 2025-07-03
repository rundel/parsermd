test_that("has_label works with single label", {
  # Create simple test AST with labeled chunks
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "analysis", code = "plot(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting chunk with specific label
  setup_subset = rmd_select(original_ast, has_label("setup"))
  
  # Expected result: setup chunk at position 2
  expected_subset = original_ast[2]
  
  expect_equal(setup_subset, expected_subset)
})

test_that("has_label works with glob patterns", {
  # Create test AST with pattern-matching labels
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "plot-cars", code = "plot(cars)"),
      rmd_chunk(engine = "r", name = "plot-iris", code = "plot(iris)"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting chunks with pattern "plot-*"
  plot_subset = rmd_select(original_ast, has_label("plot-*"))
  
  # Expected result: both plot chunks at positions 1 and 2
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(plot_subset, expected_subset)
})

test_that("has_label works with multiple labels", {
  # Create test AST with various labels
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", name = "load-data", code = "data(mtcars)"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(mtcars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting multiple specific labels
  subset_result = rmd_select(original_ast, has_label(c("setup", "analysis")))
  
  # Expected result: setup and analysis chunks at positions 1 and 3
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(subset_result, expected_subset)
})

test_that("has_label returns empty when no matches", {
  # Create test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with non-existent label
  result = rmd_select(original_ast, has_label("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_label works with unlabeled nodes", {
  # Create test AST with mix of labeled and unlabeled chunks
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", name = "", code = "plot(cars)"),  # unlabeled
      rmd_heading(name = "Section", level = 1L),  # headings don't have labels in same way
      rmd_chunk(engine = "r", name = "analysis", code = "summary(cars)")
    )
  )
  
  # Test selecting labeled chunks only
  labeled_subset = rmd_select(original_ast, has_label(c("setup", "analysis")))
  
  # Expected result: setup and analysis chunks at positions 1 and 4
  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(labeled_subset, expected_subset)
})

test_that("has_label validates input", {
  # Test that has_label requires character input with minimum length
  expect_snapshot_error(has_label(123))
  expect_snapshot_error(has_label(NULL))
  expect_snapshot_error(has_label(character(0)))
  expect_snapshot_error(has_label(c("valid", NA)))
})

test_that("has_label works with complex glob patterns", {
  # Create test AST with various label patterns
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "fig-scatter", code = "plot(x, y)"),
      rmd_chunk(engine = "r", name = "fig-histogram", code = "hist(x)"),
      rmd_chunk(engine = "r", name = "tbl-summary", code = "summary(df)"),
      rmd_chunk(engine = "r", name = "fig-boxplot", code = "boxplot(x)")
    )
  )
  
  # Test selecting all figure chunks with "fig-*" pattern
  fig_subset = rmd_select(original_ast, has_label("fig-*"))
  
  # Expected result: all fig chunks at positions 1, 2, and 4
  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(fig_subset, expected_subset)
  
  # Verify the correct labels were selected
  expect_equal(
    rmd_node_attr(fig_subset, "name"),
    list("fig-scatter", "fig-histogram", "fig-boxplot")
  )
})

test_that("has_label works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_label("any-label"))
  
  expect_equal(result, empty_ast)
})