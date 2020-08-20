test_that("ast -> document", {
  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("hw01-student.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("hw01-template.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("reverse_sections.Rmd", package = "parsermd"))
    ), sep="\n")
  )
})
