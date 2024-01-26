path = system.file("tests/testthat/quarto-web/", package = "parsermd")

if (dir.exists(path)) {
  files = dir(
    path,
    pattern = utils::glob2rx("*.qmd"),
    recursive = TRUE,
    full.names = TRUE
  )

  for(file in files) {
    test_that(basename(file), {
      ast = expect_no_error(parse_rmd(file), class = "rmd_ast")

      expect_equal(
        ast,
        parse_rmd(as_document(ast, padding = character()))
      )
    })
  }
}


