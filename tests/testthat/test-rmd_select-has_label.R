test_that("has_label works with single label", {
  # Create simple test AST with labeled chunks
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_chunk(engine = "r", label = "setup", code = "library(ggplot2)"),
      rmd_heading(name = "Section 1", level = 1L),
      rmd_chunk(engine = "r", label = "analysis", code = "plot(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting chunk with specific label
  setup_subset = rmd_select(original_ast, has_label("setup"), keep_yaml = FALSE)
  
  # Expected result: setup chunk at position 2
  expected_subset = original_ast[2]
  
  expect_equal(setup_subset, expected_subset)
})

test_that("has_label works with glob patterns", {
  # Create test AST with pattern-matching labels
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "plot-cars", code = "plot(cars)"),
      rmd_chunk(engine = "r", label = "plot-iris", code = "plot(iris)"),
      rmd_chunk(engine = "r", label = "analysis", code = "summary(cars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting chunks with pattern "plot-*"
  plot_subset = rmd_select(original_ast, has_label("plot-*"))
  
  # Expected result: both plot chunks at positions 1 and 2
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(plot_subset, expected_subset)
})

test_that("has_label works with multiple labels", {
  # Create test AST with various labels
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", label = "load-data", code = "data(mtcars)"),
      rmd_chunk(engine = "r", label = "analysis", code = "summary(mtcars)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test selecting multiple specific labels
  subset_result = rmd_select(original_ast, has_label(c("setup", "analysis")))
  
  # Expected result: setup and analysis chunks at positions 1 and 3
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(subset_result, expected_subset)
})

test_that("has_label returns empty when no matches", {
  # Create test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "setup", code = "library(ggplot2)"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with non-existent label
  result = rmd_select(original_ast, has_label("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_label works with unlabeled nodes", {
  # Create test AST with mix of labeled and unlabeled chunks
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "setup", code = "library(ggplot2)"),
      rmd_chunk(engine = "r", label = "", code = "plot(cars)"),  # unlabeled
      rmd_heading(name = "Section", level = 1L),  # headings don't have labels in same way
      rmd_chunk(engine = "r", label = "analysis", code = "summary(cars)")
    )
  )
  
  # Test selecting labeled chunks only
  labeled_subset = rmd_select(original_ast, has_label(c("setup", "analysis")))
  
  # Expected result: setup and analysis chunks at positions 1 and 4
  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(labeled_subset, expected_subset)
})

test_that("has_label validates input", {
  # Test that has_label requires character input with minimum length
  expect_snapshot_error(has_label(123))
  expect_snapshot_error(has_label(NULL))
  expect_snapshot_error(has_label(character(0)))
  expect_snapshot_error(has_label(c("valid", NA)))
})

test_that("has_label works with complex glob patterns", {
  # Create test AST with various label patterns
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "fig-scatter", code = "plot(x, y)"),
      rmd_chunk(engine = "r", label = "fig-histogram", code = "hist(x)"),
      rmd_chunk(engine = "r", label = "tbl-summary", code = "summary(df)"),
      rmd_chunk(engine = "r", label = "fig-boxplot", code = "boxplot(x)")
    )
  )
  
  # Test selecting all figure chunks with "fig-*" pattern
  fig_subset = rmd_select(original_ast, has_label("fig-*"))
  
  # Expected result: all fig chunks at positions 1, 2, and 4
  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(fig_subset, expected_subset)
  
  # Verify the correct labels were selected
  expect_equal(
    rmd_node_attr(fig_subset, "label"),
    list("fig-scatter", "fig-histogram", "fig-boxplot")
  )
})

test_that("has_label works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_label("any-label"))
  
  expect_equal(result, empty_ast)
})

