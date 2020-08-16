files = fs::dir_ls(
  system.file("tests/testthat/knitr-examples/", package = "parsermd"),
  glob="*.Rmd"
)

#print(files)

test_that("knitr examples", {

  for(file in files) {
    label = paste("Parsing", fs::path_file(file))
    expect_error(parse_rmd(!!file, allow_incomplete = FALSE), regexp = NA, label = label)
  }
})
