test_that("tree printing", {
  expect_snapshot_output(
    parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("examples/hw01-student.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("examples/reverse_sections.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("examples/raw_attr.Rmd", package = "parsermd"))
  )
})

test_that("tree printing with fenced divs", {
  
  qmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))

  qmd_wrap = qmd |>
    rmd_fenced_div_wrap(
      by_section("Exercise 1"),
      open = rmd_fenced_div_open(classes = ".callout-warning", id = "#note-callout")
    )

  expect_snapshot_output(print(qmd_wrap))
  expect_snapshot_output(print(qmd_wrap |> rmd_select(by_section("Exercise 1"))))

  qmd_wrap = qmd |>
    rmd_fenced_div_wrap(
      by_section(c("Exercise 1", "Solution"), keep_parents = FALSE),
      open = rmd_fenced_div_open(classes = ".callout-warning", id = "#note-callout")
    )

  expect_snapshot_output(print(qmd_wrap))
  expect_snapshot_output(print(qmd_wrap |> rmd_select(by_section(c("Exercise 1", "Solution")))))

  qmd = "### Section 1

::: {.callout-note}
## Test
More text
:::

### Section 2

Stuff
  
## Section 3
  
Blah
  
### Sub Section 1
  
Fizzbuzz
"
  
  expect_snapshot_output(print(parse_qmd(qmd)))

})

test_that("tree printing with various fenced div structures", {

  # Test basic fenced div with different attributes
  basic_fdiv = "
# Main Heading

::: {.callout-warning}
## Warning Inside
This is a warning message
:::

## Outside Heading
Regular content
"
  expect_snapshot_output(print(parse_qmd(basic_fdiv)))

  # Test nested fenced divs
  nested_fdiv = "
# Document Title

::: {.outer-div}
## Outer Content

::: {.inner-div}
### Inner Heading
Nested content here
:::

More outer content
:::

# After Nesting
Final content
"
  expect_snapshot_output(print(parse_qmd(nested_fdiv)))

  # Test multiple separate fenced divs
  multiple_fdiv = "
# Chapter 1

::: {.note}
Important note
:::

## Section A

::: {.warning}
### Warning Header
Be careful here
:::

::: {.tip}
Pro tip content
:::

## Section B
Normal content
"
  expect_snapshot_output(print(parse_qmd(multiple_fdiv)))

  # Test minimal fenced divs
  minimal_fdiv = "
# Title

::: {.empty}
Empty div
:::

::: {.just-class}
Content with just ID
:::

Text after
"
  expect_snapshot_output(print(parse_qmd(minimal_fdiv)))

  # Test fenced divs with code chunks
  fdiv_with_chunks = "
# Analysis

::: {.code-example}
## Code Demo

```{r}
x = 1:10
mean(x)
```

Results shown above
:::

# Summary
Done
"
  expect_snapshot_output(print(parse_qmd(fdiv_with_chunks)))

})

test_that("tree printing fenced divs with selection", {
  
  # Create a complex structure for testing selections
  complex_qmd = "
# Document

## Section A

::: {.callout-note}
### Note Header
Important information
### Another Note Header
More details
:::

## Section B

Normal content here

::: {.warning}
### Warning in B
Be careful
:::

### Regular Heading in B

## Section C

::: {.tip}
Pro tips
:::

Final content
"

  parsed = parse_qmd(complex_qmd)
  expect_snapshot_output(print(parsed))
  
  # Test selections that include fenced div content
  expect_snapshot_output(print(parsed |> rmd_select(by_section("Section A"))))
  expect_snapshot_output(print(parsed |> rmd_select(by_section("Section B"))))
  
  # Test selections by heading names that are inside fenced divs
  expect_snapshot_output(print(parsed |> rmd_select(by_section("Warning in B"))))
})
