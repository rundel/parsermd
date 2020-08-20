test_that("as_tibble - minimal.Rmd", {
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,           ~type,           ~data,
    NA,      NA,                "rmd_yaml_list", list(),
    "test",  NA,                "rmd_chunk",     list(),
    "hello", "R Markdown",      "rmd_markdown",  list(),
    "hello", "R Markdown",      "rmd_chunk",     list(),
    "hello", "R Markdown",      "rmd_chunk",     list(),
    "hello", "Including Plots", "rmd_markdown",  list(),
    "hello", "Including Plots", "rmd_chunk",     list(),
    "hello", "Including Plots", "rmd_markdown",  list()
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl[,-4], tbl_expected[,-4])
})


test_that("as_tibble - hw01-template.Rmd", {
  ast = parse_rmd(system.file("hw01-template.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,    ~type,           ~data,
     NA,              NA,         "rmd_yaml_list", list(),
     "Load packages", NA,         "rmd_chunk",     list(),
     "Exercise 1",    NA,         "rmd_markdown",  list(),
     "Exercise 1",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list()
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl[,-4], tbl_expected[,-4])
})


test_that("as_tibble - hw01-student.Rmd", {
  ast = parse_rmd(system.file("hw01-student.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,    ~type,           ~data,
     NA,              NA,         "rmd_yaml_list", list(),
     "Load packages", NA,         "rmd_chunk",     list(),
     "Exercise 1",    NA,         "rmd_markdown",  list(),
     "Exercise 1",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list()
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl[,-4], tbl_expected[,-4])
})