test_that("has_label works with special characters in labels", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "data-prep_v1", code = "clean()"),
      rmd_chunk(engine = "r", label = "plot.scatter", code = "plot()"),
      rmd_chunk(engine = "r", label = "analysis#1", code = "analyze()"),
      rmd_chunk(engine = "r", label = "model@final", code = "fit()"),
      rmd_chunk(engine = "r", label = "output (revised)", code = "print()"),
      rmd_chunk(engine = "r", label = "test[key]", code = "test()")
    )
  )
  
  # Test exact matches with special characters
  underscore_match = rmd_select(original_ast, has_label("data-prep_v1"))
  expect_equal(length(underscore_match@nodes), 1)
  
  dot_match = rmd_select(original_ast, has_label("plot.scatter"))
  expect_equal(length(dot_match@nodes), 1)
  
  hash_match = rmd_select(original_ast, has_label("analysis#1"))
  expect_equal(length(hash_match@nodes), 1)
  
  at_match = rmd_select(original_ast, has_label("model@final"))
  expect_equal(length(at_match@nodes), 1)
  
  paren_match = rmd_select(original_ast, has_label("output (revised)"))
  expect_equal(length(paren_match@nodes), 1)
  
  bracket_match = rmd_select(original_ast, has_label("test[key]"))
  expect_equal(length(bracket_match@nodes), 1)
  
  # Test glob patterns with special characters
  special_pattern = rmd_select(original_ast, has_label("*#*"))
  expect_equal(length(special_pattern@nodes), 1)  # analysis#1
  
  underscore_pattern = rmd_select(original_ast, has_label("*_*"))
  expect_equal(length(underscore_pattern@nodes), 1)  # data-prep_v1
})

test_that("has_label works with Unicode characters", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "análisis-datos", code = "analyze()"),
      rmd_chunk(engine = "r", label = "测试", code = "test()"),
      rmd_chunk(engine = "r", label = "αρχή", code = "start()"),
      rmd_chunk(engine = "r", label = "مثال", code = "example()"),
      rmd_chunk(engine = "r", label = "regular-label", code = "process()")
    )
  )
  
  # Test exact Unicode matches
  spanish_match = rmd_select(original_ast, has_label("análisis-datos"))
  expect_equal(length(spanish_match@nodes), 1)
  
  chinese_match = rmd_select(original_ast, has_label("测试"))
  expect_equal(length(chinese_match@nodes), 1)
  
  greek_match = rmd_select(original_ast, has_label("αρχή"))
  expect_equal(length(greek_match@nodes), 1)
  
  # Test Unicode with glob patterns
  unicode_pattern = rmd_select(original_ast, has_label("αρ*"))
  expect_equal(length(unicode_pattern@nodes), 1)
})

test_that("has_label handles case sensitivity correctly", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "Setup", code = "setup()"),
      rmd_chunk(engine = "r", label = "SETUP", code = "SETUP()"),
      rmd_chunk(engine = "r", label = "setup", code = "setup()"),
      rmd_chunk(engine = "r", label = "SetUp", code = "SetUp()")
    )
  )
  
  # Labels are case-sensitive
  exact_case = rmd_select(original_ast, has_label("Setup"))
  expect_equal(length(exact_case@nodes), 1)
  
  upper_case = rmd_select(original_ast, has_label("SETUP"))
  expect_equal(length(upper_case@nodes), 1)
  
  lower_case = rmd_select(original_ast, has_label("setup"))
  expect_equal(length(lower_case@nodes), 1)
  
  mixed_case = rmd_select(original_ast, has_label("SetUp"))
  expect_equal(length(mixed_case@nodes), 1)
})

test_that("has_label works with very long labels", {
  long_label = paste(rep("very-long-chunk-label", 10), collapse = "-")
  
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = long_label, code = "process()"),
      rmd_chunk(engine = "r", label = "short", code = "quick()"),
      rmd_chunk(engine = "r", label = paste(rep("another-long", 8), collapse = "-"), code = "analyze()")
    )
  )
  
  # Test exact match with very long label
  long_match = rmd_select(original_ast, has_label(long_label))
  expect_equal(length(long_match@nodes), 1)
  
  # Test pattern matching
  long_pattern = rmd_select(original_ast, has_label("*long*"))
  expect_equal(length(long_pattern@nodes), 2)
})

test_that("has_label works with numeric-like labels", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "123", code = "test1()"),
      rmd_chunk(engine = "r", label = "1.5", code = "test2()"),
      rmd_chunk(engine = "r", label = "0001", code = "test3()"),
      rmd_chunk(engine = "r", label = "1e5", code = "test4()"),
      rmd_chunk(engine = "r", label = "label-123", code = "test5()")
    )
  )
  
  # Test exact numeric matches
  integer_match = rmd_select(original_ast, has_label("123"))
  expect_equal(length(integer_match@nodes), 1)
  
  decimal_match = rmd_select(original_ast, has_label("1.5"))
  expect_equal(length(decimal_match@nodes), 1)
  
  # Test patterns with numbers
  number_pattern = rmd_select(original_ast, has_label("*123*"))
  expect_equal(length(number_pattern@nodes), 2)  # "123" and "label-123"
})

