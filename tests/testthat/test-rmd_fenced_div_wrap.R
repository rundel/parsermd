test_that("rmd_fenced_div_wrap basic functionality works", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Wrap middle two chunks
  wrapped = rmd_fenced_div_wrap(original_ast, "test1":"test2")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap works with type selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  # This should fail because chunks are not continuous
  expect_snapshot_error(
    rmd_fenced_div_wrap(original_ast, has_type("rmd_chunk"))
  )
})

test_that("rmd_fenced_div_wrap allows multiple discontinuous ranges", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  # Should work with allow_multiple = TRUE
  wrapped = rmd_fenced_div_wrap(original_ast, has_type("rmd_chunk"), allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap works with custom fenced div", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  custom_open = rmd_fenced_div_open(
    classes = c(".note", ".warning"),
    attr = c("data-type" = "example")
  )
  
  wrapped = rmd_fenced_div_wrap(original_ast, "test", open = custom_open)
  
  expected_ast = rmd_ast(
    nodes = list(
      custom_open,
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap handles empty selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select chunks that don't exist
  wrapped = rmd_fenced_div_wrap(original_ast, has_type("rmd_chunk"))
  
  # Should be unchanged
  expect_equal(wrapped, original_ast)
})

test_that("rmd_fenced_div_wrap handles single node selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  wrapped = rmd_fenced_div_wrap(original_ast, "test")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap wraps entire AST", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select all nodes by position
  wrapped = rmd_fenced_div_wrap(original_ast, 1:3)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(),
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap wraps first nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select first two nodes
  wrapped = rmd_fenced_div_wrap(original_ast, 1:2)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(),
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap wraps last nodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select last two nodes
  wrapped = rmd_fenced_div_wrap(original_ast, 2:3)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap handles complex discontinuous selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),       # 1
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"), # 2
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"), # 3
      rmd_markdown(lines = "Text 1"),                # 4
      rmd_chunk(engine = "r", label = "test3", code = "3 + 3"), # 5
      rmd_markdown(lines = "Text 2"),                # 6
      rmd_chunk(engine = "r", label = "test4", code = "4 + 4")  # 7
    )
  )
  
  # Select indices 2, 3, 5, 7 (two continuous ranges: 2-3 and single nodes 5, 7)
  wrapped = rmd_fenced_div_wrap(original_ast, c(2, 3, 5, 7), allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Text 1"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test3", code = "3 + 3"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Text 2"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", label = "test4", code = "4 + 4"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap error handling for discontinuous ranges", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  # Should provide helpful error message
  expect_snapshot_error(
    rmd_fenced_div_wrap(original_ast, c(1, 3))
  )
})

test_that("rmd_fenced_div_wrap validates arguments", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test", code = "1 + 1")
    )
  )
  
  # Invalid open argument
  expect_snapshot_error(
    rmd_fenced_div_wrap(original_ast, open = "invalid", "test")
  )
  
  # Invalid allow_multiple argument
  expect_snapshot_error(
    rmd_fenced_div_wrap(original_ast, "test", allow_multiple = "invalid")
  )
})

test_that("rmd_fenced_div_wrap handles unsupported types", {
  expect_snapshot_error(
    rmd_fenced_div_wrap("not_rmd_object")
  )
  
  expect_snapshot_error(
    rmd_fenced_div_wrap(list(nodes = "invalid"))
  )
})

test_that("detect_continuous_ranges helper function works", {
  # Single range
  expect_equal(detect_continuous_ranges(c(1, 2, 3)), list(c(1, 3)))
  
  # Two ranges
  expect_equal(detect_continuous_ranges(c(1, 2, 4, 5)), list(c(1, 2), c(4, 5)))
  
  # Single isolated nodes
  expect_equal(detect_continuous_ranges(c(1, 3, 5)), list(c(1, 1), c(3, 3), c(5, 5)))
  
  # Empty input
  expect_equal(detect_continuous_ranges(integer(0)), list())
  
  # Single node
  expect_equal(detect_continuous_ranges(5), list(c(5, 5)))
  
  # Unordered input (should be sorted)
  expect_equal(detect_continuous_ranges(c(3, 1, 2, 5)), list(c(1, 3), c(5, 5)))
})

