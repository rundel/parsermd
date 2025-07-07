test_that("by_fdiv works with single pattern matching", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "This is a note"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Regular markdown"),
      rmd_fenced_div_open(attr = ".warning"),
      rmd_markdown(lines = "This is a warning"),
      rmd_fenced_div_close()
    )
  )
  

  note_subset = rmd_select(original_ast, by_fdiv("note"))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(note_subset, expected_subset)
})

test_that("by_fdiv works with class attribute patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = ".warning"),
      rmd_markdown(lines = "Warning content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = c(".note", "important")),
      rmd_markdown(lines = "Important note"),
      rmd_fenced_div_close()
    )
  )
  

  warning_subset = rmd_select(original_ast, by_fdiv(".warning"))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(warning_subset, expected_subset)
})

test_that("by_fdiv works with multiple pattern matching (ALL must match)", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = c(".warning", "important")),
      rmd_markdown(lines = "Important warning"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = ".warning"),
      rmd_markdown(lines = "Regular warning"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = c("important", "note")),
      rmd_markdown(lines = "Important note"),
      rmd_fenced_div_close()
    )
  )
  

  multi_subset = rmd_select(original_ast, by_fdiv(".warning", "important"))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("by_fdiv handles nested fenced divs correctly", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "outer"),
      rmd_markdown(lines = "Outer content"),
      rmd_fenced_div_open(attr = "inner"),
      rmd_markdown(lines = "Inner content"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "More outer content"),
      rmd_fenced_div_close()
    )
  )
  

  outer_subset = rmd_select(original_ast, by_fdiv("outer"))
  

  expected_outer = original_ast[c(1, 2, 3, 4, 5, 6, 7)]
  
  expect_equal(outer_subset, expected_outer)
  

  inner_subset = rmd_select(original_ast, by_fdiv("inner"))
  

  expected_inner = original_ast[c(3, 4, 5)]
  
  expect_equal(inner_subset, expected_inner)
})

test_that("by_fdiv works with glob patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "callout-note"),
      rmd_markdown(lines = "Note content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = "callout-warning"),
      rmd_markdown(lines = "Warning content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Regular note"),
      rmd_fenced_div_close()
    )
  )
  

  callout_subset = rmd_select(original_ast, by_fdiv("callout-*"))
  

  expected_subset = original_ast[c(1, 2, 3, 4, 5, 6)]
  
  expect_equal(callout_subset, expected_subset)
})

test_that("by_fdiv works with regexp patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Note content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = "callout-note"),
      rmd_markdown(lines = "Callout note"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = "footnote"),
      rmd_markdown(lines = "Footnote content"),
      rmd_fenced_div_close()
    )
  )
  

  exact_subset = rmd_select(original_ast, by_fdiv("^note$", regexp = TRUE))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(exact_subset, expected_subset)
})

test_that("by_fdiv returns empty when no matches", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Note content"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Regular content")
    )
  )
  

  result = rmd_select(original_ast, by_fdiv("nonexistent"))
  

  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("by_fdiv works with multiple independent divs", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "First note"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Between notes"),
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Second note"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = "warning"),
      rmd_markdown(lines = "Warning content"),
      rmd_fenced_div_close()
    )
  )
  

  note_subset = rmd_select(original_ast, by_fdiv("note"))
  

  expected_subset = original_ast[c(1, 2, 3, 5, 6, 7)]
  
  expect_equal(note_subset, expected_subset)
})

test_that("by_fdiv works with complex attribute combinations", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = c("#special", ".sidebar", "important")),
      rmd_markdown(lines = "Special sidebar"),
      rmd_fenced_div_close(),
      rmd_fenced_div_open(attr = c(".sidebar", "normal")),
      rmd_markdown(lines = "Normal sidebar"),
      rmd_fenced_div_close()
    )
  )
  

  complex_subset = rmd_select(original_ast, by_fdiv("#special", ".sidebar"))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(complex_subset, expected_subset)
})

test_that("by_fdiv validates input correctly", {

  test_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close()
    )
  )
  

  expect_snapshot_error(rmd_select(test_ast, by_fdiv(123)))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(character(0))))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(c("valid", NA))))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(c("a", "b"))))  # length > 1
  expect_snapshot_error(rmd_select(test_ast, by_fdiv("note", regexp = "invalid")))
})

test_that("by_fdiv works with empty AST", {

  empty_ast = rmd_ast(nodes = list())
  

  result = rmd_select(empty_ast, by_fdiv("note"))
  
  expect_equal(result, empty_ast)
})

test_that("by_fdiv handles edge case with no matching close", {
  


  test_nodes = list(
    rmd_fenced_div_open(attr = "note"),
    rmd_markdown(lines = "Content")

  )
  

  result = fdiv_find_matching_close(test_nodes, 1)
  

  expect_true(is.na(result))
})

test_that("by_fdiv handles deeply nested divs", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "level1"),
      rmd_markdown(lines = "Level 1 content"),
      rmd_fenced_div_open(attr = "level2"),
      rmd_markdown(lines = "Level 2 content"),
      rmd_fenced_div_open(attr = "level3"),
      rmd_markdown(lines = "Level 3 content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )
  )
  

  level1_subset = rmd_select(original_ast, by_fdiv("level1"))
  expected_level1 = original_ast[c(1, 2, 3, 4, 5, 6, 7, 8, 9)]
  expect_equal(level1_subset, expected_level1)
  

  level3_subset = rmd_select(original_ast, by_fdiv("level3"))
  expected_level3 = original_ast[c(5, 6, 7)]
  expect_equal(level3_subset, expected_level3)
})