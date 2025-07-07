test_that("as_document with use_yaml_opts = TRUE renders options in YAML format", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test", 
    options = list(echo = FALSE),
    code = "x = 1"
  )
  
  result = as_document(chunk, use_yaml_opts = TRUE)
  
  expected = c(
    "```{r test}",
    "#| echo: false",
    "x = 1",
    "```"
  )
  
  expect_equal(result, expected)
})

test_that("as_document with use_yaml_opts = FALSE renders options in traditional format", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(echo = FALSE),
    code = "x = 1"
  )
  
  result = as_document(chunk, use_yaml_opts = FALSE)
  
  expected = c(
    "```{r test, echo = FALSE}",
    "x = 1",
    "```"
  )
  
  expect_equal(result, expected)
})

test_that("as_document formats differ between use_yaml_opts TRUE and FALSE", {
  chunk = rmd_chunk(
    engine = "r",
    name = "analysis",
    options = list(echo = TRUE, eval = FALSE),
    code = "x = 1"
  )
  
  yaml_format = as_document(chunk, use_yaml_opts = TRUE)
  traditional_format = as_document(chunk, use_yaml_opts = FALSE)
  
  # They should be different
  expect_false(identical(yaml_format, traditional_format))
  
  expected_yaml = c(
    "```{r analysis}",
    "#| echo: true",
    "#| eval: false",
    "x = 1",
    "```"
  )
  
  expected_traditional = c(
    "```{r analysis, echo = TRUE, eval = FALSE}",
    "x = 1",
    "```"
  )
  
  expect_equal(yaml_format, expected_yaml)
  expect_equal(traditional_format, expected_traditional)
})

test_that("as_document handles chunks with no options correctly", {
  chunk = rmd_chunk(
    engine = "r",
    name = "simple",
    options = list(),
    code = "print('hello')"
  )
  
  yaml_format = as_document(chunk, use_yaml_opts = TRUE)
  traditional_format = as_document(chunk, use_yaml_opts = FALSE)
  
  # Should be identical when no options
  expect_equal(yaml_format, traditional_format)
  
  expected = c(
    "```{r simple}",
    "print('hello')",
    "```"
  )
  
  expect_equal(yaml_format, expected)
})

test_that("as_document handles chunks with no name correctly", {
  chunk = rmd_chunk(
    engine = "r",
    name = "",
    options = list(echo = FALSE),
    code = "x = 1"
  )
  
  yaml_format = as_document(chunk, use_yaml_opts = TRUE)
  traditional_format = as_document(chunk, use_yaml_opts = FALSE)
  
  expected_yaml = c(
    "```{r}",
    "#| echo: false",
    "x = 1",
    "```"
  )
  
  expected_traditional = c(
    "```{r echo = FALSE}",
    "x = 1",
    "```"
  )
  
  expect_equal(yaml_format, expected_yaml)
  expect_equal(traditional_format, expected_traditional)
})

test_that("as_document default behavior uses YAML format", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(echo = FALSE),
    code = "x = 1"
  )
  
  default_result = as_document(chunk)
  explicit_yaml_result = as_document(chunk, use_yaml_opts = TRUE)
  
  # Should be identical
  expect_equal(default_result, explicit_yaml_result)
  
  expected = c(
    "```{r test}",
    "#| echo: false",
    "x = 1",
    "```"
  )
  
  expect_equal(default_result, expected)
})

test_that("as_document preserves different engine types with both formats", {
  r_chunk = rmd_chunk(engine = "r", options = list(echo = FALSE), code = "x = 1")
  python_chunk = rmd_chunk(engine = "python", options = list(eval = FALSE), code = "y = 2")
  
  # YAML format
  r_yaml = as_document(r_chunk, use_yaml_opts = TRUE)
  python_yaml = as_document(python_chunk, use_yaml_opts = TRUE)
  
  expected_r_yaml = c(
    "```{r}",
    "#| echo: false",
    "x = 1",
    "```"
  )
  
  expected_python_yaml = c(
    "```{python}",
    "#| eval: false",
    "y = 2",
    "```"
  )
  
  expect_equal(r_yaml, expected_r_yaml)
  expect_equal(python_yaml, expected_python_yaml)
  
  # Traditional format
  r_trad = as_document(r_chunk, use_yaml_opts = FALSE)
  python_trad = as_document(python_chunk, use_yaml_opts = FALSE)
  
  expected_r_trad = c(
    "```{r echo = FALSE}",
    "x = 1",
    "```"
  )
  
  expected_python_trad = c(
    "```{python eval = FALSE}",
    "y = 2",
    "```"
  )
  
  expect_equal(r_trad, expected_r_trad)
  expect_equal(python_trad, expected_python_trad)
})

