test_that("Basic hierarchy", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_heading("H2", 2L),
    rmd_heading("H3", 3L),
    rmd_heading("H4", 4L),
    rmd_heading("H5", 5L),
    rmd_heading("H6", 6L)
  ) )

  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA,   sec_h3 = NA,   sec_h4 = NA,   sec_h5 = NA,   sec_h6 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2", sec_h3 = NA,   sec_h4 = NA,   sec_h5 = NA,   sec_h6 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2", sec_h3 = "H3", sec_h4 = NA,   sec_h5 = NA,   sec_h6 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2", sec_h3 = "H3", sec_h4 = "H4", sec_h5 = NA,   sec_h6 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2", sec_h3 = "H3", sec_h4 = "H4", sec_h5 = "H5", sec_h6 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2", sec_h3 = "H3", sec_h4 = "H4", sec_h5 = "H5", sec_h6 = "H6")
  )

  expect_identical(rmd_node_sections(ast), expect_sec)

  expect_identical(rmd_node_sections(ast, 1:6), purrr::map(expect_sec, ~.x[1:6]))
  expect_identical(rmd_node_sections(ast, 1:5), purrr::map(expect_sec, ~.x[1:5]))
  expect_identical(rmd_node_sections(ast, 1:4), purrr::map(expect_sec, ~.x[1:4]))
  expect_identical(rmd_node_sections(ast, 1:3), purrr::map(expect_sec, ~.x[1:3]))
  expect_identical(rmd_node_sections(ast, 1:2), purrr::map(expect_sec, ~.x[1:2]))
  expect_identical(rmd_node_sections(ast, 1L), purrr::map(expect_sec, ~.x[1]))

  expect_identical(rmd_node_sections(ast, 1:6), purrr::map(expect_sec, ~.x[1:6]))
  expect_identical(rmd_node_sections(ast, 2:6), purrr::map(expect_sec, ~.x[2:6]))
  expect_identical(rmd_node_sections(ast, 3:6), purrr::map(expect_sec, ~.x[3:6]))
  expect_identical(rmd_node_sections(ast, 4:6), purrr::map(expect_sec, ~.x[4:6]))
  expect_identical(rmd_node_sections(ast, 5:6), purrr::map(expect_sec, ~.x[5:6]))
  expect_identical(rmd_node_sections(ast, 6L), purrr::map(expect_sec, ~.x[6]))

  expect_identical(
    rmd_node_sections(ast, drop_na = TRUE),
    purrr::map(expect_sec, ~.x[!is.na(.x)])
  )
})

test_that("Inverted hierarchy", {
  ast = rmd_ast( list(
    rmd_heading("H4", 4L),
    rmd_heading("H3", 3L),
    rmd_heading("H2", 2L)
  ) )

  expect_sec = list(
    c(sec_h2 = NA,   sec_h3 = NA,   sec_h4 = "H4"),
    c(sec_h2 = NA,   sec_h3 = "H3", sec_h4 = NA),
    c(sec_h2 = "H2", sec_h3 = NA,   sec_h4 = NA)
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})

test_that("Test hw01.Rmd", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))

  expect_sec = list(
    c(sec_h3 = NA_character_,   sec_h4 = NA_character_),
    c(sec_h3 = "Load packages", sec_h4 = NA_character_),
    c(sec_h3 = "Load packages", sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 1",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 1",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 1",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 1",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 2",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 2",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 2",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 2",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 2",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 2",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 2",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 3",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 3",    sec_h4 = NA_character_),
    c(sec_h3 = "Exercise 3",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 3",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 3",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 3",    sec_h4 = "Solution"),
    c(sec_h3 = "Exercise 3",    sec_h4 = "Solution")
  )

  expect_identical(rmd_node_sections(rmd), expect_sec)
  expect_identical(rmd_node_sections(rmd, levels = 1:4), expect_sec)
  expect_identical(rmd_node_sections(rmd, levels = 3:4), expect_sec)

  expect_identical(
    rmd_node_sections(rmd, levels = 3L),
    purrr::map(expect_sec, ~.x[1])
  )

  expect_identical(
    rmd_node_sections(rmd, levels = 4L),
    purrr::map(expect_sec, ~.x[2])
  )
})
