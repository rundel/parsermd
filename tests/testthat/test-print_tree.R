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
  
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))

  rmd_wrap = rmd |>
    rmd_fenced_div_wrap(
      by_section("Exercise 1"),
      open = rmd_fenced_div_open(classes = ".callout-warning", id = "#note-callout")
    )

  expect_snapshot_output(print(rmd_wrap))
  expect_snapshot_output(print(rmd_wrap |> rmd_select(by_section("Exercise 1"))))

  rmd_wrap = rmd |>
    rmd_fenced_div_wrap(
      by_section(c("Exercise 1", "Solution"), keep_parents = FALSE),
      open = rmd_fenced_div_open(classes = ".callout-warning", id = "#note-callout")
    )

  expect_snapshot_output(print(rmd_wrap))
  expect_snapshot_output(print(rmd_wrap |> rmd_select(by_section(c("Exercise 1", "Solution")))))
})
