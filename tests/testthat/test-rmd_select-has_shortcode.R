test_that("has_shortcode works with any shortcode", {
  # Create test AST with nodes containing shortcodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Some text with {{< video https://example.com >}} shortcode"),
      rmd_markdown(lines = "Plain text without shortcodes"),
      rmd_chunk(engine = "r", name = "code", code = "# {{< include file.R >}}"),
      rmd_markdown(lines = "Text with {{< callout-note >}} content {{< /callout-note >}}")
    )
  )
  
  # Test selecting any nodes with shortcodes
  shortcode_subset = rmd_select(original_ast, has_shortcode())
  
  # Expected result: nodes with shortcodes (positions 1, 3, 4)
  expected_subset = original_ast[c(1, 3, 4)]
  
  expect_equal(shortcode_subset, expected_subset)
})

test_that("has_shortcode works with specific function name", {
  # Create test AST with different shortcode types
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Video: {{< video https://example.com >}}"),
      rmd_markdown(lines = "Include: {{< include data.csv >}}"),
      rmd_markdown(lines = "Another video: {{< video https://other.com >}}"),
      rmd_markdown(lines = "No shortcodes here")
    )
  )
  
  # Test selecting only video shortcodes
  video_subset = rmd_select(original_ast, has_shortcode("video"))
  
  # Expected result: nodes with video shortcodes (positions 1, 3)
  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(video_subset, expected_subset)
})

test_that("has_shortcode works with multiple function names", {
  # Create test AST with various shortcode types
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< callout-note >}} Important note {{< /callout-note >}}"),
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "{{< include script.R >}}"),
      rmd_markdown(lines = "{{< callout-warning >}} Warning text {{< /callout-warning >}}"),
      rmd_markdown(lines = "Plain text")
    )
  )
  
  # Test selecting callout and video shortcodes
  multi_subset = rmd_select(original_ast, has_shortcode(c("callout-note", "video", "callout-warning")))
  
  # Expected result: nodes with specified shortcodes (positions 1, 2, 4)
  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_shortcode works with glob patterns", {
  # Create test AST with callout shortcodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< callout-note >}} Note text {{< /callout-note >}}"),
      rmd_markdown(lines = "{{< callout-warning >}} Warning text {{< /callout-warning >}}"),
      rmd_markdown(lines = "{{< callout-tip >}} Tip text {{< /callout-tip >}}"),
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "No shortcodes")
    )
  )
  
  # Test selecting all callout types with glob pattern
  callout_subset = rmd_select(original_ast, has_shortcode("callout-*"))
  
  # Expected result: all callout nodes (positions 1, 2, 3)
  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(callout_subset, expected_subset)
})

test_that("has_shortcode returns empty when no matches", {
  # Create test AST without target shortcodes
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "Plain text"),
      rmd_chunk(engine = "r", name = "code", code = "analysis()")
    )
  )
  
  # Test with non-existent shortcode function
  result = rmd_select(original_ast, has_shortcode("nonexistent"))
  
  # Expected empty AST
  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_shortcode works across different node types", {
  # Create test AST with shortcodes in different node types
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Markdown with {{< include data.R >}}"),
      rmd_chunk(engine = "r", name = "code", code = "# Code with {{< video demo.mp4 >}} comment"),
      rmd_heading(name = "Section", level = 1L),  # headings typically don't have shortcodes
      rmd_yaml(yaml = list(title = "Test"))  # yaml doesn't have shortcodes
    )
  )
  
  # Test selecting nodes with any shortcodes
  shortcode_subset = rmd_select(original_ast, has_shortcode(), keep_yaml = FALSE)
  
  # Expected result: markdown and chunk nodes with shortcodes (positions 1, 2)
  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(shortcode_subset, expected_subset)
})

test_that("has_shortcode validates input", {
  # Test input validation
  expect_snapshot_error(has_shortcode(123))
  expect_snapshot_error(has_shortcode(character(0)))
  expect_snapshot_error(has_shortcode(c("valid", NA)))
})

test_that("has_shortcode works with complex shortcode syntax", {
  # Create test AST with complex shortcode examples
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< video https://example.com width=800 height=600 >}}"),
      rmd_markdown(lines = "{{< include file.R echo=true eval=false >}}"),
      rmd_markdown(lines = "Nested: {{< div class='special' >}} content {{< /div >}}"),
      rmd_markdown(lines = "Multiple in one: {{< video a.mp4 >}} and {{< include b.R >}}")
    )
  )
  
  # Test selecting specific function with parameters
  video_subset = rmd_select(original_ast, has_shortcode("video"))
  
  # Expected result: nodes with video shortcodes (positions 1, 4)
  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(video_subset, expected_subset)
})

test_that("has_shortcode works with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test selection on empty AST
  result = rmd_select(empty_ast, has_shortcode("video"))
  
  expect_equal(result, empty_ast)
})