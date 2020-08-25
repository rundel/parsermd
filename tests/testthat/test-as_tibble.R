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

  expect_snapshot_output(tbl)
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
     "Exercise 2",    NA,         "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    NA,         "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list()
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl[,-4], tbl_expected[,-4])

  expect_snapshot_output(tbl)
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
     "Exercise 2",    NA,         "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 2",    "Solution", "rmd_markdown",  list(),
     "Exercise 2",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    NA,         "rmd_markdown",  list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list(),
     "Exercise 3",    "Solution", "rmd_chunk",     list()
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl[,-4], tbl_expected[,-4])

  expect_snapshot_output(tbl)
})

test_that("as_tibble - empty_sections.Rmd", {
  ast = parse_rmd(system.file("empty_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)


  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,  ~type,            ~data,
    NA,       NA,      "rmd_yaml_list",  create_yaml(),
    "H1-1",   "H2-1",  "rmd_empty",      NULL,
    "H1-1",   "H2-2",  "rmd_empty",      NULL,
    "H1-2",   NA,      "rmd_empty",      NULL
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl, tbl_expected)
})



test_that("as_tibble - reverse_sections.Rmd", {
  ast = parse_rmd(system.file("reverse_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  yaml = create_yaml('title: "Reversed Sections"','output: html_document')
  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2, ~sec_h3,       ~type,            ~data,
     NA,       NA,     NA,            "rmd_yaml_list",  yaml,
     NA,       NA,     "H3",          "rmd_empty",      NULL,
     NA,       "H2",   "H3 - Part 2", "rmd_empty",      NULL,
     "H1",     NA,     NA,            "rmd_empty",      NULL
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  expect_equal(tbl, tbl_expected)
})
