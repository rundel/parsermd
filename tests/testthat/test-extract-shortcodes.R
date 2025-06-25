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
  rmd1 = parse_rmd(c("Hello {{< video url >}} world"))
  expect_equal(rmd_select(rmd1, has_shortcode()), rmd1[1])
  expect_equal(rmd_select(rmd1, has_shortcode("video")), rmd1[1])
  expect_length(rmd_select(rmd1, has_shortcode("pagebreak")), 0)
  
  # Test shortcode detection in chunk code
  rmd2 = parse_rmd(c("```{r}", "print('{{< pagebreak >}}')", "```"))
  expect_equal(rmd_select(rmd2, has_shortcode()), rmd2[1])
  expect_equal(rmd_select(rmd2, has_shortcode("pagebreak")), rmd2[1])
  expect_length(rmd_select(rmd2, has_shortcode("video")), 0)
  
  # Test no shortcodes
  rmd3 = parse_rmd(c("Hello world", "```{r}", "print('hello')", "```"))
  expect_length(rmd_select(rmd3, has_shortcode()), 0)
})

test_that("rmd_has_shortcode() with different rmd classes", {
  
  # Test rmd_ast objects
  rmd_ast_with_shortcode = parse_rmd(c("# Title", "Text with {{< video url >}} shortcode"))
  rmd_ast_without_shortcode = parse_rmd(c("# Title", "Just normal text"))
  
  expect_true(any(rmd_has_shortcode(rmd_ast_with_shortcode)))
  expect_false(any(rmd_has_shortcode(rmd_ast_without_shortcode)))
  expect_true(any(rmd_has_shortcode(rmd_ast_with_shortcode, "video")))
  expect_false(any(rmd_has_shortcode(rmd_ast_with_shortcode, "pagebreak")))
  
  # Test rmd_markdown objects
  rmd_markdown_with_shortcode = parse_rmd("Text with {{< kbd Ctrl+C >}} shortcode")[[1]]
  rmd_markdown_without_shortcode = parse_rmd("Just normal text")[[1]]
  
  expect_true(rmd_has_shortcode(rmd_markdown_with_shortcode))
  expect_false(rmd_has_shortcode(rmd_markdown_without_shortcode))
  expect_true(rmd_has_shortcode(rmd_markdown_with_shortcode, "kbd"))
  expect_false(rmd_has_shortcode(rmd_markdown_with_shortcode, "video"))
  
  # Test rmd_chunk objects
  rmd_chunk_with_shortcode = parse_rmd(c("```{r}", "# Comment with {{< include file.txt >}}", "x = 1", "```"))[[1]]
  rmd_chunk_without_shortcode = parse_rmd(c("```{r}", "x = 1", "```"))[[1]]
  
  expect_true(rmd_has_shortcode(rmd_chunk_with_shortcode))
  expect_false(rmd_has_shortcode(rmd_chunk_without_shortcode))
  expect_true(rmd_has_shortcode(rmd_chunk_with_shortcode, "include"))
  expect_false(rmd_has_shortcode(rmd_chunk_with_shortcode, "video"))
  
  # Test rmd_yaml objects (shortcodes must be in quoted values)
  rmd_yaml_with_shortcode = parse_rmd(c("---", "title: \"Document with {{< var title >}}\"", "---"))[[1]]
  rmd_yaml_without_shortcode = parse_rmd(c("---", "title: My Document", "---"))[[1]]
  # Test unquoted shortcode (should be treated as regular YAML value, but might still be detected)
  rmd_yaml_unquoted_shortcode = parse_rmd(c("---", "title: {{< var title >}}", "---"))[[1]]
  
  expect_true(rmd_has_shortcode(rmd_yaml_with_shortcode))
  expect_false(rmd_has_shortcode(rmd_yaml_without_shortcode))
  expect_true(rmd_has_shortcode(rmd_yaml_with_shortcode, "var"))
  expect_false(rmd_has_shortcode(rmd_yaml_with_shortcode, "video"))
  
  # Check if unquoted shortcode is handled (depends on YAML parser behavior)
  # This tests how the YAML parser treats unquoted shortcode-like syntax
  
  # Test rmd_heading objects (should return FALSE via default method)
  rmd_heading_obj = parse_rmd("# My Title")[[1]]
  expect_false(rmd_has_shortcode(rmd_heading_obj))
  expect_false(rmd_has_shortcode(rmd_heading_obj, "video"))
  
  # Test rmd_tibble objects
  rmd_tibble_with_shortcode = as_tibble(parse_rmd("Text with {{< video url >}} shortcode"))
  rmd_tibble_without_shortcode = as_tibble(parse_rmd("Just normal text"))
  
  expect_true(any(rmd_has_shortcode(rmd_tibble_with_shortcode)))
  expect_false(any(rmd_has_shortcode(rmd_tibble_without_shortcode)))
  expect_true(any(rmd_has_shortcode(rmd_tibble_with_shortcode, "video")))
  expect_false(any(rmd_has_shortcode(rmd_tibble_with_shortcode, "pagebreak")))
})

