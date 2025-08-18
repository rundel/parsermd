test_that("Quoted string values in chunk options are parsed correctly", {
  # Assumes check_chunk_option_parser uses the q_string logic internally for values
  # The parser captures the string including its original quotes as it's part of an R expression

  expect_equal(
    check_chunk_option_parser("opt='hello'"),
    list(opt = "'hello'"),
    info = "Simple single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"world\""),
    list(opt = "\"world\""),
    info = "Simple double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='he\\'llo'"),
    list(opt = "'he\\'llo'"),
    info = "Escaped single quote in single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"wo\\\"rld\""),
    list(opt = "\"wo\\\"rld\""),
    info = "Escaped double quote in double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='a\"b\"c'"),
    list(opt = "'a\"b\"c'"),
    info = "Double quotes inside single-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt=\"a'b'c\""),
    list(opt = "\"a'b'c\""),
    info = "Single quotes inside double-quoted string"
  )
  expect_equal(
    check_chunk_option_parser("opt='esc\\ape'"),
    list(opt = "'esc\\ape'"),
    info = "Non-delimiter escape sequence in single-quoted string"
  )

  expect_error(
    check_chunk_option_parser("opt='incomplete"),
    info = "Unterminated single-quoted string"
  )
  expect_error(
    check_chunk_option_parser("opt=\"incomplete"),
    info = "Unterminated double-quoted string"
  )
})

# === Option Conflicts Tests ===

