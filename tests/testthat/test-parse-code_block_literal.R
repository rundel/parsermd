test_that("code block literal parsing - Basic", {
  # Empty literal block
  expect_equal(
    check_code_block_literal_parser("```{{}}\n```\n"),
    rmd_code_block_literal()
  )

  # Basic r block
  expect_equal(
    check_code_block_literal_parser("```{{r}}\n```\n"),
    rmd_code_block_literal(attr = "r")
  )
  
  # Block with content
  expect_equal(
    check_code_block_literal_parser("```{{r}}\n1+1\n```\n"),
    rmd_code_block_literal(attr = "r", code = "1+1")
  )
  
  # Block with multiple lines
  expect_equal(
    check_code_block_literal_parser("```{{python}}\nimport numpy\nprint('hello')\n```\n"),
    rmd_code_block_literal(attr = "python", code = c("import numpy", "print('hello')"))
  )
})

test_that("code block literal parsing - Complex Attributes", {
  # R with options
  expect_equal(
    check_code_block_literal_parser("```{{r, echo=TRUE}}\n```\n"),
    rmd_code_block_literal(attr = "r, echo=TRUE")
  )
  
  # R with multiple options
  expect_equal(
    check_code_block_literal_parser("```{{r, echo=TRUE, warning=FALSE}}\n```\n"),
    rmd_code_block_literal(attr = "r, echo=TRUE, warning=FALSE")
  )
  
  # Complex attribute string
  expect_equal(
    check_code_block_literal_parser("```{{python, engine.path='/usr/bin/python3'}}\n```\n"),
    rmd_code_block_literal(attr = "python, engine.path='/usr/bin/python3'")
  )
  
  # Attributes with spaces
  expect_equal(
    check_code_block_literal_parser("```{{r plot-cars, fig.cap='A scatterplot.'}}\n```\n"),
    rmd_code_block_literal(attr = "r plot-cars, fig.cap='A scatterplot.'")
  )
})

test_that("code block literal parsing - Tick Variations", {
  # Four ticks
  expect_equal(
    check_code_block_literal_parser("````{{r}}\n````\n"),
    rmd_code_block_literal(attr = "r", n_ticks = 4L)
  )
  
  # Four ticks with content containing three ticks
  expect_equal(
    check_code_block_literal_parser("````{{r}}\n```\ncode\n```\n````\n"),
    rmd_code_block_literal(attr = "r", n_ticks = 4L, code = c("```", "code", "```"))
  )
  
  # Five ticks
  expect_equal(
    check_code_block_literal_parser("`````{{python}}\n`````\n"),
    rmd_code_block_literal(attr = "python", n_ticks = 5L)
  )
})

test_that("code block literal parsing - Indentation", {
  # Indented with spaces
  expect_equal(
    check_code_block_literal_parser("  ```{{r}}\n  ```\n"),
    rmd_code_block_literal(attr = "r", indent = "  ")
  )
  
  # Indented with tabs
  expect_equal(
    check_code_block_literal_parser("\t```{{r}}\n\t```\n"),
    rmd_code_block_literal(attr = "r", indent = "\t")
  )
  
  # Indented with content
  expect_equal(
    check_code_block_literal_parser("  ```{{r}}\n  1+1\n  ```\n"),
    rmd_code_block_literal(attr = "r", indent = "  ", code = "1+1")
  )
  
  # Quoted indentation  
  expect_equal(
    check_code_block_literal_parser("> ```{{r}}\n> ```\n"),
    rmd_code_block_literal(attr = "r", indent = "> ")
  )
})

test_that("code block literal parsing - Special Cases", {
  # Numeric language identifier
  expect_equal(
    check_code_block_literal_parser("```{{r2}}\n```\n"),
    rmd_code_block_literal(attr = "r2")
  )
  
  # Language with special characters
  expect_equal(
    check_code_block_literal_parser("```{{my-lang_v2}}\n```\n"),
    rmd_code_block_literal(attr = "my-lang_v2")
  )
  
  # Attribute with equals and quotes
  expect_equal(
    check_code_block_literal_parser("```{{r, eval=TRUE, echo=\"always\"}}\n```\n"),
    rmd_code_block_literal(attr = "r, eval=TRUE, echo=\"always\"")
  )
  
  # Attribute with curly braces inside
  expect_equal(
    check_code_block_literal_parser("```{{r, code='function() { return(1) }'}}\n```\n"),
    rmd_code_block_literal(attr = "r, code='function() { return(1) }'")
  )
  
  # Whitespace between backticks and {{
  expect_equal(
    check_code_block_literal_parser("``` {{r}}\n```\n"),
    rmd_code_block_literal(attr = "r")
  )
  
  # Multiple spaces between backticks and {{
  expect_equal(
    check_code_block_literal_parser("```  {{python}}\n```\n"),
    rmd_code_block_literal(attr = "python")
  )
  
  # Whitespace with complex attributes
  expect_equal(
    check_code_block_literal_parser("``` {{r, echo=TRUE, warning=FALSE}}\n```\n"),
    rmd_code_block_literal(attr = "r, echo=TRUE, warning=FALSE")
  )
  
  # Whitespace with content
  expect_equal(
    check_code_block_literal_parser("``` {{r}}\n1+1\n```\n"),
    rmd_code_block_literal(attr = "r", code = "1+1")
  )
})

