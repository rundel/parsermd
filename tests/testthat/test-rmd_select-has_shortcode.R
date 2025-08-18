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

test_that("has_shortcode handles case sensitivity correctly", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Lowercase: {{< video demo.mp4 >}}"),
      rmd_markdown(lines = "Uppercase: {{< VIDEO demo.mp4 >}}"),
      rmd_markdown(lines = "Mixed: {{< Video demo.mp4 >}}"),
      rmd_markdown(lines = "CamelCase: {{< videoPlayer demo.mp4 >}}"),
      rmd_markdown(lines = "No shortcode")
    )
  )
  
  # Function names are case-sensitive
  lowercase_match = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(length(lowercase_match@nodes), 1)  # Only lowercase
  
  uppercase_match = rmd_select(original_ast, has_shortcode("VIDEO"))
  expect_equal(length(uppercase_match@nodes), 1)  # Only uppercase
  
  mixed_match = rmd_select(original_ast, has_shortcode("Video"))
  expect_equal(length(mixed_match@nodes), 1)  # Only mixed case
  
  camel_match = rmd_select(original_ast, has_shortcode("videoPlayer"))
  expect_equal(length(camel_match@nodes), 1)  # Only camelCase
})

test_that("has_shortcode works with special characters in function names", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Hyphen: {{< callout-note >}} content {{< /callout-note >}}"),
      rmd_markdown(lines = "Underscore: {{< code_block lang='r' >}}"),
      rmd_markdown(lines = "Dot: {{< file.include path='data.csv' >}}"),
      rmd_markdown(lines = "Number: {{< html5-video src='demo.mp4' >}}"),
      rmd_markdown(lines = "Mixed: {{< my_custom-shortcode.v2 >}}")
    )
  )
  
  # Test exact matches with special characters
  hyphen_match = rmd_select(original_ast, has_shortcode("callout-note"))
  expect_equal(length(hyphen_match@nodes), 1)
  
  underscore_match = rmd_select(original_ast, has_shortcode("code_block"))
  expect_equal(length(underscore_match@nodes), 1)
  
  dot_match = rmd_select(original_ast, has_shortcode("file.include"))
  expect_equal(length(dot_match@nodes), 1)
  
  number_match = rmd_select(original_ast, has_shortcode("html5-video"))
  expect_equal(length(number_match@nodes), 1)
  
  # Test glob patterns with special characters
  hyphen_pattern = rmd_select(original_ast, has_shortcode("*-*"))
  expect_equal(length(hyphen_pattern@nodes), 3)  # callout-note, html5-video, my_custom-shortcode.v2
})

test_that("has_shortcode works with Unicode function names", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Spanish: {{< vídeo src='demo.mp4' >}}"),
      rmd_markdown(lines = "Chinese: {{< 视频 src='demo.mp4' >}}"),
      rmd_markdown(lines = "Greek: {{< βίντεο src='demo.mp4' >}}"),
      rmd_markdown(lines = "Arabic: {{< فيديو src='demo.mp4' >}}"),
      rmd_markdown(lines = "Regular: {{< video src='demo.mp4' >}}")
    )
  )
  
  # Test exact Unicode function matches
  spanish_match = rmd_select(original_ast, has_shortcode("vídeo"))
  expect_equal(length(spanish_match@nodes), 1)
  
  chinese_match = rmd_select(original_ast, has_shortcode("视频"))
  expect_equal(length(chinese_match@nodes), 1)
  
  greek_match = rmd_select(original_ast, has_shortcode("βίντεο"))
  expect_equal(length(greek_match@nodes), 1)
  
  # Test Unicode with glob patterns
  unicode_pattern = rmd_select(original_ast, has_shortcode("βί*"))
  expect_equal(length(unicode_pattern@nodes), 1)
})

