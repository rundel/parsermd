test_that("as_tibble - minimal.Rmd", {
  ast = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h1,             ~sec_h2,           ~type,             ~label,
    NA,                       NA, "rmd_yaml_list",                 NA,
    "Setup",                  NA,   "rmd_heading",                 NA,
    "Setup",                  NA,     "rmd_chunk",            "setup",
    "Content",                NA,   "rmd_heading",                 NA,
    "Content",      "R Markdown",   "rmd_heading",                 NA,
    "Content",      "R Markdown",  "rmd_markdown",                 NA,
    "Content",      "R Markdown",     "rmd_chunk",             "cars",
    "Content",      "R Markdown",     "rmd_chunk",  "unnamed-chunk-1",
    "Content", "Including Plots",   "rmd_heading",                 NA,
    "Content", "Including Plots",  "rmd_markdown",                 NA,
    "Content", "Including Plots",     "rmd_chunk",         "pressure",
    "Content", "Including Plots",  "rmd_markdown",                 NA
  )
  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})


test_that("as_tibble - hw01.Rmd", {
  ast = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,           ~type,          ~label,
    NA,                   NA, "rmd_yaml_list",              NA,
    "Load packages",      NA,   "rmd_heading",              NA,
    "Load packages",      NA,     "rmd_chunk", "load-packages",
    "Exercise 1",         NA,   "rmd_heading",              NA,
    "Exercise 1",         NA,  "rmd_markdown",              NA,
    "Exercise 1", "Solution",   "rmd_heading",              NA,
    "Exercise 1", "Solution",  "rmd_markdown",              NA,
    "Exercise 2",         NA,   "rmd_heading",              NA,
    "Exercise 2",         NA,  "rmd_markdown",              NA,
    "Exercise 2", "Solution",   "rmd_heading",              NA,
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",     "plot-dino",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",      "cor-dino",
    "Exercise 3",         NA,   "rmd_heading",              NA,
    "Exercise 3",         NA,  "rmd_markdown",              NA,
    "Exercise 3", "Solution",   "rmd_heading",              NA,
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
  ast = parse_rmd(system.file("examples/hw01-student.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h3,         ~sec_h4,           ~type,          ~label,
    NA,                   NA, "rmd_yaml_list",              NA,
    "Load packages",      NA,   "rmd_heading",              NA,
    "Load packages",      NA,     "rmd_chunk", "load-packages",
    "Exercise 1",         NA,   "rmd_heading",              NA,
    "Exercise 1",         NA,  "rmd_markdown",              NA,
    "Exercise 1", "Solution",   "rmd_heading",              NA,
    "Exercise 1", "Solution",  "rmd_markdown",              NA,
    "Exercise 2",         NA,   "rmd_heading",              NA,
    "Exercise 2",         NA,  "rmd_markdown",              NA,
    "Exercise 2", "Solution",   "rmd_heading",              NA,
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",     "plot-dino",
    "Exercise 2", "Solution",  "rmd_markdown",              NA,
    "Exercise 2", "Solution",     "rmd_chunk",      "cor-dino",
    "Exercise 3",         NA,   "rmd_heading",              NA,
    "Exercise 3",         NA,  "rmd_markdown",              NA,
    "Exercise 3", "Solution",   "rmd_heading",              NA,
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
  ast = parse_rmd(system.file("examples/empty_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,           ~type,        ~label,
    "H1-1",       NA,   "rmd_heading", NA_character_,
    "H1-1",   "H2-1",   "rmd_heading", NA_character_,
    "H1-1",   "H2-2",   "rmd_heading", NA_character_,
    "H1-2",       NA,   "rmd_heading", NA_character_
  )

  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})



test_that("as_tibble - reverse_sections.Rmd", {
  ast = parse_rmd(system.file("examples/reverse_sections.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_snapshot_output(tbl)

  yaml = create_yaml('title: "Reversed Sections"','output: html_document')
  tbl_expected = tibble::tribble(
    ~sec_h1, ~sec_h2,       ~sec_h3,           ~type,        ~label,
    NA,           NA,            NA, "rmd_yaml_list", NA_character_,
    NA,           NA,          "H3",   "rmd_heading", NA_character_,
    NA,         "H2",            NA,   "rmd_heading", NA_character_,
    NA,         "H2", "H3 - Part 2",   "rmd_heading", NA_character_,
    "H1",         NA,            NA,   "rmd_heading", NA_character_
  )

  class(tbl_expected) = c("rmd_tibble", class(tbl_expected))

  expect_s3_class(tbl, c("rmd_tibble", "tbl_df", "tbl", "data.frame"))

  # ignore ast column for now
  tbl$ast = NULL
  expect_equal(tbl, tbl_expected)
})
