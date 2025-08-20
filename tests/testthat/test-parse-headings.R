test_that("markdown - headings", {
  expect_equal(
    check_markdown_heading_parser("# h1\n"),
    rmd_heading("h1", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("## h2\n"),
    rmd_heading("h2", 2L)
  )

  expect_equal(
    check_markdown_heading_parser("### h3\n"),
    rmd_heading("h3", 3L)
  )

  expect_equal(
    check_markdown_heading_parser("#### h4\n"),
    rmd_heading("h4", 4L)
  )

  expect_equal(
    check_markdown_heading_parser("##### h5\n"),
    rmd_heading("h5", 5L)
  )

  expect_equal(
    check_markdown_heading_parser("###### h6\n"),
    rmd_heading("h6", 6L)
  )
})

test_that("markdown - headings - blank", {

  expect_equal(
    check_markdown_heading_parser("# \n"),
    rmd_heading("", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("###### \n"),
    rmd_heading("", 6L)
  )

  expect_equal(
    check_markdown_heading_parser("#\n"),
    rmd_heading("", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("######\n"),
    rmd_heading("", 6L)
  )

})

test_that("markdown - headings - basic attributes", {
  
  # ID attributes
  expect_equal(
    check_markdown_heading_parser("# Heading {#my-id}\n"),
    rmd_heading(
      name = "Heading",
      level = 1L,
      id = "#my-id",
      classes = character(),
      attr = character()
    )
  )
  
  # Class attributes  
  expect_equal(
    check_markdown_heading_parser("## Section {.important}\n"),
    rmd_heading(
      name = "Section",
      level = 2L,
      id = character(),
      classes = ".important",
      attr = character()
    )
  )
  
  # Multiple classes
  expect_equal(
    check_markdown_heading_parser("### Subsection {.class1 .class2}\n"),
    rmd_heading(
      name = "Subsection", 
      level = 3L,
      id = character(),
      classes = c(".class1", ".class2"),
      attr = character()
    )
  )
  
  # Key-value attributes
  expect_equal(
    check_markdown_heading_parser("#### Part {data-level=4}\n"),
    rmd_heading(
      name = "Part",
      level = 4L,
      id = character(),
      classes = character(),
      attr = c("data-level" = "4")
    )
  )
  
  # Unnumbered heading
  expect_equal(
    check_markdown_heading_parser("##### Chapter {-}\n"),
    rmd_heading(
      name = "Chapter",
      level = 5L,
      id = character(),
      classes = ".unnumbered",
      attr = character()
    )
  )
  
})

test_that("markdown - headings - complex attribute combinations", {
  
  # ID + class
  expect_equal(
    check_markdown_heading_parser("# Introduction {#intro .chapter}\n"),
    rmd_heading(
      name = "Introduction",
      level = 1L,
      id = "#intro",
      classes = ".chapter",
      attr = character()
    )
  )
  
  # ID + multiple classes
  expect_equal(
    check_markdown_heading_parser("## Methods {#methods .section .important}\n"),
    rmd_heading(
      name = "Methods",
      level = 2L,
      id = "#methods",
      classes = c(".section", ".important"),
      attr = character()
    )
  )
  
  # ID + class + key-value
  expect_equal(
    check_markdown_heading_parser("### Results {#results .highlight data-toggle=collapse}\n"),
    rmd_heading(
      name = "Results",
      level = 3L,
      id = "#results", 
      classes = ".highlight",
      attr = c("data-toggle" = "collapse")
    )
  )
  
  # Multiple key-value pairs
  expect_equal(
    check_markdown_heading_parser("#### Analysis {data-level=4 data-section=analysis}\n"),
    rmd_heading(
      name = "Analysis",
      level = 4L,
      id = character(),
      classes = character(),
      attr = c("data-level" = "4", "data-section" = "analysis")
    )
  )
  
  # Full combination: ID + classes + key-value pairs
  expect_equal(
    check_markdown_heading_parser("##### Discussion {#discussion .section .collapsible data-toggle=collapse data-target=#disc-content}\n"),
    rmd_heading(
      name = "Discussion",
      level = 5L,
      id = "#discussion",
      classes = c(".section", ".collapsible"),
      attr = c("data-toggle" = "collapse", "data-target" = "#disc-content")
    )
  )
  
})

test_that("markdown - headings - quoted attribute values", {
  
  # Single quoted values
  expect_equal(
    check_markdown_heading_parser("# Title {data-value='single quoted'}\n"),
    rmd_heading(
      name = "Title",
      level = 1L,
      id = character(),
      classes = character(),
      attr = c("data-value" = "'single quoted'")
    )
  )
  
  # Double quoted values
  expect_equal(
    check_markdown_heading_parser('## Subtitle {data-content="double quoted"}\n'),
    rmd_heading(
      name = "Subtitle", 
      level = 2L,
      id = character(),
      classes = character(),
      attr = c("data-content" = '"double quoted"')
    )
  )
  
  # Mixed quotes and unquoted
  expect_equal(
    check_markdown_heading_parser('### Section {#sec data-title="My Section" data-level=3}\n'),
    rmd_heading(
      name = "Section",
      level = 3L,
      id = "#sec",
      classes = character(),
      attr = c("data-title" = '"My Section"', "data-level" = "3")
    )
  )
  
})

test_that("markdown - headings - edge cases", {
  
  # Empty attributes
  expect_equal(
    check_markdown_heading_parser("# Heading {}\n"),
    rmd_heading(
      name = "Heading",
      level = 1L,
      id = character(),
      classes = character(), 
      attr = character()
    )
  )
  
  # Attributes with spaces
  expect_equal(
    check_markdown_heading_parser("## Title { #my-id .my-class }\n"),
    rmd_heading(
      name = "Title",
      level = 2L,
      id = "#my-id",
      classes = ".my-class",
      attr = character()
    )
  )
  
  # Long heading with attributes
  expect_equal(
    check_markdown_heading_parser("### This is a very long heading title that continues for quite some time {#long-heading}\n"),
    rmd_heading(
      name = "This is a very long heading title that continues for quite some time",
      level = 3L,
      id = "#long-heading",
      classes = character(),
      attr = character()
    )
  )
  
  # Heading with special characters
  expect_equal(
    check_markdown_heading_parser("#### Analysis & Results: 2023 {#analysis-2023 .special-chars}\n"),
    rmd_heading(
      name = "Analysis & Results: 2023",
      level = 4L,
      id = "#analysis-2023",
      classes = ".special-chars",
      attr = character()
    )
  )
  
  # Numeric attribute values
  expect_equal(
    check_markdown_heading_parser("##### Chapter {data-chapter=5 data-pages=25}\n"),
    rmd_heading(
      name = "Chapter",
      level = 5L,
      id = character(),
      classes = character(),
      attr = c("data-chapter" = "5", "data-pages" = "25")
    )
  )
  
})

test_that("markdown - headings - as_document roundtrip", {
  
  # Test that headings with attributes can be converted back to text correctly
  
  # Basic ID attribute
  heading_with_id = rmd_heading(
    name = "Introduction", 
    level = 1L, 
    id = "#intro",
    classes = character(),
    attr = character()
  )
  expect_equal(
    as_document(heading_with_id),
    "# Introduction {#intro}"
  )
  
  # Class attributes
  heading_with_classes = rmd_heading(
    name = "Methods",
    level = 2L,
    id = character(), 
    classes = c(".section", ".important"),
    attr = character()
  )
  expect_equal(
    as_document(heading_with_classes),
    "## Methods {.section .important}"
  )
  
  # Key-value attributes
  heading_with_attrs = rmd_heading(
    name = "Results",
    level = 3L,
    id = character(),
    classes = character(),
    attr = c("data-toggle" = "collapse", "data-level" = "3")
  )
  expect_equal(
    as_document(heading_with_attrs),
    "### Results {data-toggle=collapse data-level=3}"
  )
  
  # Full combination
  heading_full = rmd_heading(
    name = "Discussion",
    level = 4L,
    id = "#discussion",
    classes = c(".section", ".collapsible"),
    attr = c("data-toggle" = "collapse", "data-target" = "#content")
  )
  expect_equal(
    as_document(heading_full),
    "#### Discussion {#discussion .section .collapsible data-toggle=collapse data-target=#content}"
  )
  
  # No attributes (should work as before)
  heading_plain = rmd_heading(
    name = "Conclusion", 
    level = 5L,
    id = character(),
    classes = character(),
    attr = character()
  )
  expect_equal(
    as_document(heading_plain),
    "##### Conclusion"
  )
  
})

test_that("markdown - headings - full document roundtrip", {
  
  # Test parsing and regenerating complete documents with heading attributes
  
  doc_with_attrs = c(
    "# Introduction {#intro .chapter}",
    "",
    "Some introductory text here.",
    "",
    "## Methods {#methods .section data-level=2}",
    "",
    "Description of methods.",
    "",
    "### Analysis {.highlight data-toggle=collapse}",
    "",
    "Analysis details.",
    ""
  )
  
  # Parse document
  ast = parse_rmd(paste(doc_with_attrs, collapse = "\n"))
  
  # Convert back to document 
  regenerated = as_document(ast)
  
  # Should be identical when parsed again
  ast_regenerated = parse_rmd(paste(regenerated, collapse = "\n"))
  
  expect_equal(ast, ast_regenerated)
  
})

test_that("markdown - headings - error cases", {
  
  # Test validation of rmd_heading objects with attributes
  
  # Invalid ID format (must start with #)
  expect_snapshot_error(
    rmd_heading(
      name = "Test", 
      level = 1L,
      id = "invalid-id",  # Missing # prefix
      classes = character(),
      attr = character()
    )
  )
  
  # Invalid class format (must start with .)
  expect_snapshot_error(
    rmd_heading(
      name = "Test",
      level = 1L, 
      id = character(),
      classes = "invalid-class",  # Missing . prefix
      attr = character()
    )
  )
  
  # Invalid attribute vector (must be named)
  expect_snapshot_error(
    rmd_heading(
      name = "Test",
      level = 1L,
      id = character(),
      classes = character(),
      attr = c("value1", "value2")  # Missing names
    )
  )
  
  # Multiple IDs (only 0 or 1 allowed)
  expect_snapshot_error(
    rmd_heading(
      name = "Test", 
      level = 1L,
      id = c("#id1", "#id2"),  # Multiple IDs not allowed
      classes = character(),
      attr = character()
    )
  )
  
})
