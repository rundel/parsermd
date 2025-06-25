test_that("ast -> document", {
  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("examples/hw01-student.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("examples/reverse_sections.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  expect_snapshot_output(
    cat( as_document(
      parse_rmd(system.file("examples/raw_attr.Rmd", package = "parsermd"))
    ), sep="\n")
  )

  file = system.file("tests/testthat/knitr-examples/125-dash-options.Rmd", package = "parsermd")
  if (file.exists(file)) {
    expect_snapshot_output(
      cat( as_document(
        parse_rmd(file)
      ), sep="\n")
    )
  }
})

test_that("raw chunk", {
  test_trans = function(x) {
    expect_equal(
      parsermd:::check_chunk_parser(x) |> 
        as_document() |> 
        paste(collapse="\n"),
      trimws(x, which = "right")
     )
  }


  test_trans("```{=html}\n```\n")
  test_trans("```{=html}\n<h1>hello</h1>\n```\n")
  test_trans("  ```{=html}\n  ```\n")
  test_trans("  ```{=html}\n  <h1>hello</h1>\n  ```\n")
})

## TODO - add checks for other nodes
