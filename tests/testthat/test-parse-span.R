test_that("C++ single span parser - basic functionality", {
  
  # Test simple span with class
  expect_equal(
    check_span_parser("[text]{.class}"), 
    rmd_span(
      text = "text",
      classes = ".class"
    )
  )
  
  # Test span with ID only
  expect_equal(
    check_span_parser("[content]{#myid}"), 
    rmd_span(
      text = "content",
      id = "#myid"
    )
  )
  
  # Test span with ID and class
  expect_equal(
    check_span_parser("[text]{#myid .highlight}"), 
    rmd_span(
      text = "text",
      id = "#myid",
      classes = ".highlight"
    )
  )
  
  # Test span with multiple classes
  expect_equal(
    check_span_parser("[text]{.class1 .class2 .class3}"), 
    rmd_span(
      text = "text",
      classes = c(".class1", ".class2", ".class3")
    )
  )
  
  # Test span with attributes
  expect_equal(
    check_span_parser("[text]{.class key=value}"), 
    rmd_span(
      text = "text",
      classes = ".class",
      attr = c(key = "value")
    )
  )
  
  # Test span with ID, classes, and attributes
  expect_equal(
    check_span_parser("[content]{#id .class1 .class2 key1=value1 key2=value2}"), 
    rmd_span(
      text = "content",
      id = "#id",
      classes = c(".class1", ".class2"),
      attr = c(key1 = "value1", key2 = "value2")
    )
  )
  
  # Test span with quoted attribute values
  expect_equal(
    check_span_parser("[text]{.class title=\"quoted value\"}"), 
    rmd_span(
      text = "text",
      classes = ".class",
      attr = c(title = "\"quoted value\"")
    )
  )
  
  # Test span with escaped brackets in text
  expect_equal(
    check_span_parser(r"([text with \] bracket]{.class})"), 
    rmd_span(
      text = r"(text with \] bracket)",
      classes = ".class"
    )
  )

})

test_that("C++ span parser - edge cases and validation", {
  
  # Test empty attributes (should still work)
  expect_equal(
    check_span_parser("[text]{}"), 
    rmd_span(text = "text")
  )
  
  # Test span with complex text content
  expect_equal(
    check_span_parser("[text with spaces and punctuation!]{.highlight}"), 
    rmd_span(
      text = "text with spaces and punctuation!",
      classes = ".highlight"
    )
  )

})

test_that("C++ span parser - nested spans", {
  
  # Test basic nested span - inner span becomes text content  
  expect_equal(
    check_span_parser("[[hello]{.class1}]{.class2}"),
    rmd_span(
      text = "[hello]{.class1}",
      classes = ".class2"
    )
  )
  
  # Test nested span with ID and multiple attributes
  expect_equal(
    check_span_parser("[[inner text]{.inner}]{#outer .outer key=value}"),
    rmd_span(
      text = "[inner text]{.inner}",
      id = "#outer",
      classes = ".outer",
      attr = c(key = "value")
    )
  )
  
  # Test nested span with complex inner content
  expect_equal(
    check_span_parser("[[text with spaces]{.highlight .bold}]{.container}"),
    rmd_span(
      text = "[text with spaces]{.highlight .bold}",
      classes = ".container"
    )
  )
  
  # Test text with non-span brackets (should be included in content)
  expect_equal(
    check_span_parser("[text with [brackets] inside]{.class}"),
    rmd_span(
      text = "text with [brackets] inside",
      classes = ".class"
    )
  )
  
  # Test mixed content - span followed by non-span brackets
  expect_equal(
    check_span_parser("[prefix [nested]{.inner} and [more brackets]]{.outer}"),
    rmd_span(
      text = "prefix [nested]{.inner} and [more brackets]",
      classes = ".outer"
    )
  )
  
  # Test deeply nested spans
  expect_equal(
    check_span_parser("[[[deep]{.level1}]{.level2}]{.level3}"),
    rmd_span(
      text = "[[deep]{.level1}]{.level2}",
      classes = ".level3"
    )
  )
  
  # Test escaped brackets in nested spans
  expect_equal(
    check_span_parser(r"([[text with \] escaped]{.inner}]{.outer})"),
    rmd_span(
      text = r"([text with \] escaped]{.inner})",
      classes = ".outer"
    )
  )

})

