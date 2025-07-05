test_that("by_fdiv works with single pattern matching", {
  # Create test AST with fenced divs
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
  
  # Test selecting note div
  note_subset = rmd_select(original_ast, by_fdiv("note"))
  
  # Expected result: positions 1-3 (note div and its content)
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(note_subset, expected_subset)
})

test_that("by_fdiv works with class attribute patterns", {
  # Create test AST with class attributes
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
  
  # Test selecting warning class
  warning_subset = rmd_select(original_ast, by_fdiv(".warning"))
  
  # Expected result: positions 1-3
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(warning_subset, expected_subset)
})

test_that("by_fdiv works with multiple pattern matching (ALL must match)", {
  # Create test AST with multiple attributes
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
  
  # Test selecting divs that have BOTH .warning AND important
  multi_subset = rmd_select(original_ast, by_fdiv(".warning", "important"))
  
  # Expected result: only positions 1-3 (has both .warning and important)
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("by_fdiv handles nested fenced divs correctly", {
  # Create test AST with nested divs
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
  
  # Test selecting outer div (should include everything)
  outer_subset = rmd_select(original_ast, by_fdiv("outer"))
  
  # Expected result: all positions 1-7
  expected_outer = original_ast[c(1, 2, 3, 4, 5, 6, 7)]
  
  expect_equal(outer_subset, expected_outer)
  
  # Test selecting inner div (should include only inner content)
  inner_subset = rmd_select(original_ast, by_fdiv("inner"))
  
  # Expected result: positions 3-5 (inner div and its content)
  expected_inner = original_ast[c(3, 4, 5)]
  
  expect_equal(inner_subset, expected_inner)
})

test_that("by_fdiv works with glob patterns", {
  # Create test AST with callout-style divs
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
  
  # Test selecting all callout types with glob pattern
  callout_subset = rmd_select(original_ast, by_fdiv("callout-*"))
  
  # Expected result: positions 1-6 (both callout divs)
  expected_subset = original_ast[c(1, 2, 3, 4, 5, 6)]
  
  expect_equal(callout_subset, expected_subset)
})

test_that("by_fdiv works with regexp patterns", {
  # Create test AST with various div types
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
  
  # Test exact match with regexp
  exact_subset = rmd_select(original_ast, by_fdiv("^note$", regexp = TRUE))
  
  # Expected result: positions 1-3 (exact "note" match only)
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(exact_subset, expected_subset)
})

test_that("by_fdiv returns empty when no matches", {
  # Create test AST without target divs
  original_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Note content"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Regular content")
    )
  )
  
  # Test with non-existent pattern
  result = rmd_select(original_ast, by_fdiv("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("by_fdiv works with multiple independent divs", {
  # Create test AST with multiple separate note divs
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
  
  # Test selecting all note divs
  note_subset = rmd_select(original_ast, by_fdiv("note"))
  
  # Expected result: positions 1-3 and 5-7 (both note divs)
  expected_subset = original_ast[c(1, 2, 3, 5, 6, 7)]
  
  expect_equal(note_subset, expected_subset)
})

test_that("by_fdiv works with complex attribute combinations", {
  # Create test AST with complex attributes
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
  
  # Test matching multiple specific attributes
  complex_subset = rmd_select(original_ast, by_fdiv("#special", ".sidebar"))
  
  # Expected result: positions 1-3 (has both #special and .sidebar)
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(complex_subset, expected_subset)
})

test_that("by_fdiv validates input correctly", {
  # Create a simple test AST for validation testing
  test_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close()
    )
  )
  
  # Test input validation within rmd_select context
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(123)))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(character(0))))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(c("valid", NA))))
  expect_snapshot_error(rmd_select(test_ast, by_fdiv(c("a", "b"))))  # length > 1
  expect_snapshot_error(rmd_select(test_ast, by_fdiv("note", regexp = "invalid")))
})

test_that("by_fdiv works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, by_fdiv("note"))
  
  expect_equal(result, empty_ast)
})

test_that("by_fdiv handles edge case with no matching close", {
  # Test the helper function directly with a scenario where
  # find_matching_close doesn't find a matching close
  
  # Create a simple AST with just an open (this would normally be invalid,
  # but we're testing robustness of the helper function)
  test_nodes = list(
    rmd_fenced_div_open(attr = "note"),
    rmd_markdown(lines = "Content")
    # Intentionally no close for testing
  )
  
  # Test fdiv_find_matching_close directly
  result = fdiv_find_matching_close(test_nodes, 1)
  
  # Should return NA since no matching close was found
  expect_true(is.na(result))
})

test_that("by_fdiv handles deeply nested divs", {
  # Create test AST with deeply nested divs
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
  
  # Test selecting level 1 (should include everything)
  level1_subset = rmd_select(original_ast, by_fdiv("level1"))
  expected_level1 = original_ast[c(1, 2, 3, 4, 5, 6, 7, 8, 9)]
  expect_equal(level1_subset, expected_level1)
  
  # Test selecting level 3 (should include only innermost)
  level3_subset = rmd_select(original_ast, by_fdiv("level3"))
  expected_level3 = original_ast[c(5, 6, 7)]
  expect_equal(level3_subset, expected_level3)
})