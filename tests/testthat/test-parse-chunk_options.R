test_that("Quoted string values in chunk options are parsed correctly", {
  expect_equal(
    check_chunk_option_parser("opt='hello'"),
    list(opt = "'hello'"),
  )
  expect_equal(
    check_chunk_option_parser("opt=\"world\""),
    list(opt = "\"world\""),
  )
  expect_equal(
    check_chunk_option_parser("opt='he\\'llo'"),
    list(opt = "'he\\'llo'"),
  )
  expect_equal(
    check_chunk_option_parser("opt=\"wo\\\"rld\""),
    list(opt = "\"wo\\\"rld\""),
  )
  expect_equal(
    check_chunk_option_parser("opt='a\"b\"c'"),
    list(opt = "'a\"b\"c'"),
  )
  expect_equal(
    check_chunk_option_parser("opt=\"a'b'c\""),
    list(opt = "\"a'b'c\""),
  )
  expect_equal(
    check_chunk_option_parser("opt='esc\\ape'"),
    list(opt = "'esc\\ape'"),
  )

  expect_error(
    check_chunk_option_parser("opt='incomplete"),
  )
  expect_error(
    check_chunk_option_parser("opt=\"incomplete"),
  )
})

test_that("Warning is emitted when traditional and YAML options conflict", {
  expect_warning({
    result = check_chunk_parser("```{r test, eval = TRUE}

x = 1
```
")},
    "YAML options override traditional options for: eval"
  )
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "test", 
    options = list(eval = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
  expect_warning({
    result2 = check_chunk_parser(
"```{r test, eval = TRUE, echo = FALSE}

x = 1
```
")},
    "YAML options override traditional options for: eval, echo"
  )
  expected_chunk2 = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(eval = FALSE, echo = TRUE, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result2, expected_chunk2)
})

test_that("No warning when traditional and YAML options don't conflict", {
  expect_no_warning({
    result = check_chunk_parser("```{r test, eval = TRUE}
x = 1
```
")
  })
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(eval = TRUE, echo = FALSE, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Warning message format is correct for single and multiple conflicts", {
  expect_warning(
    check_chunk_parser("```{r echo = TRUE}

```
"),
    "YAML options override traditional options for: echo"
  )
  expect_warning(
    check_chunk_parser("```{r eval = TRUE, echo = TRUE}
```
"),
    "YAML options override traditional options for: eval, echo"
  )
})

test_that("Complex option values handle conflicts correctly", {
  expect_warning({
    result = check_chunk_parser("```{r fig.width = 5, fig.height = 3}
x = 1
```
")
  }, "YAML options override traditional options for: fig.width")
  
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "",
    options = list(fig.width = 7, fig.height = 3, fig.dpi = 300),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
  expect_warning({
    result2 = check_chunk_parser("```{r eval = TRUE}

x = 1
```
")},
    "YAML options override traditional options for: eval"
  )
  
  expected_chunk2 = rmd_chunk(
    engine = "r",
    name = "",
    options = list(eval = FALSE),
    code = "x = 1"
  )
  expect_equal(result2, expected_chunk2)
})
test_that("Traditional and YAML options have different storage but equivalent logical values", {
  traditional = parse_rmd("```{r echo = FALSE, eval = TRUE}
x = 1
```")
  
  yaml = parse_rmd("```{r}
x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("Chunk names are preserved regardless of option format", {
  traditional = parse_rmd("```{r my-chunk, echo = FALSE}
x = 1
```")
  
  yaml = parse_rmd("```{r my-chunk}

x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("Engine specification works the same for both formats", {
  traditional = parse_rmd("```{python echo = FALSE}
x = 1
```")
  
  yaml = parse_rmd("```{python}

x = 1
```")
  
  expect_equal(traditional, yaml)
})

test_that("YAML options preserve proper types while traditional options are strings", {
  yaml = parse_rmd("```{r}

x = 1
```")
  
  traditional = parse_rmd("```{r echo = FALSE, eval = TRUE, fig.width = 5, message = FALSE}
x = 1
```")
  
  expect_false(identical(yaml, traditional))
})

test_that("Option names differ between YAML and traditional formats", {
  yaml = parse_rmd("```{r}

x = 1
```")
  
  traditional = parse_rmd("```{r fig.width = 5, fig.height = 3, out.width = 100}
x = 1
```")
  
  expect_false(identical(yaml, traditional))
})

test_that("Combined chunks with conflicts preserve both option formats for non-conflicting keys", {
  result = parse_rmd("```{r eval = TRUE, message = FALSE}

x = 1
```")
  
  expected = parse_rmd("```{r eval = FALSE, message = FALSE}
x = 1
```")
  
  expect_equal(result, expected)
})
test_that("YAML option names with dashes are normalized to dots for conflict detection", {
  expect_warning({
    result = check_chunk_parser("```{r fig.width = 5}\n#| fig-width: 7\nx = 1\n```\n")
  }, "YAML options override traditional options for: fig.width")
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "",
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
    name = "",
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
    name = "",
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
    name = "",
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red"),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})

test_that("Mixed options with equivalent names normalize correctly", {
  expect_warning({
    result = check_chunk_parser("```{r echo = TRUE, fig.width = 5}\n#| echo: false\n#| fig-width: 7\n#| message: false\nx = 1\n```\n")
  }, "YAML options override traditional options for: echo, fig.width")
  
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "",
    options = list(echo = FALSE, fig.width = 7, message = FALSE),
    code = "x = 1"
  )
  expect_equal(result, expected_chunk)
})
