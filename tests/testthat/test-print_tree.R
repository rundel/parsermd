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