test_that("is_continuous_range helper function works", {
  # Continuous ranges
  expect_true(is_continuous_range(c(1, 2, 3)))
  expect_true(is_continuous_range(c(5, 6)))
  expect_true(is_continuous_range(5))
  expect_true(is_continuous_range(integer(0)))
  
  # Discontinuous ranges
  expect_false(is_continuous_range(c(1, 3, 5)))
  expect_false(is_continuous_range(c(1, 2, 4)))
  
  # Unordered but continuous
  expect_true(is_continuous_range(c(3, 1, 2)))
})

test_that("rmd_fenced_div_wrap works with complex selections", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "setup", code = "library(ggplot2)"),
      rmd_markdown(lines = "Introduction text"),
      rmd_chunk(engine = "r", label = "plot", code = "plot(1:10)"),
      rmd_heading(name = "Section 2", level = 1L),
      rmd_chunk(engine = "r", label = "analysis", code = "summary(data)")
    )
  )
  
  # Wrap the first two chunks (setup and plot)
  wrapped = rmd_fenced_div_wrap(
    original_ast, 
    "setup", "plot",
    allow_multiple = TRUE
  )
  
  # Should wrap setup and plot chunks separately since they're not continuous
  expect_equal(length(wrapped@nodes), 11) # 7 original + 4 fenced div nodes
  expect_true(S7::S7_inherits(wrapped@nodes[[3]], rmd_fenced_div_open))
  expect_true(S7::S7_inherits(wrapped@nodes[[5]], rmd_fenced_div_close))
  expect_true(S7::S7_inherits(wrapped@nodes[[7]], rmd_fenced_div_open))
  expect_true(S7::S7_inherits(wrapped@nodes[[9]], rmd_fenced_div_close))
})

# Edge case tests for section-based wrapping and tree printing
test_that("rmd_fenced_div_wrap preserves section selection balance after wrapping", {
  hw = system.file("examples/hw01.Rmd", package = "parsermd")
  rmd = parse_rmd(hw)
  
  # Wrap Exercise 1 section
  rmd_wrap = rmd |>
    rmd_fenced_div_wrap(
      by_section("Exercise 1"),
      open = rmd_fenced_div_open(classes = ".callout-warning", id = "#test-callout")
    )
  
  # Should be able to select the same section after wrapping without errors
  expect_no_error({
    result = rmd_wrap |> rmd_select(by_section("Exercise 1"))
  })
  
  # The result should include both fenced div tags
  result = rmd_wrap |> rmd_select(by_section("Exercise 1"))
  result_types = rmd_node_type(result)
  
  expect_true("rmd_fenced_div_open" %in% result_types)
  expect_true("rmd_fenced_div_close" %in% result_types)
  
  # Should be balanced
  open_count = sum(result_types == "rmd_fenced_div_open")
  close_count = sum(result_types == "rmd_fenced_div_close")
  expect_equal(open_count, close_count)
})

test_that("rmd_fenced_div_wrap handles multiple non-overlapping sections", {
  hw = system.file("examples/hw01.Rmd", package = "parsermd")
  rmd = parse_rmd(hw)
  
  # Wrap multiple sections
  rmd_wrap = rmd |>
    rmd_fenced_div_wrap(
      by_section("Exercise 1"),
      open = rmd_fenced_div_open(classes = ".callout-warning")
    ) |>
    rmd_fenced_div_wrap(
      by_section("Exercise 2"),
      open = rmd_fenced_div_open(classes = ".callout-note")
    )
  
  # Both sections should be selectable
  expect_no_error({
    ex1_result = rmd_wrap |> rmd_select(by_section("Exercise 1"))
    ex2_result = rmd_wrap |> rmd_select(by_section("Exercise 2"))
  })
  
  ex1_result = rmd_wrap |> rmd_select(by_section("Exercise 1"))
  ex2_result = rmd_wrap |> rmd_select(by_section("Exercise 2"))
  
  # Each should have balanced fenced divs
  ex1_types = rmd_node_type(ex1_result)
  ex2_types = rmd_node_type(ex2_result)
  
  expect_equal(sum(ex1_types == "rmd_fenced_div_open"), 
               sum(ex1_types == "rmd_fenced_div_close"))
  expect_equal(sum(ex2_types == "rmd_fenced_div_open"), 
               sum(ex2_types == "rmd_fenced_div_close"))
  
  # Check that different classes were used
  expect_true(any(grepl("callout-warning", capture.output(print(ex1_result)))))
  expect_true(any(grepl("callout-note", capture.output(print(ex2_result)))))
})