test_that("code block literal parsing - Nested Braces", {
  # Basic nested case
  expect_equal(
    check_code_block_literal_parser("```{{{r}}}\n```\n"),
    rmd_code_block_literal(attr = "{r}")
  )
  
  # Unbalanced braces  
  expect_equal(
    check_code_block_literal_parser("```{{{r}}\n```\n"),
    rmd_code_block_literal(attr = "{r")
  )
  
  # Complex nested content
  expect_equal(
    check_code_block_literal_parser("```{{r, code='{}'}}\n```\n"),
    rmd_code_block_literal(attr = "r, code='{}'")
  )
  
  # Multiple levels of nesting
  expect_equal(
    check_code_block_literal_parser("```{{{{r}}}}\n```\n"),
    rmd_code_block_literal(attr = "{{r}}")
  )
  
  # Nested with content
  expect_equal(
    check_code_block_literal_parser("```{{{r}}}\n1+1\n```\n"),
    rmd_code_block_literal(attr = "{r}", code = "1+1")
  )
  
  # Complex real-world case
  expect_equal(
    check_code_block_literal_parser("```{{r, opts=list(key='{value}'), code='function() { return(1) }'}}\n```\n"),
    rmd_code_block_literal(attr = "r, opts=list(key='{value}'), code='function() { return(1) }'")
  )
})

test_that("code block literal parsing - Error Cases", {
  # Missing closing }}
  expect_error(
    check_code_block_literal_parser("```{{r\n```\n")
  )
  
  # Missing opening {{
  expect_error(
    check_code_block_literal_parser("```r}}\n```\n")
  )
  
  # No content between {{ }}
  expect_equal(
    check_code_block_literal_parser("```{{}}\n```\n"),
    rmd_code_block_literal(attr = "")
  )
  
  # Missing closing backticks
  expect_error(
    check_code_block_literal_parser("```{{r}}\ncode\n")
  )
})

test_that("code block literal parsing - S7 Class Validation", {
  # Valid literal block
  literal_block = rmd_code_block_literal(
    attr = "r, echo=TRUE",
    code = c("x = 1", "print(x)"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(literal_block, "rmd_code_block_literal")
  expect_equal(literal_block@attr, "r, echo=TRUE")
  
  # Invalid attr (wrong length)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = c("r", "python"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (wrong length)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = "r",
      code = character(),
      indent = "",
      n_ticks = c(3L, 4L)
    )
  )
})

test_that("code block literal parsing - Round-trip", {
  test_roundtrip = function(input) {
    parsed = check_code_block_literal_parser(input)
    reconstructed = as_document(parsed)
    # Parse the reconstructed version
    reparsed = check_code_block_literal_parser(paste(c(reconstructed, ""), collapse = "\n"))
    expect_equal(parsed, reparsed, info = paste("Failed roundtrip for:", input))
  }
  
  # Basic cases
  test_roundtrip("```{{r}}\n```\n")
  test_roundtrip("```{{python}}\n```\n")
  test_roundtrip("```{{}}\n```\n")
  
  # With options
  test_roundtrip("```{{r, echo=TRUE}}\n```\n")
  test_roundtrip("```{{python, engine='python3'}}\n```\n")
  
  # With content
  test_roundtrip("```{{r}}\n1+1\n```\n")
  test_roundtrip("```{{r, echo=TRUE}}\nplot(cars)\n```\n")
  
  # Whitespace cases
  test_roundtrip("``` {{r}}\n```\n")
  test_roundtrip("```  {{python}}\n```\n")
  test_roundtrip("``` {{r, echo=TRUE}}\nplot(cars)\n```\n")
  
  # Nested brace cases
  test_roundtrip("```{{{r}}}\n```\n")
  test_roundtrip("```{{{r}}\n```\n")
  test_roundtrip("```{{r, code='{}'}}\n```\n")
  test_roundtrip("```{{{{r}}}}\n```\n")
  
  # Complex cases
  test_roundtrip("````{{r, fig.cap='Plot'}}\nplot(1:10)\n````\n")
})