test_that("Shortcode detection in text content", {
  
  # Test basic shortcode detection
  expect_true(rmd_has_shortcode("Hello {{< myfunc >}} world"))
  expect_false(rmd_has_shortcode("Hello world"))
  
  # Test multiple shortcodes
  expect_true(rmd_has_shortcode("{{< func1 >}} and {{< func2 >}}"))
  
  # Test shortcode with arguments
  expect_true(rmd_has_shortcode("{{< myfunc arg1 arg2 >}}"))
  expect_true(rmd_has_shortcode("{{< myfunc \"arg with spaces\" >}}"))
  
  # Test function name filtering
  expect_true(rmd_has_shortcode("{{< video url >}}", "video"))
  expect_false(rmd_has_shortcode("{{< pagebreak >}}", "video"))
  
  # Test glob patterns
  expect_true(rmd_has_shortcode("{{< video-embed >}}", "video*"))
  expect_false(rmd_has_shortcode("{{< pagebreak >}}", "video*"))
})

test_that("Shortcode detection in AST nodes", {
  # Test shortcode detection in markdown
  rmd1 <- parse_rmd(c("Hello {{< video url >}} world"))
  expect_equal(rmd_select(rmd1, has_shortcode()), rmd1[1])
  expect_equal(rmd_select(rmd1, has_shortcode("video")), rmd1[1])
  expect_length(rmd_select(rmd1, has_shortcode("pagebreak")), 0)
  
  # Test shortcode detection in chunk code
  rmd2 <- parse_rmd(c("```{r}", "print('{{< pagebreak >}}')", "```"))
  expect_equal(rmd_select(rmd2, has_shortcode()), rmd2[1])
  expect_equal(rmd_select(rmd2, has_shortcode("pagebreak")), rmd2[1])
  expect_length(rmd_select(rmd2, has_shortcode("video")), 0)
  
  # Test no shortcodes
  rmd3 <- parse_rmd(c("Hello world", "```{r}", "print('hello')", "```"))
  expect_length(rmd_select(rmd3, has_shortcode()), 0)
})

