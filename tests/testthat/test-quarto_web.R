root = "tests/testthat/quarto-web/"
path = system.file(root, package = "parsermd")

if (dir.exists(path)) {
  files = dir(
    path,
    pattern = utils::glob2rx("*.qmd"),
    recursive = TRUE,
    full.names = TRUE
  )

  for(file in files) {
    test_that(sub(paste0(".*",root), "", file), {
      ast = expect_no_error(parse_rmd(file), class = "rmd_ast")

      lines = as_document(ast, padding = character())
      if (length(lines) == 1)
        lines = paste0(lines, "\n")

      expect_equal(
        ast,
        parse_rmd(lines)
      )
    })
  }
}


