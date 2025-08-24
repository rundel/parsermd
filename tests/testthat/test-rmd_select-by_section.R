test_that("by_section works with simple section", {
  # Create test AST with hierarchical sections
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Introduction", level = 1L),
      rmd_markdown(lines = "Intro text"),
      rmd_heading(name = "Methods", level = 1L),
      rmd_markdown(lines = "Methods text"),
      rmd_chunk(engine = "r", label = "analysis", code = "summary(data)")
    )
  )
  
  # Test selecting "Methods" section
  methods_subset = rmd_select(original_ast, by_section("Methods"), keep_yaml = FALSE)
  
  # Expected result: Methods heading and its content (positions 4, 5, 6)
  expected_subset = original_ast[c(4, 5, 6)]
  
  expect_equal(methods_subset, expected_subset)
})

test_that("by_section works with nested sections", {
  # Create test AST with nested section hierarchy
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Analysis", level = 1L),
      rmd_markdown(lines = "Analysis intro"),
      rmd_heading(name = "Data Preparation", level = 2L),
      rmd_chunk(engine = "r", label = "prep", code = "clean_data()"),
      rmd_heading(name = "Visualization", level = 2L),
      rmd_chunk(engine = "r", label = "plot", code = "plot(data)"),
      rmd_heading(name = "Conclusion", level = 1L),
      rmd_markdown(lines = "Conclusion text")
    )
  )
  
  # Test selecting nested "Data Preparation" section
  prep_subset = rmd_select(original_ast, by_section(c("Analysis", "Data Preparation")))
  
  # Expected result: Analysis heading (parent), Data Preparation heading and its content
  expected_subset = original_ast[c(1, 3, 4)]
  
  expect_equal(prep_subset, expected_subset)
})

test_that("by_section works with glob patterns", {
  # Create test AST with pattern-matching section names
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Exercise 1", level = 1L),
      rmd_markdown(lines = "Exercise 1 text"),
      rmd_heading(name = "Exercise 2", level = 1L),
      rmd_markdown(lines = "Exercise 2 text"),
      rmd_heading(name = "Summary", level = 1L),
      rmd_markdown(lines = "Summary text")
    )
  )
  
  # Test selecting all exercise sections with "Exercise *" pattern
  exercise_subset = rmd_select(original_ast, by_section("Exercise *"))
  
  # Expected result: both Exercise sections and their content (positions 1, 2, 3, 4)
  expected_subset = original_ast[c(1, 2, 3, 4)]
  
  expect_equal(exercise_subset, expected_subset)
})

test_that("by_section with keep_parents = FALSE", {
  # Create test AST with nested sections
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Main Section", level = 1L),
      rmd_markdown(lines = "Main intro"),
      rmd_heading(name = "Subsection", level = 2L),
      rmd_chunk(engine = "r", label = "code", code = "analysis()"),
      rmd_heading(name = "Other Section", level = 1L)
    )
  )
  
  # Test selecting subsection without parents
  sub_subset = rmd_select(original_ast, by_section(c("Main Section", "Subsection"), keep_parents = FALSE))
  
  # Expected result: only Subsection heading and its content (positions 3, 4)
  expected_subset = original_ast[c(3, 4)]
  
  expect_equal(sub_subset, expected_subset)
})

test_that("by_section returns empty when no matches", {
  # Create test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Introduction", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with non-existent section
  result = rmd_select(original_ast, by_section("Nonexistent Section"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("by_section works with different heading levels", {
  # Create test AST with various heading levels
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Chapter", level = 1L),
      rmd_heading(name = "Section", level = 2L),
      rmd_heading(name = "Subsection", level = 3L),
      rmd_markdown(lines = "Content"),
      rmd_heading(name = "Another Section", level = 2L),
      rmd_markdown(lines = "More content")
    )
  )
  
  # Test selecting deeply nested section
  deep_subset = rmd_select(original_ast, by_section(c("Chapter", "Section", "Subsection")))
  
  # Expected result: all parent headings plus subsection content
  expected_subset = original_ast[c(1, 2, 3, 4)]
  
  expect_equal(deep_subset, expected_subset)
})

test_that("by_section validates input", {
  # Test that by_section requires proper input
  expect_snapshot_error(by_section(123))
  expect_snapshot_error(by_section(NULL))
  expect_snapshot_error(by_section(character(0)))
  expect_snapshot_error(by_section(c("valid", NA)))
  expect_snapshot_error(by_section("valid", keep_parents = "not_logical"))
})

test_that("by_section works with single level sections", {
  # Create test AST with only level 1 headings
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "First", level = 1L),
      rmd_markdown(lines = "First content"),
      rmd_chunk(engine = "r", label = "chunk1", code = "code1()"),
      rmd_heading(name = "Second", level = 1L),
      rmd_markdown(lines = "Second content"),
      rmd_heading(name = "Third", level = 1L)
    )
  )
  
  # Test selecting middle section
  second_subset = rmd_select(original_ast, by_section("Second"))
  
  # Expected result: Second heading and its content until next heading
  expected_subset = original_ast[c(4, 5)]
  
  expect_equal(second_subset, expected_subset)
})

test_that("by_section works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, by_section("Any Section"))
  
  expect_equal(result, empty_ast)
})