test_that("has_shortcode() selection helper with different rmd classes", {
  
  # Create a comprehensive test document with various node types and shortcodes
  test_rmd = parse_rmd(c(
    "---",
    "title: \"Document with {{< var title >}}\"",
    "---",
    "",
    "# Section 1",
    "",
    "Text with {{< video demo.mp4 >}} shortcode.",
    "",
    "```{r chunk1}",
    "# Code with {{< include script.R >}} shortcode",
    "x = 1",
    "```",
    "",
    "## Subsection", 
    "",
    "Normal text without shortcodes.",
    "",
    "```{r chunk2}",
    "y = 2",
    "```",
    "",
    "Final text with {{< kbd Ctrl+C >}} and {{< pagebreak >}}."
  ))
  
  # Test selecting all nodes with shortcodes
  shortcode_nodes = rmd_select(test_rmd, has_shortcode())
  expect_length(shortcode_nodes, 4)  # YAML, markdown, chunk, and final markdown
  
  # Test selecting nodes with specific shortcode function names
  video_nodes = rmd_select(test_rmd, has_shortcode("video"))
  expect_length(video_nodes, 1)
  expect_true(rmd_has_shortcode(video_nodes[[1]], "video"))
  
  kbd_nodes = rmd_select(test_rmd, has_shortcode("kbd"))
  expect_length(kbd_nodes, 1)
  expect_true(rmd_has_shortcode(kbd_nodes[[1]], "kbd"))
  
  include_nodes = rmd_select(test_rmd, has_shortcode("include"))
  expect_length(include_nodes, 1)
  expect_true(rmd_has_shortcode(include_nodes[[1]], "include"))
  
  var_nodes = rmd_select(test_rmd, has_shortcode("var"))
  expect_length(var_nodes, 1)
  expect_true(rmd_has_shortcode(var_nodes[[1]], "var"))
  
  # Test glob patterns
  page_nodes = rmd_select(test_rmd, has_shortcode("page*"))
  expect_length(page_nodes, 1)
  expect_true(rmd_has_shortcode(page_nodes[[1]], "pagebreak"))
  
  # Test non-existent shortcode
  nonexistent_nodes = rmd_select(test_rmd, has_shortcode("nonexistent"))
  expect_length(nonexistent_nodes, 0)
  
  # Test multiple function names
  multi_nodes = rmd_select(test_rmd, has_shortcode(c("video", "kbd")))
  expect_length(multi_nodes, 2)
  
  # Test combining with other selectors
  chunk_with_shortcode = rmd_select(test_rmd, has_type("rmd_chunk") & has_shortcode())
  expect_length(chunk_with_shortcode, 1)
  expect_equal(rmd_node_type(chunk_with_shortcode[[1]]), "rmd_chunk")
  expect_true(rmd_has_shortcode(chunk_with_shortcode[[1]]))
  
  markdown_with_shortcode = rmd_select(test_rmd, has_type("rmd_markdown") & has_shortcode())
  expect_length(markdown_with_shortcode, 2)
  expect_true(all(rmd_node_type(markdown_with_shortcode) == "rmd_markdown"))
  expect_true(all(purrr::map_lgl(markdown_with_shortcode, rmd_has_shortcode)))
  
  yaml_with_shortcode = rmd_select(test_rmd, has_type("rmd_yaml") & has_shortcode())
  expect_length(yaml_with_shortcode, 1)
  expect_equal(rmd_node_type(yaml_with_shortcode[[1]]), "rmd_yaml")
  expect_true(rmd_has_shortcode(yaml_with_shortcode[[1]]))
})

