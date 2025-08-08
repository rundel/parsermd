test_that("by_section works with simple section", {
  # Create test AST with hierarchical sections
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Introduction", level = 1L),
      rmd_markdown(lines = "Intro text"),
      rmd_heading(name = "Methods", level = 1L),
      rmd_markdown(lines = "Methods text"),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(data)")
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
      rmd_chunk(engine = "r", name = "prep", code = "clean_data()"),
      rmd_heading(name = "Visualization", level = 2L),
      rmd_chunk(engine = "r", name = "plot", code = "plot(data)"),
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
      rmd_chunk(engine = "r", name = "code", code = "analysis()"),
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
      rmd_chunk(engine = "r", name = "chunk1", code = "code1()"),
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