test_that("rmd_fenced_div_wrap section assignments are consistent", {
  hw = system.file("examples/hw01.Rmd", package = "parsermd")
  rmd = parse_rmd(hw)
  
  rmd_wrap = rmd |>
    rmd_fenced_div_wrap(
      by_section("Exercise 1"),
      open = rmd_fenced_div_open(classes = ".test")
    )
  
  # Get section assignments
  sections = rmd_node_sections(rmd_wrap, drop_na = TRUE)
  types = rmd_node_type(rmd_wrap)
  
  # Find the open and close div positions
  open_idx = which(types == "rmd_fenced_div_open")
  close_idx = which(types == "rmd_fenced_div_close")
  
  expect_length(open_idx, 1)
  expect_length(close_idx, 1)
  
  # Both should be assigned to Exercise 1 section
  open_section = paste(sections[[open_idx]], collapse = " > ")
  close_section = paste(sections[[close_idx]], collapse = " > ")
  
  expect_true(grepl("Exercise 1", open_section))
  expect_true(grepl("Exercise 1", close_section))
  
  # They should have the same section assignment
  expect_equal(sections[[open_idx]], sections[[close_idx]])
})

test_that("rmd_fenced_div_wrap handles nested fenced divs correctly", {
  # Create a custom AST with content to wrap
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_markdown(lines = "Section 1 content"),
      rmd_heading(name = "Section 2", level = 1L),
      rmd_markdown(lines = "Section 2 content")
    )
  )
  
  # First wrap Section 1
  wrapped_once = original_ast |>
    rmd_fenced_div_wrap(
      by_section("Section 1"),
      open = rmd_fenced_div_open(classes = ".outer")
    )
  
  # Then wrap the markdown content specifically (creating nested divs)
  wrapped_nested = wrapped_once |>
    rmd_fenced_div_wrap(
      has_type("rmd_markdown") & by_section("Section 1"),
      open = rmd_fenced_div_open(classes = ".inner")
    )
  
  types = rmd_node_type(wrapped_nested)
  
  # Should have 2 opens and 2 closes
  expect_equal(sum(types == "rmd_fenced_div_open"), 2)
  expect_equal(sum(types == "rmd_fenced_div_close"), 2)
  
  # Tree should show proper nesting
  tree_output = capture.output(print(wrapped_nested))
  
  # Should have nested structure visible in tree
  expect_true(any(grepl("Fenced div \\(open\\).*outer", tree_output)))
  expect_true(any(grepl("Fenced div \\(open\\).*inner", tree_output)))
})

test_that("rmd_fenced_div_wrap handles empty sections gracefully", {
  # Create AST with empty section (no content between headings)
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Empty Section", level = 1L),
      rmd_heading(name = "Next Section", level = 1L),
      rmd_markdown(lines = "Content")
    )
  )
  
  # Wrap empty section
  wrapped = original_ast |>
    rmd_fenced_div_wrap(
      by_section("Empty Section"),
      open = rmd_fenced_div_open(classes = ".empty-wrap")
    )
  
  types = rmd_node_type(wrapped)
  
  # Should have balanced fenced divs even for empty section
  expect_equal(sum(types == "rmd_fenced_div_open"), 1)
  expect_equal(sum(types == "rmd_fenced_div_close"), 1)
  
  # Should be able to select the wrapped empty section
  expect_no_error({
    result = wrapped |> rmd_select(by_section("Empty Section"))
  })
  
  # Result should include the heading and both fenced div tags
  result = wrapped |> rmd_select(by_section("Empty Section"))
  result_types = rmd_node_type(result)
  
  expect_true("rmd_heading" %in% result_types)
  expect_true("rmd_fenced_div_open" %in% result_types)
  expect_true("rmd_fenced_div_close" %in% result_types)
})