test_that("has_label works with empty string labels", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "", code = "test1()"),
      rmd_chunk(engine = "r", label = "labeled", code = "test2()"),
      rmd_chunk(engine = "r", label = "", code = "test3()")
    )
  )
  
  # Test matching empty labels
  empty_match = rmd_select(original_ast, has_label(""))
  expect_equal(length(empty_match@nodes), 2)
  
  # Test non-empty labels
  labeled_match = rmd_select(original_ast, has_label("labeled"))
  expect_equal(length(labeled_match@nodes), 1)
})

test_that("has_label works with different node types", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "chunk-label", code = "test()"),
      rmd_raw_chunk(format = "html", code = "raw content"),  # raw chunks don't have labels
      rmd_heading(name = "Section", level = 1L),  # headings use name, not label
      rmd_markdown(lines = "Text")  # markdown has no labels
    )
  )
  
  # Only chunks with labels should match
  chunk_match = rmd_select(original_ast, has_label("chunk-label"))
  expect_equal(length(chunk_match@nodes), 1)
  expect_equal(rmd_node_type(chunk_match@nodes[[1]]), "rmd_chunk")
  
  # No matches for non-chunk nodes
  no_match = rmd_select(original_ast, has_label("Section"))
  expect_equal(length(no_match@nodes), 0)
})

test_that("has_label preserves node order", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "z-chunk", code = "z()"),
      rmd_markdown(lines = "Text"),
      rmd_chunk(engine = "r", label = "a-chunk", code = "a()"),
      rmd_chunk(engine = "r", label = "m-chunk", code = "m()"),
      rmd_heading(name = "Section", level = 1L)
    )
  )
  
  # Should return chunks in original document order, not alphabetical
  all_chunks = rmd_select(original_ast, has_label("*-chunk"))
  
  expect_equal(length(all_chunks@nodes), 3)
  labels = rmd_node_attr(all_chunks, "label")
  expect_equal(unlist(labels), c("z-chunk", "a-chunk", "m-chunk"))
})

test_that("has_label works with regex-like characters as literals", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test.func", code = "test()"),
      rmd_chunk(engine = "r", label = "test^2", code = "power()"),
      rmd_chunk(engine = "r", label = "test$end", code = "final()"),
      rmd_chunk(engine = "r", label = "test(1)", code = "call()"),
      rmd_chunk(engine = "r", label = "test+more", code = "add()")
    )
  )
  
  # These should be treated as literal characters, not regex
  dot_match = rmd_select(original_ast, has_label("test.func"))
  expect_equal(length(dot_match@nodes), 1)
  
  caret_match = rmd_select(original_ast, has_label("test\\^2"))
  expect_equal(length(caret_match@nodes), 1)
  
  dollar_match = rmd_select(original_ast, has_label("test\\$end"))
  expect_equal(length(dollar_match@nodes), 1)
  
  paren_match = rmd_select(original_ast, has_label("test(1)"))
  expect_equal(length(paren_match@nodes), 1)
  
  plus_match = rmd_select(original_ast, has_label("test\\+more"))
  expect_equal(length(plus_match@nodes), 1)
  
  # Test glob patterns with these characters
  test_pattern = rmd_select(original_ast, has_label("test*"))
  expect_equal(length(test_pattern@nodes), 5)  # All should match
})

test_that("has_label works with mixed pattern complexity", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "fig-scatter-plot", code = "scatter()"),
      rmd_chunk(engine = "r", label = "fig-histogram-data", code = "hist()"),
      rmd_chunk(engine = "r", label = "tbl-summary-stats", code = "summary()"),
      rmd_chunk(engine = "r", label = "fig-boxplot-comparison", code = "boxplot()"),
      rmd_chunk(engine = "r", label = "model-linear-regression", code = "lm()"),
      rmd_chunk(engine = "r", label = "data-preprocessing", code = "clean()")
    )
  )
  
  # Test multiple complex patterns
  fig_patterns = rmd_select(original_ast, has_label(c("fig-*-plot", "fig-*-data")))
  expect_equal(length(fig_patterns@nodes), 2)  # scatter-plot and histogram-data
  
  # Test very specific pattern
  specific_pattern = rmd_select(original_ast, has_label("*-*-*"))
  expect_equal(length(specific_pattern@nodes), 5)  # All except "data-preprocessing"
  
  # Test ending pattern
  ending_pattern = rmd_select(original_ast, has_label("*-stats"))
  expect_equal(length(ending_pattern@nodes), 1)  # tbl-summary-stats
})