test_that("as_document parameter propagates through AST with multiple chunks", {
  chunk1 = rmd_chunk(engine = "r", name = "chunk1", options = list(echo = FALSE), code = "x = 1")
  chunk2 = rmd_chunk(engine = "r", name = "chunk2", options = list(eval = FALSE), code = "y = 2")
  ast = rmd_ast(nodes = list(chunk1, chunk2))
  
  yaml_result = as_document(ast, use_yaml_opts = TRUE)
  traditional_result = as_document(ast, use_yaml_opts = FALSE)
  
  expected_yaml = c(
    "```{r chunk1}",
    "#| echo: false",
    "x = 1",
    "```",
    "",
    "```{r chunk2}",
    "#| eval: false",
    "y = 2",
    "```",
    ""
  )
  
  expected_traditional = c(
    "```{r chunk1, echo = FALSE}",
    "x = 1",
    "```",
    "",
    "```{r chunk2, eval = FALSE}",
    "y = 2",
    "```",
    ""
  )
  
  expect_equal(yaml_result, expected_yaml)
  expect_equal(traditional_result, expected_traditional)
})

# === Option Name Conversion Tests ===

test_that("as_document converts dot notation to dash notation for YAML output", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(fig.width = 5, fig.height = 3, out.width = "100%"),
    code = "x = 1"
  )
  
  yaml_result = as_document(chunk, use_yaml_opts = TRUE)
  
  expected = c(
    "```{r test}",
    "#| fig-width: 5.0",
    "#| fig-height: 3.0", 
    "#| out-width: 100%",
    "x = 1",
    "```"
  )
  
  expect_equal(yaml_result, expected)
})

test_that("as_document preserves dot notation for traditional output", {
  chunk = rmd_chunk(
    engine = "r", 
    name = "test",
    options = list(fig.width = 5, fig.height = 3, out.width = "100%"),
    code = "x = 1"
  )
  
  traditional_result = as_document(chunk, use_yaml_opts = FALSE)
  
  expected = c(
    "```{r test, fig.width = 5, fig.height = 3, out.width = 100%}",
    "x = 1",
    "```"
  )
  
  expect_equal(traditional_result, expected)
})

test_that("as_document handles options with multiple dots correctly", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test", 
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red"),
    code = "x = 1"
  )
  
  yaml_result = as_document(chunk, use_yaml_opts = TRUE)
  traditional_result = as_document(chunk, use_yaml_opts = FALSE)
  
  expected_yaml = c(
    "```{r test}",
    "#| fig-cap-location: bottom",
    "#| out-extra-css: 'color: red'",
    "x = 1", 
    "```"
  )
  
  expected_traditional = c(
    "```{r test, fig.cap.location = bottom, out.extra.css = color: red}",
    "x = 1",
    "```"
  )
  
  expect_equal(yaml_result, expected_yaml)
  expect_equal(traditional_result, expected_traditional)
})

test_that("as_document name conversion works with mixed option types", {
  chunk = rmd_chunk(
    engine = "r",
    name = "analysis",
    options = list(echo = TRUE, fig.width = 7, eval = FALSE, out.height = "50%"),
    code = c("plot(1:10)", "summary(data)")
  )
  
  yaml_result = as_document(chunk, use_yaml_opts = TRUE)
  
  expected = c(
    "```{r analysis}",
    "#| echo: true",
    "#| fig-width: 7.0", 
    "#| eval: false",
    "#| out-height: 50%",
    "plot(1:10)",
    "summary(data)",
    "```"
  )
  
  expect_equal(yaml_result, expected)
})

test_that("as_document handles options without dots unchanged", {
  chunk = rmd_chunk(
    engine = "r",
    name = "simple",
    options = list(echo = TRUE, eval = FALSE, message = TRUE),
    code = "x = 1"
  )
  
  yaml_result = as_document(chunk, use_yaml_opts = TRUE)
  traditional_result = as_document(chunk, use_yaml_opts = FALSE)
  
  # Option names should be the same since no dots to convert
  expected_yaml = c(
    "```{r simple}",
    "#| echo: true",
    "#| eval: false", 
    "#| message: true",
    "x = 1",
    "```"
  )
  
  expected_traditional = c(
    "```{r simple, echo = TRUE, eval = FALSE, message = TRUE}",
    "x = 1",
    "```"
  )
  
  expect_equal(yaml_result, expected_yaml)
  expect_equal(traditional_result, expected_traditional)
})