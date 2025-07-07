test_that("has_label works with single label", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", name = "analysis", code = "plot(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  setup_subset = rmd_select(original_ast, has_label("setup"), keep_yaml = FALSE)
  expected_subset = original_ast[2]
  
  expect_equal(setup_subset, expected_subset)
})

test_that("has_label works with glob patterns", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "plot-cars", code = "plot(cars)"),
      rmd_chunk(engine = "r", name = "plot-iris", code = "plot(iris)"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  plot_subset = rmd_select(original_ast, has_label("plot-*"))
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(plot_subset, expected_subset)
})

test_that("has_label works with multiple labels", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", name = "load-data", code = "data(mtcars)"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(mtcars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  subset_result = rmd_select(original_ast, has_label(c("setup", "analysis")))
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(subset_result, expected_subset)
})

test_that("has_label returns empty when no matches", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, has_label("nonexistent"))
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_label works with unlabeled nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", name = "", code = "plot(cars)"),  # unlabeled
      rmd_heading(name = "Section", level = 1L),  # headings don't have labels in same way
      rmd_chunk(engine = "r", name = "analysis", code = "summary(cars)")
    )
  )
  
  labeled_subset = rmd_select(original_ast, has_label(c("setup", "analysis")))
  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(labeled_subset, expected_subset)
})

test_that("has_label validates input", {
  expect_snapshot_error(has_label(123))
  expect_snapshot_error(has_label(NULL))
  expect_snapshot_error(has_label(character(0)))
  expect_snapshot_error(has_label(c("valid", NA)))
})

test_that("has_label works with complex glob patterns", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "fig-scatter", code = "plot(x, y)"),
      rmd_chunk(engine = "r", name = "fig-histogram", code = "hist(x)"),
      rmd_chunk(engine = "r", name = "tbl-summary", code = "summary(df)"),
      rmd_chunk(engine = "r", name = "fig-boxplot", code = "boxplot(x)")
    )
  )
  
  fig_subset = rmd_select(original_ast, has_label("fig-*"))
  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(fig_subset, expected_subset)
  

  expect_equal(
    rmd_node_attr(fig_subset, "name"),
    list("fig-scatter", "fig-histogram", "fig-boxplot")
  )
})

test_that("has_label works with empty AST", {
  empty_ast = rmd_ast(nodes = list())
  result = rmd_select(empty_ast, has_label("any-label"))
  
  expect_equal(result, empty_ast)
})