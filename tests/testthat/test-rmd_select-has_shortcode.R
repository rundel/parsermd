test_that("has_shortcode works with any shortcode", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Some text with {{< video https://example.com >}} shortcode"),
      rmd_markdown(lines = "Plain text without shortcodes"),
      rmd_chunk(engine = "r", name = "code", code = "# {{< include file.R >}}"),
      rmd_markdown(lines = "Text with {{< callout-note >}} content {{< /callout-note >}}")
    )
  )
  

  shortcode_subset = rmd_select(original_ast, has_shortcode())
  

  expected_subset = original_ast[c(1, 3, 4)]
  
  expect_equal(shortcode_subset, expected_subset)
})

test_that("has_shortcode works with specific function name", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Video: {{< video https://example.com >}}"),
      rmd_markdown(lines = "Include: {{< include data.csv >}}"),
      rmd_markdown(lines = "Another video: {{< video https://other.com >}}"),
      rmd_markdown(lines = "No shortcodes here")
    )
  )
  

  video_subset = rmd_select(original_ast, has_shortcode("video"))
  

  expected_subset = original_ast[c(1, 3)]
  
  expect_equal(video_subset, expected_subset)
})

test_that("has_shortcode works with multiple function names", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< callout-note >}} Important note {{< /callout-note >}}"),
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "{{< include script.R >}}"),
      rmd_markdown(lines = "{{< callout-warning >}} Warning text {{< /callout-warning >}}"),
      rmd_markdown(lines = "Plain text")
    )
  )
  

  multi_subset = rmd_select(original_ast, has_shortcode(c("callout-note", "video", "callout-warning")))
  

  expected_subset = original_ast[c(1, 2, 4)]
  
  expect_equal(multi_subset, expected_subset)
})

test_that("has_shortcode works with glob patterns", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< callout-note >}} Note text {{< /callout-note >}}"),
      rmd_markdown(lines = "{{< callout-warning >}} Warning text {{< /callout-warning >}}"),
      rmd_markdown(lines = "{{< callout-tip >}} Tip text {{< /callout-tip >}}"),
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "No shortcodes")
    )
  )
  

  callout_subset = rmd_select(original_ast, has_shortcode("callout-*"))
  

  expected_subset = original_ast[c(1, 2, 3)]
  
  expect_equal(callout_subset, expected_subset)
})

test_that("has_shortcode returns empty when no matches", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< video demo.mp4 >}}"),
      rmd_markdown(lines = "Plain text"),
      rmd_chunk(engine = "r", name = "code", code = "analysis()")
    )
  )
  

  result = rmd_select(original_ast, has_shortcode("nonexistent"))
  

  expected_empty = original_ast[integer(0)]
  
  expect_equal(result, expected_empty)
})

test_that("has_shortcode works across different node types", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Markdown with {{< include data.R >}}"),
      rmd_chunk(engine = "r", name = "code", code = "# Code with {{< video demo.mp4 >}} comment"),
      rmd_heading(name = "Section", level = 1L),  # headings typically don't have shortcodes
      rmd_yaml(yaml = list(title = "Test"))  # yaml doesn't have shortcodes
    )
  )
  

  shortcode_subset = rmd_select(original_ast, has_shortcode(), keep_yaml = FALSE)
  

  expected_subset = original_ast[c(1, 2)]
  
  expect_equal(shortcode_subset, expected_subset)
})

test_that("has_shortcode validates input", {

  expect_snapshot_error(has_shortcode(123))
  expect_snapshot_error(has_shortcode(character(0)))
  expect_snapshot_error(has_shortcode(c("valid", NA)))
})

test_that("has_shortcode works with complex shortcode syntax", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< video https://example.com width=800 height=600 >}}"),
      rmd_markdown(lines = "{{< include file.R echo=true eval=false >}}"),
      rmd_markdown(lines = "Nested: {{< div class='special' >}} content {{< /div >}}"),
      rmd_markdown(lines = "Multiple in one: {{< video a.mp4 >}} and {{< include b.R >}}")
    )
  )
  

  video_subset = rmd_select(original_ast, has_shortcode("video"))
  

  expected_subset = original_ast[c(1, 4)]
  
  expect_equal(video_subset, expected_subset)
})

test_that("has_shortcode works with empty AST", {

  empty_ast = rmd_ast(nodes = list())
  

  result = rmd_select(empty_ast, has_shortcode("video"))
  
  expect_equal(result, empty_ast)
})