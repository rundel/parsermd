test_that("has_inline_code works with any engine", {
  # Create test AST with nodes containing inline code
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "The result is `r 2 + 2` which is correct."),
      rmd_markdown(lines = "Plain text without inline code"),
      rmd_markdown(lines = "Python inline: `python import numpy as np`"),
      rmd_chunk(engine = "r", name = "code", code = "x <- 1")
    )
  )
  
  # Test selecting any nodes with inline code
  inline_subset = rmd_select(original_ast, has_inline_code())
  
  # Expected result: nodes with inline code (positions 1, 3)
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(inline_subset, expected_subset)
})

test_that("has_inline_code works with specific engine", {
  # Create test AST with different inline code engines
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R code: `r sum(1:10)` calculates sum"),
      rmd_markdown(lines = "Python code: `python len('hello')` gets length"),
      rmd_markdown(lines = "More R: `r mean(data$values)` for average"),
      rmd_markdown(lines = "No inline code here")
    )
  )
  
  # Test selecting only R inline code
  r_subset = rmd_select(original_ast, has_inline_code("r"))
  
  # Expected result: nodes with R inline code (positions 1, 3)
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code works with multiple engines", {
  # Create test AST with various inline code engines
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R: `r 1+1` and Julia: `julia sqrt(4)`"),
      rmd_markdown(lines = "Python: `python 2**3` calculates power"),
      rmd_markdown(lines = "Shell: `bash echo 'hello'` prints text"),
      rmd_markdown(lines = "More R: `r nrow(df)` counts rows"),
      rmd_markdown(lines = "Plain text")
    )
  )
  
  # Test selecting R and python inline code
  multi_subset = rmd_select(original_ast, has_inline_code(c("r", "python")))
  
  # Expected result: nodes with R or python inline code (positions 1, 2, 4)
  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_inline_code works with glob patterns", {
  # Create test AST with various script engines
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Bash: `bash ls -la` lists files"),
      rmd_markdown(lines = "Shell: `sh pwd` shows directory"),
      rmd_markdown(lines = "Python: `python len(list)` gets length"),
      rmd_markdown(lines = "More bash: `bash grep 'pattern' file.txt`"),
      rmd_markdown(lines = "R code: `r summary(data)`")
    )
  )
  
  # Test selecting all bash-like engines with glob pattern
  bash_subset = rmd_select(original_ast, has_inline_code("ba*"))
  
  # Expected result: bash engine nodes (positions 1, 4)
  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(bash_subset, expected_subset)
})

test_that("has_inline_code returns empty when no matches", {
  # Create test AST without target inline code
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R code: `r 1+1` calculates"),
      rmd_markdown(lines = "Plain text"),
      rmd_chunk(engine = "r", name = "code", code = "analysis()")
    )
  )
  
  # Test with non-existent engine
  result = rmd_select(original_ast, has_inline_code("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_inline_code works across different node types", {
  # Create test AST with inline code in different node types
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Markdown with `r mean(x)` inline R"),
      rmd_heading(name = "Section", level = 1L),  # headings typically don't have inline code
      rmd_yaml(yaml = list(title = "Test")),  # yaml doesn't have inline code
      rmd_chunk(engine = "r", name = "code", code = "x <- 1")  # regular chunk code
    )
  )
  
  # Test selecting nodes with R inline code
  r_subset = rmd_select(original_ast, has_inline_code("r"), keep_yaml = FALSE)
  
  # Expected result: only markdown node with R inline code (position 1)
  expected_subset = original_ast[1]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code validates input", {
  # Test input validation
  expect_snapshot_error(has_inline_code(123))
  expect_snapshot_error(has_inline_code(character(0)))
  expect_snapshot_error(has_inline_code(c("valid", NA)))
})

test_that("has_inline_code works with complex inline expressions", {
  # Create test AST with complex inline code examples
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Complex: `r round(mean(data$values), 2)` rounded mean"),
      rmd_markdown(lines = "Python: `python numpy.array([1,2,3]).mean()` array mean"),
      rmd_markdown(lines = "Multiple: `r x` and `r y` variables"),
      rmd_markdown(lines = "SQL: `sql SELECT COUNT(*) FROM table` query")
    )
  )
  
  # Test selecting R inline code
  r_subset = rmd_select(original_ast, has_inline_code("r"))
  
  # Expected result: nodes with R inline code (positions 1, 3)
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_inline_code("r"))
  
  expect_equal(result, empty_ast)
})