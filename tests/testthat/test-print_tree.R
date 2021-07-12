test_that("tree printing", {
  expect_snapshot_output(
    parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("hw01-student.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("hw01.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("reverse_sections.Rmd", package = "parsermd"))
  )

  expect_snapshot_output(
    parse_rmd(system.file("raw_attr.Rmd", package = "parsermd"))
  )
})