test_that("has_shortcode works with multiple shortcodes per node", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Multiple videos: {{< video a.mp4 >}} and {{< video b.mp4 >}}"),
      rmd_markdown(lines = "Mixed types: {{< video demo.mp4 >}} and {{< include data.R >}}"),
      rmd_markdown(lines = "Three different: {{< video x.mp4 >}}, {{< callout-note >}} text {{< /callout-note >}}, {{< include y.R >}}"),
      rmd_markdown(lines = "Same function: {{< include a.R >}} and {{< include b.R >}} and {{< include c.R >}}"),
      rmd_markdown(lines = "No shortcodes")
    )
  )
  
  # Test nodes with video shortcodes
  video_matches = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(length(video_matches@nodes), 3)  # nodes 1, 2, 3
  
  # Test include shortcodes
  include_matches = rmd_select(original_ast, has_shortcode("include"))
  expect_equal(length(include_matches@nodes), 3)  # nodes 2, 3, 4
  
  # Test multiple patterns
  multi_matches = rmd_select(original_ast, has_shortcode(c("video", "callout-note")))
  expect_equal(length(multi_matches@nodes), 3)  # nodes with video or callout-note
})

test_that("has_shortcode works with very long function names", {
  long_function = paste(rep("very-long-shortcode-function-name", 5), collapse = "-")
  
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = paste0("Long: {{< ", long_function, " param='value' >}}")),
      rmd_markdown(lines = "Short: {{< video demo.mp4 >}}"),
      rmd_markdown(lines = paste0("Another long: {{< ", paste(rep("another-long", 4), collapse = "-"), " >}}"))
    )
  )
  
  # Test exact match with very long function name
  long_match = rmd_select(original_ast, has_shortcode(long_function))
  expect_equal(length(long_match@nodes), 1)
  
  # Test pattern matching with long names
  long_pattern = rmd_select(original_ast, has_shortcode("*long*"))
  expect_equal(length(long_pattern@nodes), 2)
})

test_that("has_shortcode works with numeric function names", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Number: {{< h1 >}} heading {{< /h1 >}}"),
      rmd_markdown(lines = "Decimal: {{< version-1.5 >}} info"),
      rmd_markdown(lines = "Scientific: {{< model-1e5 >}} data"),
      rmd_markdown(lines = "Mixed: {{< video-123 src='demo.mp4' >}}"),
      rmd_markdown(lines = "Leading zero: {{< step-001 >}} process")
    )
  )
  
  # Test numeric function names
  h1_match = rmd_select(original_ast, has_shortcode("h1"))
  expect_equal(length(h1_match@nodes), 1)
  
  version_match = rmd_select(original_ast, has_shortcode("version-1.5"))
  expect_equal(length(version_match@nodes), 1)
  
  scientific_match = rmd_select(original_ast, has_shortcode("model-1e5"))
  expect_equal(length(scientific_match@nodes), 1)
  
  # Test patterns with numbers
  number_pattern = rmd_select(original_ast, has_shortcode("*-1*"))
  expect_equal(length(number_pattern@nodes), 3)  # version-1.5, model-1e5, video-123
})

test_that("has_shortcode preserves node order", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Z video: {{< video z.mp4 >}}"),
      rmd_chunk(engine = "r", name = "code", code = "x <- 1"),
      rmd_markdown(lines = "A video: {{< video a.mp4 >}}"),
      rmd_heading(name = "Section", level = 1L),
      rmd_markdown(lines = "M video: {{< video m.mp4 >}}")
    )
  )

  video_matches = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(video_matches, original_ast[c(1, 3, 5)])
})

test_that("has_shortcode works with closing vs opening shortcodes", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Opening only: {{< video demo.mp4 >}}"),
      rmd_markdown(lines = "Paired: {{< callout-note >}} content {{< /callout-note >}}"),
      rmd_markdown(lines = "Multiple pairs: {{< div >}} text {{< /div >}} and {{< span >}} more {{< /span >}}"),
      rmd_markdown(lines = "Mixed: {{< video a.mp4 >}} and {{< callout-tip >}} tip {{< /callout-tip >}}")
    )
  )
  
  # Test matching opening shortcodes
  video_matches = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(length(video_matches@nodes), 2)  # nodes 1 and 4
  
  callout_matches = rmd_select(original_ast, has_shortcode("callout-note"))
  expect_equal(length(callout_matches@nodes), 1)  # node 2
  
  # Test pattern matching that could match opening or closing
  div_matches = rmd_select(original_ast, has_shortcode("div"))
  expect_equal(length(div_matches@nodes), 1)  # node 3
})