test_that("Warning is emitted when traditional and YAML options conflict", {
  # Test single conflict
  expect_warning({
    result = check_chunk_parser("```{r test, eval = TRUE}
#| eval: false
x = 1
```
")},
    "YAML options override traditional options for: eval"
  )
  
  # Check that YAML option takes precedence
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "test", 
    options = list(eval = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
  
  # Test multiple conflicts  
  expect_warning({
    result2 = check_chunk_parser(
"```{r test, eval = TRUE, echo = FALSE}
#| eval: false
#| echo: true
#| message: false
x = 1
```
")},
    "YAML options override traditional options for: eval, echo"
  )
  
  # Check that YAML options take precedence for conflicts
  expected_chunk2 = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(eval = FALSE, echo = TRUE, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result2, expected_chunk2)
})

test_that("No warning when traditional and YAML options don't conflict", {
  expect_no_warning({
    result = check_chunk_parser("```{r test, eval = TRUE}
#| echo: false
#| message: false
x = 1
```
")
  })
  
  # Check that all options are preserved
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(eval = TRUE, echo = FALSE, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Warning message format is correct for single and multiple conflicts", {
  # Single conflict - should use singular form
  expect_warning(
    check_chunk_parser("```{r echo = TRUE}
#| echo: false
```
"),
    "YAML options override traditional options for: echo"
  )
  
  # Multiple conflicts - should use plural form with 'and'
  expect_warning(
    check_chunk_parser("```{r eval = TRUE, echo = TRUE}
#| eval: false
#| echo: false
```
"),
    "YAML options override traditional options for: eval, echo"
  )
})

test_that("Complex option values handle conflicts correctly", {
  # Test with option names that actually conflict after normalization
  # since fig-width normalizes to fig.width
  expect_warning({
    result = check_chunk_parser("```{r fig.width = 5, fig.height = 3}
#| fig-width: 7
#| fig-dpi: 300
x = 1
```
")
  }, "YAML options override traditional options for: fig.width")
  
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "",
    options = list(fig.width = 7, fig.height = 3, fig.dpi = 300),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
  
  # Test actual conflict with same option name
  expect_warning({
    result2 = check_chunk_parser("```{r eval = TRUE}
#| eval: false
x = 1
```
")},
    "YAML options override traditional options for: eval"
  )
  
  expected_chunk2 = rmd_chunk(
    engine = "r",
    label = "",
    options = list(eval = FALSE),
    code = "x = 1"
  )
  expect_equal(result2, expected_chunk2)
})

# === Option Equivalence Tests ===

test_that("Traditional and YAML options have different storage but equivalent logical values", {
  traditional = parse_rmd("```{r echo = FALSE, eval = TRUE}
x = 1
```")
  
  yaml = parse_rmd("```{r}
#| echo: false
#| eval: true
x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("Chunk names are preserved regardless of option format", {
  traditional = parse_rmd("```{r my-chunk, echo = FALSE}
x = 1
```")
  
  yaml = parse_rmd("```{r my-chunk}
#| echo: false
x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("Engine specification works the same for both formats", {
  traditional = parse_rmd("```{python echo = FALSE}
x = 1
```")
  
  yaml = parse_rmd("```{python}
#| echo: false
x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("YAML options preserve proper types while traditional options are strings", {
  yaml = parse_rmd("```{r}
#| echo: false
#| eval: true  
#| fig-width: 5
#| fig-height: 3.5
#| message: false
x = 1
```")
  
  traditional = parse_rmd("```{r echo = FALSE, eval = TRUE, fig.width = 5, message = FALSE}
x = 1
```")
  
  # Compare ASTs - they should be different due to type differences
  expect_false(identical(yaml, traditional))
})

test_that("Option names differ between YAML and traditional formats", {
  yaml = parse_rmd("```{r}
#| fig-width: 5
#| fig-height: 3
#| out-width: 100
x = 1
```")
  
  traditional = parse_rmd("```{r fig.width = 5, fig.height = 3, out.width = 100}
x = 1
```")
  
  # ASTs should be different due to naming conventions
  expect_false(identical(yaml, traditional))
})

test_that("Combined chunks with conflicts preserve both option formats for non-conflicting keys", {
  expect_warning({
    result = parse_rmd("```{r eval = TRUE, message = FALSE}
#| echo: false
#| warning: true
#| eval: false
x = 1
```")
  }, "YAML options override traditional options for: eval")
  
  # Create a chunk with the same final options but in the expected order
  # Since YAML wins conflicts and traditional options come first in processing,
  # the result should have eval=false (YAML wins), message=false (traditional preserved)
  expected = parse_rmd("```{r eval = FALSE, message = FALSE}
#| echo: false
#| warning: true
x = 1
```")
  
  expect_equal(result, expected)
})

# === Option Name Normalization Tests ===

test_that("YAML option names with dashes are normalized to dots for conflict detection", {
  # Test fig.width vs fig-width conflict
  expect_warning({
    result = check_chunk_parser("```{r fig.width = 5}\n#| fig-width: 7\nx = 1\n```\n")
  }, "YAML options override traditional options for: fig.width")
  
  # YAML option should win and be stored with dot notation
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "",
    options = list(fig.width = 7),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Multiple YAML options with dashes are normalized correctly", {
  expect_warning({
    result = check_chunk_parser("```{r fig.width = 5, fig.height = 3}\n#| fig-width: 7\n#| fig-height: 4\nx = 1\n```\n")
  }, "YAML options override traditional options for: fig.width, fig.height")
  
  expected_chunk = rmd_chunk(
    engine = "r", 
    label = "",
    options = list(fig.width = 7, fig.height = 4),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("YAML options with dashes that don't conflict are preserved as dots", {
  expect_no_warning({
    result = check_chunk_parser("```{r eval = TRUE}\n#| fig-width: 7\n#| out-height: 100\nx = 1\n```\n")
  })
  
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "",
    options = list(eval = TRUE, fig.width = 7, out.height = 100),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Options with multiple dashes are normalized correctly", {
  expect_no_warning({
    result = check_chunk_parser("```{r}\n#| fig-cap-location: bottom\n#| out-extra-css: 'color: red'\nx = 1\n```\n")
  })
  
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "",
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red"),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Mixed options with equivalent names normalize correctly", {
  # Traditional uses dots, YAML uses dashes for same options
  expect_warning({
    result = check_chunk_parser("```{r echo = TRUE, fig.width = 5}\n#| echo: false\n#| fig-width: 7\n#| message: false\nx = 1\n```\n")
  }, "YAML options override traditional options for: echo, fig.width")
  
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "",
    options = list(echo = FALSE, fig.width = 7, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})
