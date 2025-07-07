test_that("has_heading selects headings by title pattern", {
  # Create test AST with various heading types
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Introduction", level = 1L),
      rmd_heading(name = "Exercise 1", level = 2L),
      rmd_heading(name = "Exercise 2: Advanced", level = 2L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_heading(name = "Conclusion", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test exact heading match
  intro_match = rmd_select(original_ast, has_heading("Introduction"), keep_yaml = FALSE)
  expect_equal(length(intro_match@nodes), 1)
  expect_equal(rmd_node_type(intro_match@nodes[[1]]), "rmd_heading")
  expect_equal(rmd_node_attr(intro_match@nodes[[1]], "name"), "Introduction")
  
  # Test glob pattern matching
  exercise_match = rmd_select(original_ast, has_heading("Exercise *"), keep_yaml = FALSE)
  expect_equal(length(exercise_match@nodes), 2)
  expect_true(all(rmd_node_type(exercise_match) == "rmd_heading"))
  
  # Test no matches
  no_match = rmd_select(original_ast, has_heading("Nonexistent"), keep_yaml = FALSE)
  expect_equal(length(no_match@nodes), 0)
  
  # Test multiple patterns
  multi_match = rmd_select(original_ast, has_heading(c("Introduction", "Conclusion")), keep_yaml = FALSE)
  expect_equal(length(multi_match@nodes), 2)
})

test_that("has_heading only selects heading nodes", {
  # Create AST with mixed node types
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test Heading", level = 1L),
      rmd_chunk(engine = "r", name = "Test Heading", code = "1 + 1"),  # Same name as heading but not a heading
      rmd_markdown(lines = "Test Heading content")
    )
  )
  
  # Should only match the actual heading node
  matches = rmd_select(original_ast, has_heading("Test Heading"))
  expect_equal(length(matches@nodes), 1)
  expect_equal(rmd_node_type(matches@nodes[[1]]), "rmd_heading")
})

test_that("has_heading validates input", {
  original_ast = rmd_ast(
    nodes = list(rmd_heading(name = "Test", level = 1L))
  )
  
  # Test input validation
  expect_error(rmd_select(original_ast, has_heading(c())), "Must be of type 'character'")
  expect_error(rmd_select(original_ast, has_heading(character(0))), "Must have length >= 1")
  expect_error(rmd_select(original_ast, has_heading(123)), "Must be of type 'character'")
  expect_error(rmd_select(original_ast, has_heading(NA_character_)), "Contains missing values")
})

test_that("has_heading works with complex glob patterns", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Exercise 1: Basic", level = 2L),
      rmd_heading(name = "Exercise 2: Advanced", level = 2L),
      rmd_heading(name = "Question 1", level = 2L),
      rmd_heading(name = "Summary", level = 1L)
    )
  )
  
  # Test different glob patterns
  exercise_pattern = rmd_select(original_ast, has_heading("Exercise *"))
  expect_equal(length(exercise_pattern@nodes), 2)
  
  numbered_pattern = rmd_select(original_ast, has_heading("* 1*"))
  expect_equal(length(numbered_pattern@nodes), 2)  # Exercise 1 and Question 1
  
  advanced_pattern = rmd_select(original_ast, has_heading("*Advanced*"))
  expect_equal(length(advanced_pattern@nodes), 1)
})

test_that("has_heading works with empty headings", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "", level = 1L),
      rmd_heading(name = "Real Heading", level = 2L)
    )
  )
  
  # Should not match empty heading names
  matches = rmd_select(original_ast, has_heading("Real Heading"))
  expect_equal(length(matches@nodes), 1)
  
  # Test empty pattern (should match empty headings)
  empty_matches = rmd_select(original_ast, has_heading(""))
  expect_equal(length(empty_matches@nodes), 1)
})