test_that("has_shortcode works with regex-like function names", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Dot: {{< test.function >}}"),
      rmd_markdown(lines = "Caret: {{< test^2 >}}"),
      rmd_markdown(lines = "Dollar: {{< test$end >}}"),
      rmd_markdown(lines = "Parentheses: {{< test(1) >}}"),
      rmd_markdown(lines = "Plus: {{< test+more >}}"),
      rmd_markdown(lines = "Brackets: {{< test[key] >}}")
    )
  )
  
  # These should be treated as literal characters, not regex
  dot_match = rmd_select(original_ast, has_shortcode("test.function"))
  expect_equal(length(dot_match@nodes), 1)
  
  caret_match = rmd_select(original_ast, has_shortcode("test\\^2"))
  expect_equal(length(caret_match@nodes), 1)
  
  dollar_match = rmd_select(original_ast, has_shortcode("test\\$end"))
  expect_equal(length(dollar_match@nodes), 1)
  
  # Test glob patterns with these characters
  test_pattern = rmd_select(original_ast, has_shortcode("test*"))
  expect_equal(length(test_pattern@nodes), 6)  # All should match
})

test_that("has_shortcode works with complex nested patterns", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "{{< div class='outer' >}} outer {{< div class='inner' >}} inner {{< /div >}} back to outer {{< /div >}}"),
      rmd_markdown(lines = "{{< callout-note >}} Note with {{< include data.R >}} inside {{< /callout-note >}}"),
      rmd_markdown(lines = "Multiple: {{< video a.mp4 >}} and {{< video b.mp4 >}} and {{< include x.R >}}"),
      rmd_markdown(lines = "Single: {{< simple-shortcode >}}")
    )
  )
  
  # Test matching nested content
  div_matches = rmd_select(original_ast, has_shortcode("div"))
  expect_equal(length(div_matches@nodes), 1)  # node 1 has nested divs
  
  # Test matching when functions are nested inside other shortcodes
  include_matches = rmd_select(original_ast, has_shortcode("include"))
  expect_equal(length(include_matches@nodes), 2)  # nodes 2 and 3
  
  # Test pattern matching across complexity
  video_pattern = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(length(video_pattern@nodes), 1)  # node 3 with multiple videos
})

test_that("has_shortcode works with similar function names", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Exact: {{< video demo.mp4 >}}"),
      rmd_markdown(lines = "Prefix: {{< video-player demo.mp4 >}}"),
      rmd_markdown(lines = "Suffix: {{< my-video demo.mp4 >}}"),
      rmd_markdown(lines = "Contains: {{< video-streaming-service demo.mp4 >}}"),
      rmd_markdown(lines = "Similar: {{< vimeo demo.mp4 >}}")
    )
  )
  
  # Exact match should only match exactly
  exact_match = rmd_select(original_ast, has_shortcode("video"))
  expect_equal(length(exact_match@nodes), 1)  # Only exact "video"
  
  # Pattern should match multiple
  video_pattern = rmd_select(original_ast, has_shortcode("*video*"))
  expect_equal(length(video_pattern@nodes), 4)  # All except vimeo
  
  # Specific patterns
  prefix_pattern = rmd_select(original_ast, has_shortcode("video-*"))
  expect_equal(length(prefix_pattern@nodes), 2)  # video-player and video-streaming-service
})

test_that("has_shortcode validates input comprehensively", {
  original_ast = rmd_ast(
    nodes = list(rmd_markdown(lines = "Test: {{< video demo.mp4 >}}"))
  )
  
  expect_snapshot_error(rmd_select(original_ast, has_shortcode(123)))
  expect_snapshot_error(rmd_select(original_ast, has_shortcode(character(0))))
  expect_snapshot_error(rmd_select(original_ast, has_shortcode("")))
  expect_snapshot_error(rmd_select(original_ast, has_shortcode(c("valid", NA))))
  expect_snapshot_error(rmd_select(original_ast, has_shortcode(c("video", ""))))
})