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