test_that("Span extraction from strings", {
  
  # Test extracting single span
  result = rmd_extract_spans("Some text with [highlighted]{.highlight} content")
  expect_length(result, 1)
  expect_length(result[[1]], 1)
  expect_equal(
    result[[1]][[1]],
    rmd_span(text = "highlighted", classes = ".highlight")
  )
  
  # Test extracting multiple spans
  result = rmd_extract_spans("Text with [first]{.a} and [second]{.b} spans")
  expect_length(result, 1)
  expect_length(result[[1]], 2)
  expect_equal(
    result[[1]][[1]],
    rmd_span(text = "first", classes = ".a")
  )
  expect_equal(
    result[[1]][[2]],
    rmd_span(text = "second", classes = ".b")
  )
  
  # Test with flatten = TRUE
  result = rmd_extract_spans("Text with [span]{.class}", flatten = TRUE)
  expect_length(result, 1)
  expect_equal(
    result[[1]],
    rmd_span(text = "span", classes = ".class")
  )
  
  # Test string with no spans
  result = rmd_extract_spans("Plain text without any spans")
  expect_length(result, 1)
  expect_length(result[[1]], 0)

})

test_that("Span detection functionality", {
  
  # Test positive detection
  expect_true(rmd_has_span("Text with [span]{.class}"))
  expect_true(rmd_has_span("Multiple [first]{.a} and [second]{.b} spans"))
  
  # Test negative detection
  expect_false(rmd_has_span("Plain text without spans"))
  
  expect_false(rmd_has_span("Text with [unclosed span"))
  expect_false(rmd_has_span("Text with closed] but no opening"))
  expect_false(rmd_has_span("Text with brackets [but] no attributes"))
  expect_false(rmd_has_span("Text with {attributes} but no brackets"))
  
  # Test with vectors
  text_vec = c(
    "Text with [span]{.class}",
    "Plain text",
    "Another [highlighted]{.highlight} text"
  )
  result = rmd_has_span(text_vec)
  expect_equal(result, c(TRUE, FALSE, TRUE))

})

test_that("rmd_span S7 class validation", {
  
  # Valid span objects
  expect_no_error(rmd_span(text = "test"))
  expect_no_error(rmd_span(text = "test", classes = ".class"))
  expect_no_error(rmd_span(text = "test", id = "#id"))
  expect_no_error(rmd_span(text = "test", attr = c(key = "value")))
  
  # Invalid text (not single character)
  expect_snapshot_error(rmd_span(text = c("a", "b")))
  expect_snapshot_error(rmd_span(text = character()))
  
  # Invalid ID (multiple values)
  expect_snapshot_error(rmd_span(text = "test", id = c("#id1", "#id2")))
  
  # Invalid ID (missing # prefix)
  expect_snapshot_error(rmd_span(text = "test", id = "id"))
  
  # Invalid classes (missing . prefix)
  expect_snapshot_error(rmd_span(text = "test", classes = "class"))
  expect_snapshot_error(rmd_span(text = "test", classes = c(".good", "bad")))
  
  # Invalid attr (unnamed)
  expect_snapshot_error(rmd_span(text = "test", attr = c("value1", "value2")))

})

test_that("Span print methods", {
  
  # Test basic span printing
  span = rmd_span(text = "test", classes = ".highlight")
  expect_output(print(span), "rmd_span")
  expect_output(print(span), "test")
  expect_output(print(span), ".highlight")
  
  # Test span with all attributes
  span = rmd_span(
    text = "content", 
    id = "#myid", 
    classes = c(".class1", ".class2"),
    attr = c(key = "value")
  )
  expect_output(print(span), "rmd_span")
  expect_output(print(span), "content")
  expect_output(print(span), "#myid")
  expect_output(print(span), ".class1")
  expect_output(print(span), "key=value")

})

