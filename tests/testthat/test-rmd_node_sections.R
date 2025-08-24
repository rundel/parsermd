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

test_that("Headings inside fenced divs are ignored for section hierarchy", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_markdown("Some content"),
    rmd_fenced_div_open(classes = ".callout-note"),
    rmd_heading("H2 Inside", 2L),
    rmd_markdown("Content inside"),
    rmd_fenced_div_close(),
    rmd_heading("H2 Outside", 2L),
    rmd_markdown("Content outside")
  ) )

  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),         # H2 Inside should NOT update sections
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Outside"), # H2 Outside should update sections
    c(sec_h1 = "H1", sec_h2 = "H2 Outside")
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})

test_that("Multiple headings inside fenced divs", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_fenced_div_open(classes = ".callout"),
    rmd_heading("H2 Inside", 2L),
    rmd_heading("H3 Inside", 3L),
    rmd_heading("H4 Inside", 4L),
    rmd_fenced_div_close(),
    rmd_heading("H2 Outside", 2L)
  ) )

  # Since headings inside fenced divs are ignored, only H1 and H2 levels are seen
  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),  # H2 Inside ignored
    c(sec_h1 = "H1", sec_h2 = NA),  # H3 Inside ignored
    c(sec_h1 = "H1", sec_h2 = NA),  # H4 Inside ignored
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Outside")  # H2 Outside counts
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})

test_that("Nested fenced divs", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_fenced_div_open(classes = ".outer"),
    rmd_heading("H2 Outer", 2L),
    rmd_fenced_div_open(classes = ".inner"),
    rmd_heading("H3 Inner", 3L),
    rmd_fenced_div_close(),
    rmd_heading("H2 Still Outer", 2L),
    rmd_fenced_div_close(),
    rmd_heading("H2 Outside", 2L)
  ) )

  # Since all headings inside fenced divs are ignored, only H1 and H2 levels are seen
  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),  # H2 Outer ignored (inside outer div)
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),  # H3 Inner ignored (inside nested div)
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),  # H2 Still Outer ignored (still inside outer)
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Outside")  # H2 Outside counts
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})

test_that("Empty fenced div", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_fenced_div_open(classes = ".empty"),
    rmd_fenced_div_close(),
    rmd_heading("H2", 2L)
  ) )

  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2")
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})

test_that("Multiple separate fenced divs", {
  ast = rmd_ast( list(
    rmd_heading("H1", 1L),
    rmd_fenced_div_open(classes = ".first"),
    rmd_heading("H2 First", 2L),
    rmd_fenced_div_close(),
    rmd_heading("H2 Between", 2L),
    rmd_fenced_div_open(classes = ".second"),
    rmd_heading("H3 Second", 3L),
    rmd_fenced_div_close(),
    rmd_heading("H3 After", 3L)
  ) )

  expect_sec = list(
    c(sec_h1 = "H1", sec_h2 = NA, sec_h3 = NA),
    c(sec_h1 = "H1", sec_h2 = NA, sec_h3 = NA),
    c(sec_h1 = "H1", sec_h2 = NA, sec_h3 = NA),  # H2 First ignored
    c(sec_h1 = "H1", sec_h2 = NA, sec_h3 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Between", sec_h3 = NA),  # H2 Between counts
    c(sec_h1 = "H1", sec_h2 = "H2 Between", sec_h3 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Between", sec_h3 = NA),  # H3 Second ignored
    c(sec_h1 = "H1", sec_h2 = "H2 Between", sec_h3 = NA),
    c(sec_h1 = "H1", sec_h2 = "H2 Between", sec_h3 = "H3 After")  # H3 After counts
  )

  expect_identical(rmd_node_sections(ast), expect_sec)
})
