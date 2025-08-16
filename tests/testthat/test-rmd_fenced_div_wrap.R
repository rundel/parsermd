test_that("rmd_fenced_div_wrap basic functionality works", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Wrap middle two chunks
  wrapped = rmd_fenced_div_wrap(original_ast, "test1":"test2")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2"),
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
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2")
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
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2")
    )
  )
  
  # Should work with allow_multiple = TRUE
  wrapped = rmd_fenced_div_wrap(original_ast, has_type("rmd_chunk"), allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Some text"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap works with custom fenced div", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  wrapped = rmd_fenced_div_wrap(original_ast, "test")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select all nodes by position
  wrapped = rmd_fenced_div_wrap(original_ast, 1:3)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(),
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select first two nodes
  wrapped = rmd_fenced_div_wrap(original_ast, 1:2)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_fenced_div_open(),
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select last two nodes
  wrapped = rmd_fenced_div_wrap(original_ast, 2:3)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
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
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"), # 2
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2"), # 3
      rmd_markdown(lines = "Text 1"),                # 4
      rmd_chunk(engine = "r", name = "test3", code = "3 + 3"), # 5
      rmd_markdown(lines = "Text 2"),                # 6
      rmd_chunk(engine = "r", name = "test4", code = "4 + 4")  # 7
    )
  )
  
  # Select indices 2, 3, 5, 7 (two continuous ranges: 2-3 and single nodes 5, 7)
  wrapped = rmd_fenced_div_wrap(original_ast, c(2, 3, 5, 7), allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Text 1"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test3", code = "3 + 3"),
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Text 2"),
      rmd_fenced_div_open(),
      rmd_chunk(engine = "r", name = "test4", code = "4 + 4"),
      rmd_fenced_div_close()
    )
  )
  
  expect_equal(wrapped, expected_ast)
})

test_that("rmd_fenced_div_wrap error handling for discontinuous ranges", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2")
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
      rmd_chunk(engine = "r", name = "test", code = "1 + 1")
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
      rmd_chunk(engine = "r", name = "setup", code = "library(ggplot2)"),
      rmd_markdown(lines = "Introduction text"),
      rmd_chunk(engine = "r", name = "plot", code = "plot(1:10)"),
      rmd_heading(name = "Section 2", level = 1L),
      rmd_chunk(engine = "r", name = "analysis", code = "summary(data)")
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