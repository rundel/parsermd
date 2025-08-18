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

test_that("has_heading works with special characters", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section 1.1: Data & Analysis", level = 2L),
      rmd_heading(name = "Methods (Revised)", level = 1L),
      rmd_heading(name = "Q&A Session", level = 2L),
      rmd_heading(name = "Results [Final]", level = 3L),
      rmd_heading(name = "Review #1", level = 2L)
    )
  )
  
  # Test matching headings with special characters
  ampersand_match = rmd_select(original_ast, has_heading("*&*"))
  expect_equal(length(ampersand_match@nodes), 2)  # Data & Analysis and Q&A Session
  
  parentheses_match = rmd_select(original_ast, has_heading("*(Revised)"))
  expect_equal(length(parentheses_match@nodes), 1)
  
  brackets_match = rmd_select(original_ast, has_heading("*[Final]"))
  expect_equal(length(brackets_match@nodes), 1)
  
  hash_match = rmd_select(original_ast, has_heading("Review #*"))
  expect_equal(length(hash_match@nodes), 1)
})

test_that("has_heading works with different heading levels", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Introduction", level = 1L),
      rmd_heading(name = "Introduction", level = 2L),
      rmd_heading(name = "Introduction", level = 3L),
      rmd_heading(name = "Methods", level = 1L),
      rmd_heading(name = "Analysis", level = 4L)
    )
  )
  
  # Should match all headings with same name regardless of level
  intro_matches = rmd_select(original_ast, has_heading("Introduction"))
  expect_equal(length(intro_matches@nodes), 3)
  
  # Verify all are heading nodes with correct name
  expect_true(all(rmd_node_type(intro_matches) == "rmd_heading"))
  names = rmd_node_attr(intro_matches, "name")
  expect_true(all(unlist(names) == "Introduction"))
})

test_that("has_heading works with Unicode characters", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Análisis de Datos", level = 1L),
      rmd_heading(name = "数据分析", level = 2L),
      rmd_heading(name = "Αρχή", level = 1L),  # Greek
      rmd_heading(name = "العربية", level = 2L),  # Arabic
      rmd_heading(name = "Regular Text", level = 1L)
    )
  )
  
  # Test exact Unicode matches
  spanish_match = rmd_select(original_ast, has_heading("Análisis de Datos"))
  expect_equal(length(spanish_match@nodes), 1)
  
  chinese_match = rmd_select(original_ast, has_heading("数据分析"))
  expect_equal(length(chinese_match@nodes), 1)
  
  # Test Unicode with glob patterns
  unicode_pattern = rmd_select(original_ast, has_heading("Αρ*"))
  expect_equal(length(unicode_pattern@nodes), 1)
})

test_that("has_heading handles case sensitivity correctly", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Introduction", level = 1L),
      rmd_heading(name = "INTRODUCTION", level = 2L),
      rmd_heading(name = "introduction", level = 3L),
      rmd_heading(name = "Introduction", level = 1L)
    )
  )
  
  # Glob patterns are case-sensitive by default
  exact_case = rmd_select(original_ast, has_heading("Introduction"))
  expect_equal(length(exact_case@nodes), 2)
  
  upper_case = rmd_select(original_ast, has_heading("INTRODUCTION"))
  expect_equal(length(upper_case@nodes), 1)
  
  lower_case = rmd_select(original_ast, has_heading("introduction"))
  expect_equal(length(lower_case@nodes), 1)
})

test_that("has_heading works with very long heading names", {
  long_heading = paste(rep("Very Long Heading Text", 20), collapse = " ")
  
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = long_heading, level = 1L),
      rmd_heading(name = "Short", level = 2L),
      rmd_heading(name = paste(rep("Another Long", 15), collapse = " "), level = 1L)
    )
  )
  
  # Test exact match with long heading
  long_match = rmd_select(original_ast, has_heading(long_heading))
  expect_equal(length(long_match@nodes), 1)
  
  # Test pattern matching with long headings
  long_pattern = rmd_select(original_ast, has_heading("*Long*"))
  expect_equal(length(long_pattern@nodes), 2)
})

test_that("has_heading works with empty AST", {
  empty_ast = rmd_ast(nodes = list())
  
  result = rmd_select(empty_ast, has_heading("Any Pattern"))
  expect_equal(length(result@nodes), 0)
  expect_equal(result, empty_ast)
})

test_that("has_heading validates input comprehensively", {
  original_ast = rmd_ast(
    nodes = list(rmd_heading(name = "Test", level = 1L))
  )
  
  # Use expect_snapshot_error for consistency
  expect_snapshot_error(rmd_select(original_ast, has_heading(123)))
  expect_snapshot_error(rmd_select(original_ast, has_heading(NULL)))
  expect_snapshot_error(rmd_select(original_ast, has_heading(character(0))))
  expect_snapshot_error(rmd_select(original_ast, has_heading(c("valid", NA))))
})

test_that("has_heading works with regex-like characters as literals", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Section (1)", level = 1L),
      rmd_heading(name = "Section [2]", level = 1L),
      rmd_heading(name = "Section {3}", level = 1L),
      rmd_heading(name = "Section .4", level = 1L),
      rmd_heading(name = "Section ^5", level = 1L),
      rmd_heading(name = "Section $6", level = 1L)
    )
  )
  
  # These characters should be treated as literals in glob patterns, not regex
  paren_match = rmd_select(original_ast, has_heading("Section (1)"))
  expect_equal(length(paren_match@nodes), 1)
  
  bracket_match = rmd_select(original_ast, has_heading("Section [2]"))
  expect_equal(length(bracket_match@nodes), 1)
  
  brace_match = rmd_select(original_ast, has_heading("Section {3}"))
  expect_equal(length(brace_match@nodes), 1)
  
  dot_match = rmd_select(original_ast, has_heading("Section .4"))
  expect_equal(length(dot_match@nodes), 1)
  
  # Test with glob patterns containing these characters
  section_pattern = rmd_select(original_ast, has_heading("Section*"))
  expect_equal(length(section_pattern@nodes), 6)  # All should match
})

test_that("has_heading preserves node order", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Z Section", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_heading(name = "A Section", level = 2L),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "M Section", level = 1L)
    )
  )
  
  # Should return headings in original document order, not alphabetical
  all_sections = rmd_select(original_ast, has_heading("* Section"))
  
  expect_equal(length(all_sections@nodes), 3)
  names = rmd_node_attr(all_sections, "name")
  expect_equal(unlist(names), c("Z Section", "A Section", "M Section"))
})

test_that("has_heading works with complex nested glob patterns", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Exercise 1.1: Basic Operations", level = 2L),
      rmd_heading(name = "Exercise 1.2: Advanced Topics", level = 2L),
      rmd_heading(name = "Exercise 2.1: Data Analysis", level = 2L),
      rmd_heading(name = "Problem 1: Simple", level = 2L),
      rmd_heading(name = "Problem 2: Complex", level = 2L),
      rmd_heading(name = "Review", level = 1L)
    )
  )
  
  # Test complex patterns
  exercise_1_pattern = rmd_select(original_ast, has_heading("Exercise 1.*"))
  expect_equal(length(exercise_1_pattern@nodes), 2)
  
  numbered_pattern = rmd_select(original_ast, has_heading("* 1*"))
  expect_equal(length(numbered_pattern@nodes), 3)  # Exercise 1.1, 1.2, and Problem 1
  
  colon_pattern = rmd_select(original_ast, has_heading("*: *"))
  expect_equal(length(colon_pattern@nodes), 5)  # All exercises and problems have colons
})