test_that("rmd_extract_spans works correctly across appropriate node types", {
  
  # Test rmd_ast extraction (should only find spans in markdown and headings)
  test_ast = parse_rmd(c(
    "---",
    "title: \"Document with [span]{.class} in YAML\"",  # Should NOT extract
    "---",
    "",
    "# Heading with [span]{.highlight}",  # Should extract
    "",
    "Markdown with [important]{.bold} text and [another]{.italic} span",  # Should extract
    "",
    "```{r}",
    "# Code with [span]{.class} - should NOT extract",
    "```"
  ))
  
  ast_result = rmd_extract_spans(test_ast, flatten = TRUE)
  expect_length(ast_result, 3)  # Only from heading and markdown
  expect_equal(ast_result[[1]]@text, "span")
  expect_equal(ast_result[[1]]@classes, ".highlight")
  expect_equal(ast_result[[2]]@text, "important")
  expect_equal(ast_result[[2]]@classes, ".bold")
  expect_equal(ast_result[[3]]@text, "another")
  expect_equal(ast_result[[3]]@classes, ".italic")
  
  # Test individual node types that SHOULD contain spans
  markdown_node = rmd_markdown(lines = c("Text with [highlighted]{.highlight} content"))
  markdown_result = rmd_extract_spans(markdown_node, flatten = TRUE)
  expect_length(markdown_result, 1)
  expect_equal(markdown_result[[1]]@text, "highlighted")
  expect_equal(markdown_result[[1]]@classes, ".highlight")
  
  heading_node = rmd_heading(name = "Title with [important]{.bold} text", level = 1L)
  heading_result = rmd_extract_spans(heading_node, flatten = TRUE)
  expect_length(heading_result, 1)
  expect_equal(heading_result[[1]]@text, "important")
  expect_equal(heading_result[[1]]@classes, ".bold")
  
  span_node = rmd_span(text = "Outer span with [nested]{.inner} content")
  span_result = rmd_extract_spans(span_node, flatten = TRUE)
  expect_length(span_result, 1)
  expect_equal(span_result[[1]]@text, "nested")
  expect_equal(span_result[[1]]@classes, ".inner")
  
  # Test node types that should NOT contain spans (should return empty)
  yaml_node = rmd_yaml(yaml = list(title = "Document with [span]{.class} in YAML"))
  expect_length(rmd_extract_spans(yaml_node, flatten = TRUE), 0)
  
  chunk_node = rmd_chunk(engine = "r", code = c("# Comment with [span]{.class}"))
  expect_length(rmd_extract_spans(chunk_node, flatten = TRUE), 0)
  
  raw_chunk_node = rmd_raw_chunk(format = "html", code = c("<p>HTML with [span]{.class}</p>"))
  expect_length(rmd_extract_spans(raw_chunk_node, flatten = TRUE), 0)
  
  code_block_node = rmd_code_block(code = c("/* comment with [span]{.class} */"))
  expect_length(rmd_extract_spans(code_block_node, flatten = TRUE), 0)
  
  code_literal_node = rmd_code_block_literal(code = c("literal [span]{.class}"))
  expect_length(rmd_extract_spans(code_literal_node, flatten = TRUE), 0)
  
  shortcode_node = rmd_shortcode(func = "test", args = c("arg with [span]{.class}"))
  expect_length(rmd_extract_spans(shortcode_node, flatten = TRUE), 0)
  
  inline_code_node = rmd_inline_code(engine = "r", code = "code with [span]{.class}")
  expect_length(rmd_extract_spans(inline_code_node, flatten = TRUE), 0)
  
  fdiv_open_node = rmd_fenced_div_open()
  expect_length(rmd_extract_spans(fdiv_open_node, flatten = TRUE), 0)
  
  fdiv_close_node = rmd_fenced_div_close()
  expect_length(rmd_extract_spans(fdiv_close_node, flatten = TRUE), 0)
})

