test_that("by_section works with simple section", {
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
  
  methods_subset = rmd_select(original_ast, by_section("Methods"), keep_yaml = FALSE)
  expected_subset = original_ast[c(4, 5, 6)]
  
  expect_equal(methods_subset, expected_subset)
})

test_that("by_section works with nested sections", {
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
  
  prep_subset = rmd_select(original_ast, by_section(c("Analysis", "Data Preparation")))
  expected_subset = original_ast[c(1, 3, 4)]
  
  expect_equal(prep_subset, expected_subset)
})

test_that("by_section works with glob patterns", {
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
  
  exercise_subset = rmd_select(original_ast, by_section("Exercise *"))
  expected_subset = original_ast[c(1, 2, 3, 4)]
  
  expect_equal(exercise_subset, expected_subset)
})

test_that("by_section with keep_parents = FALSE", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Main Section", level = 1L),
      rmd_markdown(lines = "Main intro"),
      rmd_heading(name = "Subsection", level = 2L),
      rmd_chunk(engine = "r", name = "code", code = "analysis()"),
      rmd_heading(name = "Other Section", level = 1L)
    )
  )
  
  sub_subset = rmd_select(original_ast, by_section(c("Main Section", "Subsection"), keep_parents = FALSE))
  expected_subset = original_ast[c(3, 4)]
  
  expect_equal(sub_subset, expected_subset)
})

test_that("by_section returns empty when no matches", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Introduction", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  result = rmd_select(original_ast, by_section("Nonexistent Section"))
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("by_section works with different heading levels", {
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
  
  deep_subset = rmd_select(original_ast, by_section(c("Chapter", "Section", "Subsection")))
  expected_subset = original_ast[c(1, 2, 3, 4)]
  
  expect_equal(deep_subset, expected_subset)
})

test_that("by_section validates input", {
  expect_snapshot_error(by_section(123))
  expect_snapshot_error(by_section(NULL))
  expect_snapshot_error(by_section(character(0)))
  expect_snapshot_error(by_section(c("valid", NA)))
  expect_snapshot_error(by_section("valid", keep_parents = "not_logical"))
})

test_that("by_section works with single level sections", {
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
  
  second_subset = rmd_select(original_ast, by_section("Second"))
  expected_subset = original_ast[c(4, 5)]
  
  expect_equal(second_subset, expected_subset)
})

test_that("by_section works with empty AST", {
  empty_ast = rmd_ast(nodes = list())
  result = rmd_select(empty_ast, by_section("Any Section"))
  
  expect_equal(result, empty_ast)
})