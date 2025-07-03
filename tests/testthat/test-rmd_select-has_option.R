test_that("has_option works with option names", {
  # Create test AST with chunks having different options
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "setup", 
        code = "library(ggplot2)",
        options = list(message = FALSE, warning = FALSE)
      ),
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(echo = TRUE, fig.width = 8)
      ),
      rmd_chunk(
        engine = "r", 
        name = "analysis", 
        code = "summary(cars)"
        # no options
      ),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting chunks with "message" option (regardless of value)
  message_subset = rmd_select(original_ast, has_option("message"))
  
  # Expected result: setup chunk at position 1
  expected_subset = original_ast[1]
  
  expect_equal(message_subset, expected_subset)
})

test_that("has_option works with option values", {
  # Create test AST with chunks having specific option values
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "setup", 
        code = "library(ggplot2)",
        options = list(echo = "FALSE", warning = "FALSE")
      ),
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(echo = "TRUE", message = "FALSE")
      ),
      rmd_chunk(
        engine = "r", 
        name = "hidden", 
        code = "secret_calculation()",
        options = list(echo = "FALSE", include = "FALSE")
      )
    )
  )
  
  # Test selecting chunks with echo = FALSE
  no_echo_subset = rmd_select(original_ast, has_option(echo = "FALSE"))
  
  # Expected result: setup and hidden chunks at positions 1 and 3
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(no_echo_subset, expected_subset)
})

test_that("has_option works with multiple options", {
  # Create test AST with various option combinations
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "setup", 
        code = "library(ggplot2)",
        options = list(message = FALSE, warning = FALSE, echo = FALSE)
      ),
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(fig.width = 8, fig.height = 6)
      ),
      rmd_chunk(
        engine = "r", 
        name = "analysis", 
        code = "summary(cars)",
        options = list(warning = FALSE)
      )
    )
  )
  
  # Test selecting chunks that have either "message" or "fig.width" options
  multi_subset = rmd_select(original_ast, has_option("message", "fig.width"))
  
  # Expected result: setup and plot chunks at positions 1 and 2
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_option works with mixed option types", {
  # Create test AST with mix of option names and values
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "setup", 
        code = "library(ggplot2)",
        options = list(echo = "FALSE", warning = "FALSE")
      ),
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(echo = "TRUE", warning = "FALSE")
      ),
      rmd_chunk(
        engine = "r", 
        name = "quiet", 
        code = "analysis()",
        options = list(message = "FALSE")
      )
    )
  )
  
  # Test selecting chunks with "warning" option present OR echo = TRUE (OR logic)
  mixed_subset = rmd_select(original_ast, has_option("warning", echo = "TRUE"))
  
  # Expected result: setup and plot chunks at positions 1 and 2 (both have warning OR echo = TRUE)
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(mixed_subset, expected_subset)
})

test_that("has_option returns empty when no matches", {
  # Create test AST with chunks without the target option
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(echo = TRUE)
      ),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with non-existent option
  result = rmd_select(original_ast, has_option("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_option ignores non-chunk nodes", {
  # Create test AST with mix of node types
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section", level = 1L),
      rmd_chunk(
        engine = "r", 
        name = "plot", 
        code = "plot(cars)",
        options = list(echo = FALSE)
      ),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting with echo option
  echo_subset = rmd_select(original_ast, has_option("echo"))
  
  # Expected result: only the chunk at position 3
  expected_subset = original_ast[3]
  
  expect_equal(echo_subset, expected_subset)
})

test_that("has_option works with character option values", {
  # Create test AST with string option values
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(
        engine = "r", 
        name = "plot1", 
        code = "plot(cars)",
        options = list(fig.cap = "Car plot", engine = "r")
      ),
      rmd_chunk(
        engine = "python", 
        name = "plot2", 
        code = "plt.plot(x, y)",
        options = list(fig.cap = "Python plot", engine = "python")
      ),
      rmd_chunk(
        engine = "r", 
        name = "analysis", 
        code = "summary(cars)"
      )
    )
  )
  
  # Test selecting chunks with fig.cap option (string values)
  caption_subset = rmd_select(original_ast, has_option("fig.cap"))
  
  # Expected result: both plot chunks at positions 1 and 2
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(caption_subset, expected_subset)
})

test_that("has_option works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_option("echo"))
  
  expect_equal(result, empty_ast)
})