test_that("by_section works with headings inside fenced divs", {
  # Create test AST with headings inside fenced divs
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Main Chapter", level = 1L),
      rmd_markdown(lines = "Chapter intro"),
      rmd_fenced_div_open(classes = ".callout-note"),
      rmd_heading(name = "Important Note", level = 2L), 
      rmd_markdown(lines = "This is important content"),
      rmd_fenced_div_close(),
      rmd_heading(name = "Regular Section", level = 2L),
      rmd_markdown(lines = "Regular content")
    )
  )
  
  # Test selecting heading inside fenced div
  result = rmd_select(original_ast, by_section(c("Main Chapter", "Important Note")))
  
  expected_positions = c(1, 3, 4, 5, 6)
  expected = original_ast[expected_positions]
  
  expect_equal(result, expected)
})

test_that("by_section works with nested fenced divs", {
  # Create test AST with nested fenced divs
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Document", level = 1L),
      rmd_fenced_div_open(classes = ".outer"),
      rmd_heading(name = "Outer Section", level = 2L),
      rmd_fenced_div_open(classes = ".inner"),
      rmd_heading(name = "Inner Section", level = 3L),
      rmd_markdown(lines = "Deeply nested content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close(),
      rmd_heading(name = "After Divs", level = 2L)
    )
  )
  
  # Test selecting deeply nested heading
  result = rmd_select(original_ast, by_section(c("Document", "Outer Section", "Inner Section")))
  
  expected_positions = c(1, 2, 3, 4, 5, 6, 7, 8)
  expected = original_ast[expected_positions]
  
  expect_equal(result, expected)
})

test_that("by_section works with mixed fenced div scenarios", {
  # Create test AST with mix of regular and fenced div headings
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Chapter 1", level = 1L),
      rmd_markdown(lines = "Chapter content"),
      rmd_heading(name = "Regular Section", level = 2L),
      rmd_markdown(lines = "Regular section content"),
      rmd_fenced_div_open(classes = ".warning"),
      rmd_heading(name = "Warning Section", level = 2L),
      rmd_markdown(lines = "Warning content"),
      rmd_fenced_div_close(),
      rmd_heading(name = "Chapter 2", level = 1L),
      rmd_markdown(lines = "Chapter 2 content")
    )
  )
  
  # Test selecting regular section
  regular_result = rmd_select(original_ast, by_section(c("Chapter 1", "Regular Section")))
  expect_equal(regular_result, original_ast[c(1, 3, 4, 5, 6, 7, 8)])
  
  # Test selecting fenced div section
  fenced_result = rmd_select(original_ast, by_section(c("Chapter 1", "Warning Section")))
  expect_equal(fenced_result, original_ast[c(1, 3, 5, 6, 7, 8)])
})

test_that("by_section works with empty fenced divs", {
  # Create test AST with empty fenced div between sections
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Before", level = 1L),
      rmd_markdown(lines = "Before content"),
      rmd_fenced_div_open(classes = ".empty"),
      rmd_fenced_div_close(),
      rmd_heading(name = "After", level = 1L),
      rmd_markdown(lines = "After content")
    )
  )
  
  # Test selecting sections around empty fenced div
  before_result = rmd_select(original_ast, by_section("Before"))
  expect_equal(before_result, original_ast[c(1, 2, 3, 4)])
  
  after_result = rmd_select(original_ast, by_section("After"))
  expect_equal(after_result, original_ast[c(5, 6)])
})

test_that("by_section handles complex nesting patterns", {
  # Create test AST with complex nesting
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Main", level = 1L),
      rmd_fenced_div_open(classes = ".container"),
      rmd_heading(name = "Sub A", level = 2L),
      rmd_markdown(lines = "Sub A content"),
      rmd_heading(name = "Sub B", level = 2L),
      rmd_fenced_div_open(classes = ".nested"),
      rmd_heading(name = "Nested", level = 3L),
      rmd_markdown(lines = "Nested content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close(),
      rmd_heading(name = "Outside", level = 1L)
    )
  )
  
  # Test various selections
  sub_a_result = rmd_select(original_ast, by_section(c("Main", "Sub A")))
  expect_equal(sub_a_result, original_ast[c(1, 2, 3, 4, 10)])
  
  nested_result = rmd_select(original_ast, by_section(c("Main", "Sub B", "Nested")))
  expect_equal(nested_result, original_ast[c(1, 2, 5, 6, 7, 8, 9, 10)]) #FIXME
})

test_that("by_section respects keep_parents with fenced divs", {
  # Create test AST with fenced div content
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Chapter", level = 1L),
      rmd_fenced_div_open(classes = ".example"),
      rmd_heading(name = "Example", level = 2L),
      rmd_markdown(lines = "Example content"),
      rmd_fenced_div_close(),
      rmd_heading(name = "Summary", level = 1L)
    )
  )
  
  # Test with keep_parents = TRUE (default)
  with_parents = rmd_select(original_ast, by_section(c("Chapter", "Example")))
  expect_equal(with_parents, original_ast[c(1, 2, 3, 4, 5)])
  
  # Test with keep_parents = FALSE
  without_parents = rmd_select(original_ast, by_section(c("Chapter", "Example"), keep_parents = FALSE))
  expect_equal(without_parents, original_ast[c(3, 4)])
})