test_that("rmd_extract_spans flatten parameter works correctly", {
  
  # Test nested structure (flatten = FALSE)
  markdown_node = rmd_markdown(lines = c("Line 1 [first]{.a}", "Line 2 [second]{.b}"))
  nested_result = rmd_extract_spans(markdown_node, flatten = FALSE)
  expect_equal(names(nested_result), "lines")
  expect_length(nested_result$lines, 2)
  expect_length(nested_result$lines[[1]], 1)
  expect_length(nested_result$lines[[2]], 1)
  expect_equal(nested_result$lines[[1]][[1]]@text, "first")
  expect_equal(nested_result$lines[[2]][[1]]@text, "second")
  
  # Test flattened structure (flatten = TRUE)
  flat_result = rmd_extract_spans(markdown_node, flatten = TRUE)
  expect_length(flat_result, 2)
  expect_equal(flat_result[[1]]@text, "first")
  expect_equal(flat_result[[1]]@classes, ".a")
  expect_equal(flat_result[[2]]@text, "second")
  expect_equal(flat_result[[2]]@classes, ".b")
})

test_that("rmd_extract_spans works with complex span patterns", {
  
  # Test multiple spans in same line
  markdown_node = rmd_markdown(lines = c("Text with [first]{.a} and [second]{.b} and [third]{#id .c}"))
  result = rmd_extract_spans(markdown_node, flatten = TRUE)
  expect_length(result, 3)
  expect_equal(result[[1]]@text, "first")
  expect_equal(result[[2]]@text, "second") 
  expect_equal(result[[3]]@text, "third")
  expect_equal(result[[3]]@id, "#id")
  
  # Test nested spans within span
  span_node = rmd_span(text = "Outer [nested1]{.inner1} and [nested2]{.inner2} content")
  result = rmd_extract_spans(span_node, flatten = TRUE)
  expect_length(result, 2)
  expect_equal(result[[1]]@text, "nested1")
  expect_equal(result[[2]]@text, "nested2")
  
  # Test spans in heading
  heading_node = rmd_heading(name = "[Important]{.highlight}: Results for [dataset]{.data-name}", level = 2L)
  result = rmd_extract_spans(heading_node, flatten = TRUE)
  expect_length(result, 2)
  expect_equal(result[[1]]@text, "Important")
  expect_equal(result[[2]]@text, "dataset")
})

test_that("rmd_has_span works correctly with appropriate node types", {
  
  # Test nodes that SHOULD support span detection
  expect_true(rmd_has_span(rmd_markdown(lines = c("Text with [span]{.class}"))))
  expect_false(rmd_has_span(rmd_markdown(lines = c("Plain text"))))
  
  expect_true(rmd_has_span(rmd_heading(name = "Title with [span]{.class}", level = 1L)))
  expect_false(rmd_has_span(rmd_heading(name = "Plain title", level = 1L)))
  
  expect_true(rmd_has_span(rmd_span(text = "Text with [nested]{.inner}")))
  expect_false(rmd_has_span(rmd_span(text = "Plain text")))
  
  # Test nodes that should NOT support spans (always FALSE)
  expect_false(rmd_has_span(rmd_yaml(yaml = list(title = "Title with [span]{.class}"))))
  expect_false(rmd_has_span(rmd_chunk(engine = "r", code = c("# [span]{.class}"))))
  expect_false(rmd_has_span(rmd_raw_chunk(format = "html", code = c("[span]{.class}"))))
  expect_false(rmd_has_span(rmd_code_block(code = c("[span]{.class}"))))
  expect_false(rmd_has_span(rmd_code_block_literal(code = c("[span]{.class}"))))
  expect_false(rmd_has_span(rmd_shortcode(func = "test", args = c("[span]{.class}"))))
  expect_false(rmd_has_span(rmd_inline_code(engine = "r", code = "[span]{.class}")))
  expect_false(rmd_has_span(rmd_fenced_div_open()))
  expect_false(rmd_has_span(rmd_fenced_div_close()))
})