test_that("has_shortcode() with edge cases", {
  
  # Test empty document
  
  # Test document with no shortcodes
  no_shortcode_rmd = parse_rmd(c("# Title", "Just normal text", "```{r}", "x = 1", "```"))
  expect_length(rmd_select(no_shortcode_rmd, has_shortcode()), 0)
  expect_length(rmd_select(no_shortcode_rmd, has_shortcode("video")), 0)
  
  # Test document with only headings (which use default method)
  headings_only_rmd = parse_rmd(c("# Title 1", "## Subtitle", "### Subsubtitle"))
  expect_length(rmd_select(headings_only_rmd, has_shortcode()), 0)
  
  # Test with shortcode in various positions (multiple lines get combined into one markdown node)
  complex_rmd = parse_rmd(c(
    "Start {{< video start >}} text",
    "Middle text {{< pagebreak >}} more text", 
    "End text {{< include end >}}"
  ))
  expect_length(rmd_select(complex_rmd, has_shortcode()), 1)  # One markdown node with multiple shortcodes
  expect_length(rmd_select(complex_rmd, has_shortcode("video")), 1)
  expect_length(rmd_select(complex_rmd, has_shortcode("pagebreak")), 1)
  expect_length(rmd_select(complex_rmd, has_shortcode("include")), 1)
})

test_that("YAML with multiple shortcodes in list values", {
  
  # Test complex YAML document with multiple shortcodes in categories list
  complex_yaml_doc = c(
    '---',
    'title: "ABC"',
    'categories:',
    '    - "{{< var kws.ds >}}"',
    '    - "{{< var kws.ml >}}"',
    '    - "{{< var kws.nlp >}}"',
    '    - "{{< var kws.python_pkg >}}"',
    '    - AI',
    '---',
    '',
    'Here is the content of the post.'
  )
  
  # Parse the document from text
  rmd_parsed = parse_rmd(complex_yaml_doc)
  expect_length(rmd_parsed, 2)  # YAML node + markdown node
  
  yaml_node_parsed = rmd_parsed[[1]]
  markdown_node = rmd_parsed[[2]]
  
  # Create equivalent YAML node using rmd_yaml() constructor
  yaml_node_constructed = rmd_yaml(
    title = "ABC",
    categories = c(
      "{{< var kws.ds >}}",
      "{{< var kws.ml >}}",
      "{{< var kws.nlp >}}",
      "{{< var kws.python_pkg >}}",
      "AI"
    )
  )
  
  # Compare parsed vs constructed YAML nodes
  expect_equal(yaml_node_parsed, yaml_node_constructed)
  
  # Test shortcode detection on parsed YAML
  expect_true(rmd_has_shortcode(yaml_node_parsed))
  expect_true(rmd_has_shortcode(yaml_node_parsed, "var"))
  expect_false(rmd_has_shortcode(yaml_node_parsed, "video"))
  expect_false(rmd_has_shortcode(yaml_node_parsed, "kws*"))  # kws.ds is argument, not function name
  
  # Test markdown node (should not have shortcodes)
  expect_false(rmd_has_shortcode(markdown_node))
  
  # Test selection helpers on parsed document
  shortcode_nodes = rmd_select(rmd_parsed, has_shortcode())
  expect_length(shortcode_nodes, 1)  # Only YAML node
  
  var_nodes = rmd_select(rmd_parsed, has_shortcode("var"))
  expect_length(var_nodes, 1)
  expect_equal(rmd_node_type(var_nodes[[1]]), "rmd_yaml")
  
  # Test shortcode extraction from all category values
  # Position information now reflects position within each individual YAML value
  expect_equal(
    rmd_extract_shortcodes(yaml_node_parsed, flatten = TRUE), 
    list(
      rmd_shortcode("var", "kws.ds", 0L, 18L),
      rmd_shortcode("var", "kws.ml", 0L, 18L),
      rmd_shortcode("var", "kws.nlp", 0L, 19L),
      rmd_shortcode("var", "kws.python_pkg", 0L, 26L)
    )
  )
  
  # Test shortcode extraction with flatten=FALSE (default) - returns nested structure
  expect_equal(
    rmd_extract_shortcodes(yaml_node_parsed, flatten = FALSE),
    list(
      "title" = list(list()),
      "categories" = list(
        list(rmd_shortcode("var", "kws.ds", 0L, 18L)),
        list(rmd_shortcode("var", "kws.ml", 0L, 18L)),
        list(rmd_shortcode("var", "kws.nlp", 0L, 19L)),
        list(rmd_shortcode("var", "kws.python_pkg", 0L, 26L)),
        list()
      )
    )
  )
})