test_that("rmd_has_shortcode() with different rmd classes", {
  
  # Test rmd_ast objects
  rmd_ast_with_shortcode <- parse_rmd(c("# Title", "Text with {{< video url >}} shortcode"))
  rmd_ast_without_shortcode <- parse_rmd(c("# Title", "Just normal text"))
  
  expect_true(any(rmd_has_shortcode(rmd_ast_with_shortcode)))
  expect_false(any(rmd_has_shortcode(rmd_ast_without_shortcode)))
  expect_true(any(rmd_has_shortcode(rmd_ast_with_shortcode, "video")))
  expect_false(any(rmd_has_shortcode(rmd_ast_with_shortcode, "pagebreak")))
  
  # Test rmd_markdown objects
  rmd_markdown_with_shortcode <- parse_rmd("Text with {{< kbd Ctrl+C >}} shortcode")[[1]]
  rmd_markdown_without_shortcode <- parse_rmd("Just normal text")[[1]]
  
  expect_true(rmd_has_shortcode(rmd_markdown_with_shortcode))
  expect_false(rmd_has_shortcode(rmd_markdown_without_shortcode))
  expect_true(rmd_has_shortcode(rmd_markdown_with_shortcode, "kbd"))
  expect_false(rmd_has_shortcode(rmd_markdown_with_shortcode, "video"))
  
  # Test rmd_chunk objects
  rmd_chunk_with_shortcode <- parse_rmd(c("```{r}", "# Comment with {{< include file.txt >}}", "x <- 1", "```"))[[1]]
  rmd_chunk_without_shortcode <- parse_rmd(c("```{r}", "x <- 1", "```"))[[1]]
  
  expect_true(rmd_has_shortcode(rmd_chunk_with_shortcode))
  expect_false(rmd_has_shortcode(rmd_chunk_without_shortcode))
  expect_true(rmd_has_shortcode(rmd_chunk_with_shortcode, "include"))
  expect_false(rmd_has_shortcode(rmd_chunk_with_shortcode, "video"))
  
  # Test rmd_yaml objects (YAML blocks cannot contain shortcodes)
  rmd_yaml_obj <- parse_rmd(c("---", "title: My Document", "---"))[[1]]
  
  expect_false(rmd_has_shortcode(rmd_yaml_obj))
  expect_false(rmd_has_shortcode(rmd_yaml_obj, "var"))
  expect_false(rmd_has_shortcode(rmd_yaml_obj, "video"))
  
  # Test rmd_shortcode objects
  shortcode_obj <- rmd_shortcode("video", "demo.mp4", 0, 20)
  expect_true(rmd_has_shortcode(shortcode_obj))
  expect_true(rmd_has_shortcode(shortcode_obj, "video"))
  expect_true(rmd_has_shortcode(shortcode_obj, "vid*"))
  expect_false(rmd_has_shortcode(shortcode_obj, "include"))
  
  # Test rmd_heading objects (should return FALSE via default method)
  rmd_heading_obj <- parse_rmd("# My Title")[[1]]
  expect_false(rmd_has_shortcode(rmd_heading_obj))
  expect_false(rmd_has_shortcode(rmd_heading_obj, "video"))
  
  # Test rmd_tibble objects
  rmd_tibble_with_shortcode <- as_tibble(parse_rmd("Text with {{< video url >}} shortcode"))
  rmd_tibble_without_shortcode <- as_tibble(parse_rmd("Just normal text"))
  
  expect_true(any(rmd_has_shortcode(rmd_tibble_with_shortcode)))
  expect_false(any(rmd_has_shortcode(rmd_tibble_without_shortcode)))
  expect_true(any(rmd_has_shortcode(rmd_tibble_with_shortcode, "video")))
  expect_false(any(rmd_has_shortcode(rmd_tibble_with_shortcode, "pagebreak")))
})

test_that("has_shortcode() selection helper with different rmd classes", {
  
  # Create a comprehensive test document with various node types and shortcodes
  test_rmd <- parse_rmd(c(
    "---",
    "title: My Document",
    "---",
    "",
    "# Section 1",
    "",
    "Text with {{< video demo.mp4 >}} shortcode.",
    "",
    "```{r chunk1}",
    "# Code with {{< include script.R >}} shortcode",
    "x <- 1",
    "```",
    "",
    "## Subsection", 
    "",
    "Normal text without shortcodes.",
    "",
    "```{r chunk2}",
    "y <- 2",
    "```",
    "",
    "Final text with {{< kbd Ctrl+C >}} and {{< pagebreak >}}."
  ))
  
  # Test selecting all nodes with shortcodes
  shortcode_nodes <- rmd_select(test_rmd, has_shortcode())
  expect_length(shortcode_nodes, 3)  # markdown, chunk, and final markdown (no YAML)
  
  # Test selecting nodes with specific shortcode function names
  video_nodes <- rmd_select(test_rmd, has_shortcode("video"))
  expect_length(video_nodes, 1)
  expect_true(rmd_has_shortcode(video_nodes[[1]], "video"))
  
  kbd_nodes <- rmd_select(test_rmd, has_shortcode("kbd"))
  expect_length(kbd_nodes, 1)
  expect_true(rmd_has_shortcode(kbd_nodes[[1]], "kbd"))
  
  include_nodes <- rmd_select(test_rmd, has_shortcode("include"))
  expect_length(include_nodes, 1)
  expect_true(rmd_has_shortcode(include_nodes[[1]], "include"))
  
  # Test that var shortcodes don't exist (since we removed them from YAML)
  var_nodes <- rmd_select(test_rmd, has_shortcode("var"))
  expect_length(var_nodes, 0)
  
  # Test glob patterns
  page_nodes <- rmd_select(test_rmd, has_shortcode("page*"))
  expect_length(page_nodes, 1)
  expect_true(rmd_has_shortcode(page_nodes[[1]], "pagebreak"))
  
  # Test non-existent shortcode
  nonexistent_nodes <- rmd_select(test_rmd, has_shortcode("nonexistent"))
  expect_length(nonexistent_nodes, 0)
  
  # Test multiple function names
  multi_nodes <- rmd_select(test_rmd, has_shortcode(c("video", "kbd")))
  expect_length(multi_nodes, 2)
  
  # Test combining with other selectors
  chunk_with_shortcode <- rmd_select(test_rmd, has_type("rmd_chunk") & has_shortcode())
  expect_length(chunk_with_shortcode, 1)
  expect_equal(rmd_node_type(chunk_with_shortcode[[1]]), "rmd_chunk")
  expect_true(rmd_has_shortcode(chunk_with_shortcode[[1]]))
  
  markdown_with_shortcode <- rmd_select(test_rmd, has_type("rmd_markdown") & has_shortcode())
  expect_length(markdown_with_shortcode, 2)
  expect_true(all(rmd_node_type(markdown_with_shortcode) == "rmd_markdown"))
  expect_true(all(purrr::map_lgl(markdown_with_shortcode, rmd_has_shortcode)))
  
  # Test that YAML blocks cannot contain shortcodes
  yaml_nodes <- rmd_select(test_rmd, has_type("rmd_yaml"))
  yaml_with_shortcode <- rmd_select(test_rmd, has_type("rmd_yaml") & has_shortcode())
  expect_length(yaml_nodes, 1)  # YAML exists
  expect_length(yaml_with_shortcode, 0)  # But no YAML with shortcodes
})

