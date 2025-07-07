test_that("has_code works with simple pattern", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(dplyr)"),
      rmd_chunk(engine = "r", name = "plot", code = "plot(cars)"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(data)"),
      rmd_markdown(lines = "Some text")
    )
  )
  

  plot_subset = rmd_select(original_ast, has_code("plot"))
  

  expected_subset = original_ast[2]
  
  expect_equal(plot_subset, expected_subset)
})

test_that("has_code works with regex patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "data", code = "data = read.csv('file.csv')"),
      rmd_chunk(engine = "r", name = "analysis", code = "result = analyze(data)"),
      rmd_chunk(engine = "r", name = "plot", code = "ggplot(data, aes(x, y)) + geom_point()"),
      rmd_chunk(engine = "r", name = "summary", code = "summary(result)")
    )
  )
  

  assign_subset = rmd_select(original_ast, has_code("="))
  

  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(assign_subset, expected_subset)
})

test_that("has_code works with multiple patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(dplyr)"),
      rmd_chunk(engine = "r", name = "data", code = "data = read_csv('file.csv')"),
      rmd_chunk(engine = "r", name = "plot", code = "ggplot(data) + geom_histogram()"),
      rmd_chunk(engine = "r", name = "test", code = "summary(data)")
    )
  )
  

  multi_subset = rmd_select(original_ast, has_code(c("library", "ggplot")))
  

  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_code works with function calls", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "stats", code = "mean(values)\nsd(values)"),
      rmd_chunk(engine = "r", name = "plots", code = "hist(data)\nboxplot(data)"),
      rmd_chunk(engine = "r", name = "models", code = "lm(y ~ x, data)"),
      rmd_markdown(lines = "Some text")
    )
  )
  

  stats_subset = rmd_select(original_ast, has_code("mean|sd"))
  

  expected_subset = original_ast[1]
  
  expect_equal(stats_subset, expected_subset)
})

test_that("has_code returns empty when no matches", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "simple", code = "print('hello')"),
      rmd_markdown(lines = "Text content"),
      rmd_chunk(engine = "r", name = "basic", code = "x = 1")
    )
  )
  

  result = rmd_select(original_ast, has_code("nonexistent_function"))
  

  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_code only matches code chunks", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Analysis", level = 1L),
      rmd_markdown(lines = "Text mentioning plot() function"),
      rmd_chunk(engine = "r", name = "code", code = "plot(cars)"),
      rmd_code_block(attr = "r", code = "plot(data)")  # code block, not chunk
    )
  )
  

  plot_subset = rmd_select(original_ast, has_code("plot"), keep_yaml = FALSE)
  

  expected_subset = original_ast[c(4, 5)]
  
  expect_equal(plot_subset, expected_subset)
})

test_that("has_code validates input", {

  expect_snapshot_error(has_code(123))
  expect_snapshot_error(has_code(NULL))
  expect_snapshot_error(has_code(character(0)))
  expect_snapshot_error(has_code(c("valid", NA)))
})

test_that("has_code works with multiline code", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "complex", 
        code = c(
          "library(ggplot2)",
          "data = read.csv('file.csv')",
          "plot = ggplot(data, aes(x, y)) +",
          "  geom_point() +",
          "  theme_minimal()"
        )
      ),
      rmd_chunk(
        engine = "r", 
        name = "simple", 
        code = "summary(data)"
      ),
      rmd_chunk(
        engine = "r", 
        name = "analysis", 
        code = c(
          "model = lm(y ~ x, data)",
          "summary(model)"
        )
      )
    )
  )
  

  ggplot_subset = rmd_select(original_ast, has_code("ggplot"))
  

  expected_subset = original_ast[1]
  
  expect_equal(ggplot_subset, expected_subset)
})

test_that("has_code works with empty AST", {

  empty_ast = rmd_ast(nodes = list())
  

  result = rmd_select(empty_ast, has_code("any_pattern"))
  
  expect_equal(result, empty_ast)
})