test_that("Shortcode extraction functionality", {
  
  # Test basic extraction with flatten=TRUE
  expect_equal(
    rmd_extract_shortcodes("Hello {{< video url >}} world", flatten = TRUE),
    list(rmd_shortcode("video", "url", 6L, 17L))
  )
  
  # Test multiple shortcodes with flatten=TRUE
  expect_equal(
    rmd_extract_shortcodes("{{< func1 >}} and {{< func2 arg >}}", flatten = TRUE),
    list(
      rmd_shortcode("func1", character(), 0L, 13L),
      rmd_shortcode("func2", "arg", 18L, 17L)
    )
  )
  
  # Test no shortcodes with flatten=TRUE
  expect_equal(rmd_extract_shortcodes("Hello world", flatten = TRUE), list())
  
  # Test flatten=FALSE (default behavior) with vector
  expect_equal(
    rmd_extract_shortcodes(c("Text with {{< video url >}}", "Another {{< pagebreak >}} text"), flatten = FALSE),
    list(
      list(rmd_shortcode("video", "url", 10L, 17L)),
      list(rmd_shortcode("pagebreak", character(), 8L, 17L))
    )
  )
  
  # Test flatten=TRUE with vector
  expect_equal(
    rmd_extract_shortcodes(c("Text with {{< video url >}}", "Another {{< pagebreak >}} text"), flatten = TRUE),
    list(
      rmd_shortcode("video", "url", 10L, 17L),
      rmd_shortcode("pagebreak", character(), 8L, 17L)
    )
  )
  
  # Test flatten=TRUE with no shortcodes
  expect_equal(rmd_extract_shortcodes("No shortcodes here", flatten = TRUE), list())
  
  # Test flatten=FALSE (default) with single strings - returns nested structure
  expect_equal(
    rmd_extract_shortcodes("Hello {{< video url >}} world", flatten = FALSE),
    list(list(rmd_shortcode("video", "url", 6L, 17L)))
  )
  
  expect_equal(
    rmd_extract_shortcodes("{{< func1 >}} and {{< func2 arg >}}", flatten = FALSE),
    list(list(
      rmd_shortcode("func1", character(), 0L, 13L),
      rmd_shortcode("func2", "arg", 18L, 17L)
    ))
  )
  
  expect_equal(rmd_extract_shortcodes("Hello world", flatten = FALSE), list(list()))
  
  # Test complex shortcode patterns
  expect_true(rmd_has_shortcode("{{< video https://example.com >}}"))
  expect_true(rmd_has_shortcode("{{< pagebreak >}}"))
})