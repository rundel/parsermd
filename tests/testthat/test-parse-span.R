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
    check_span_parser("[text with \\] bracket]{.class}"), 
    rmd_span(
      text = "text with  bracket",
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