test_that("as_tibble - minimal.Rmd", {
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h1,           ~sec_h2,           ~type,             ~name,
    NA,                     NA, "rmd_yaml_list",                NA,
    "test",                 NA,   "rmd_heading",            "test",
    "test",                 NA,     "rmd_chunk",           "setup",
    "hello",                NA,   "rmd_heading",           "hello",
    "hello",      "R Markdown",   "rmd_heading",      "R Markdown",
    "hello",      "R Markdown",  "rmd_markdown",                NA,
    "hello",      "R Markdown",     "rmd_chunk",            "cars",
    "hello",      "R Markdown",     "rmd_chunk",                "",
    "hello", "Including Plots",   "rmd_heading", "Including Plots",
    "hello", "Including Plots",  "rmd_markdown",                NA,
    "hello", "Including Plots",     "rmd_chunk",        "pressure",
    "hello", "Including Plots",  "rmd_markdown",                NA
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})


test_that("as_tibble - hw01-template.Rmd", {
  ast = parse_rmd(system.file("hw01-template.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,           ~type,           ~name,
    NA,                   NA, "rmd_yaml_list",              NA,
    "Load packages",      NA,   "rmd_heading", "Load packages",
    "Load packages",      NA,     "rmd_chunk", "load-packages",
    "Exercise 1",         NA,   "rmd_heading",    "Exercise 1",
    "Exercise 1",         NA,  "rmd_markdown",              NA,
    "Exercise 1", "Solution",   "rmd_heading",      "Solution",
    "Exercise 1", "Solution",  "rmd_markdown",              NA,
    "Exercise 2",         NA,   "rmd_heading",    "Exercise 2",
    "Exercise 2",         NA,  "rmd_markdown",              NA,
    "Exercise 2", "Solution",   "rmd_heading",      "Solution",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",     "plot-dino",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",      "cor-dino",
    "Exercise 3",         NA,   "rmd_heading",    "Exercise 3",
    "Exercise 3",         NA,  "rmd_markdown",              NA,
    "Exercise 3", "Solution",   "rmd_heading",      "Solution",
    "Exercise 3", "Solution",  "rmd_markdown",              NA,
    "Exercise 3", "Solution",     "rmd_chunk",     "plot-star",
    "Exercise 3", "Solution",  "rmd_markdown",              NA,
    "Exercise 3", "Solution",     "rmd_chunk",      "cor-star"
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})


test_that("as_tibble - hw01-student.Rmd", {
  ast = parse_rmd(system.file("hw01-student.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,           ~type,           ~name,
    NA,                   NA, "rmd_yaml_list",              NA,
    "Load packages",      NA,   "rmd_heading", "Load packages",
    "Load packages",      NA,     "rmd_chunk", "load-packages",
    "Exercise 1",         NA,   "rmd_heading",    "Exercise 1",
    "Exercise 1",         NA,  "rmd_markdown",              NA,
    "Exercise 1", "Solution",   "rmd_heading",      "Solution",
    "Exercise 1", "Solution",  "rmd_markdown",              NA,
    "Exercise 2",         NA,   "rmd_heading",    "Exercise 2",
    "Exercise 2",         NA,  "rmd_markdown",              NA,
    "Exercise 2", "Solution",   "rmd_heading",      "Solution",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",     "plot-dino",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",      "cor-dino",
    "Exercise 3",         NA,   "rmd_heading",    "Exercise 3",
    "Exercise 3",         NA,  "rmd_markdown",              NA,
    "Exercise 3", "Solution",   "rmd_heading",      "Solution",
    "Exercise 3", "Solution",     "rmd_chunk",     "plot-star",
    "Exercise 3", "Solution",     "rmd_chunk",      "cor-star"
  )

  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})

test_that("as_tibble - empty_sections.Rmd", {
  ast = parse_rmd(system.file("empty_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,           ~type,  ~name,
    NA,           NA, "rmd_yaml_list",     NA,
    "H1-1",       NA,   "rmd_heading", "H1-1",
    "H1-1",   "H2-1",   "rmd_heading", "H2-1",
    "H1-1",   "H2-2",   "rmd_heading", "H2-2",
    "H1-2",       NA,   "rmd_heading", "H1-2"
  )

  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})



test_that("as_tibble - reverse_sections.Rmd", {
  ast = parse_rmd(system.file("reverse_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  yaml = create_yaml('title: "Reversed Sections"','output: html_document')
  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,       ~sec_h3,           ~type,         ~name,
    NA,           NA,            NA, "rmd_yaml_list",            NA,
    NA,           NA,          "H3",   "rmd_heading",          "H3",
    NA,         "H2",            NA,   "rmd_heading",          "H2",
    NA,         "H2", "H3 - Part 2",   "rmd_heading", "H3 - Part 2",
    "H1",         NA,            NA,   "rmd_heading",          "H1"
  )

  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore data column for now
  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})
