test_that("has_inline_code works with any engine", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "The result is `r 2 + 2` which is correct."),
      rmd_markdown(lines = "Plain text without inline code"),
      rmd_markdown(lines = "Python inline: `python import numpy as np`"),
      rmd_chunk(engine = "r", name = "code", code = "x <- 1")
    )
  )
  

  inline_subset = rmd_select(original_ast, has_inline_code())
  

  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(inline_subset, expected_subset)
})

test_that("has_inline_code works with specific engine", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R code: `r sum(1:10)` calculates sum"),
      rmd_markdown(lines = "Python code: `python len('hello')` gets length"),
      rmd_markdown(lines = "More R: `r mean(data$values)` for average"),
      rmd_markdown(lines = "No inline code here")
    )
  )
  

  r_subset = rmd_select(original_ast, has_inline_code("r"))
  

  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code works with multiple engines", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R: `r 1+1` and Julia: `julia sqrt(4)`"),
      rmd_markdown(lines = "Python: `python 2**3` calculates power"),
      rmd_markdown(lines = "Shell: `bash echo 'hello'` prints text"),
      rmd_markdown(lines = "More R: `r nrow(df)` counts rows"),
      rmd_markdown(lines = "Plain text")
    )
  )
  

  multi_subset = rmd_select(original_ast, has_inline_code(c("r", "python")))
  

  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_inline_code works with glob patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Bash: `bash ls -la` lists files"),
      rmd_markdown(lines = "Shell: `sh pwd` shows directory"),
      rmd_markdown(lines = "Python: `python len(list)` gets length"),
      rmd_markdown(lines = "More bash: `bash grep 'pattern' file.txt`"),
      rmd_markdown(lines = "R code: `r summary(data)`")
    )
  )
  

  bash_subset = rmd_select(original_ast, has_inline_code("ba*"))
  

  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(bash_subset, expected_subset)
})

test_that("has_inline_code returns empty when no matches", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "R code: `r 1+1` calculates"),
      rmd_markdown(lines = "Plain text"),
      rmd_chunk(engine = "r", name = "code", code = "analysis()")
    )
  )
  

  result = rmd_select(original_ast, has_inline_code("nonexistent"))
  

  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_inline_code works across different node types", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Markdown with `r mean(x)` inline R"),
      rmd_heading(name = "Section", level = 1L),  # headings typically don't have inline code
      rmd_yaml(yaml = list(title = "Test")),  # yaml doesn't have inline code
      rmd_chunk(engine = "r", name = "code", code = "x <- 1")  # regular chunk code
    )
  )
  

  r_subset = rmd_select(original_ast, has_inline_code("r"), keep_yaml = FALSE)
  

  expected_subset = original_ast[1]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code validates input", {

  expect_snapshot_error(has_inline_code(123))
  expect_snapshot_error(has_inline_code(character(0)))
  expect_snapshot_error(has_inline_code(c("valid", NA)))
})

test_that("has_inline_code works with complex inline expressions", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Complex: `r round(mean(data$values), 2)` rounded mean"),
      rmd_markdown(lines = "Python: `python numpy.array([1,2,3]).mean()` array mean"),
      rmd_markdown(lines = "Multiple: `r x` and `r y` variables"),
      rmd_markdown(lines = "SQL: `sql SELECT COUNT(*) FROM table` query")
    )
  )
  

  r_subset = rmd_select(original_ast, has_inline_code("r"))
  

  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(r_subset, expected_subset)
})

test_that("has_inline_code works with empty AST", {

  empty_ast = rmd_ast(nodes = list())
  

  result = rmd_select(empty_ast, has_inline_code("r"))
  
  expect_equal(result, empty_ast)
})