test_that("has_shortcode() with edge cases", {
  
  # Test empty document
  empty_rmd <- parse_rmd("")
  expect_length(rmd_select(empty_rmd, has_shortcode()), 0)
  
  # Test document with no shortcodes
  no_shortcode_rmd <- parse_rmd(c("# Title", "Just normal text", "```{r}", "x <- 1", "```"))
  expect_length(rmd_select(no_shortcode_rmd, has_shortcode()), 0)
  expect_length(rmd_select(no_shortcode_rmd, has_shortcode("video")), 0)
  
  # Test document with only headings (which use default method)
  headings_only_rmd <- parse_rmd(c("# Title 1", "## Subtitle", "### Subsubtitle"))
  expect_length(rmd_select(headings_only_rmd, has_shortcode()), 0)
  
  # Test with shortcode in various positions (multiple lines get combined into one markdown node)
  complex_rmd <- parse_rmd(c(
    "Start {{< video start >}} text",
    "Middle text {{< pagebreak >}} more text", 
    "End text {{< include end >}}"
  ))
  expect_length(rmd_select(complex_rmd, has_shortcode()), 1)  # One markdown node with multiple shortcodes
  expect_length(rmd_select(complex_rmd, has_shortcode("video")), 1)
  expect_length(rmd_select(complex_rmd, has_shortcode("pagebreak")), 1)
  expect_length(rmd_select(complex_rmd, has_shortcode("include")), 1)
})

test_that("Shortcode extraction functionality", {
  
  # Test basic extraction
  shortcodes1 <- rmd_extract_shortcodes("Hello {{< video url >}} world")
  expect_equal(shortcodes1, list(rmd_shortcode("video", "url", 6L, 17L)))
  
  # Test multiple shortcodes
  shortcodes2 <- rmd_extract_shortcodes("{{< func1 >}} and {{< func2 arg >}}")
  expect_equal(shortcodes2, list(
    rmd_shortcode("func1", character(), 0, 13),
    rmd_shortcode("func2", "arg", 18, 17)
  ))
  
  # Test no shortcodes
  shortcodes3 <- rmd_extract_shortcodes("Hello world")
  expect_equal(shortcodes3, list())
  
  # Test complex shortcode patterns
  expect_true(rmd_has_shortcode("{{< video https://example.com >}}"))
  expect_true(rmd_has_shortcode("{{< pagebreak >}}"))
})