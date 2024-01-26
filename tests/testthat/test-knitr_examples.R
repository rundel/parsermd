files = dir(
  system.file("tests/testthat/knitr-examples/", package = "parsermd"),
  pattern = utils::glob2rx("*.Rmd"),
  full.names = TRUE
)

for(file in files) {
  if (grepl("065-rmd-chunk\\.Rmd", file))
    next

  test_that(basename(file), {
    ast = expect_no_error(parse_rmd(file), class = "rmd_ast")

    expect_equal(
      ast,
      parse_rmd(as_document(ast, padding = character()))
    )
  })
}


