test_that("has_chunk", {
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(ast)

  expect_true(has_chunk(ast, c("setup")))
  expect_true(has_chunk(ast, c("test", "setup")))

  expect_true(has_chunk(tbl, c("setup")))
  expect_true(has_chunk(tbl, c("test", "setup")))

  expect_true(has_chunk(tbl, "cars"))
  expect_true(has_chunk(tbl, ""))
  expect_true(has_chunk(tbl, "pressure"))

  expect_true(has_chunk(tbl, c("hello", "R Markdown", "cars")))
  expect_true(has_chunk(tbl, c("hello", "R Markdown", ""))) # Unnamed chunk
  expect_true(has_chunk(tbl, c("hello", "Including Plots", "pressure")))

  # Bad Chunk refs
  expect_false(has_chunk(tbl, c("R Markdown", "cars")))
  expect_false(has_chunk(tbl, c("hello", "cars")))
  expect_false(has_chunk(tbl, c("hello", "R Markdown", "pressure")))

  # List Chunk refs

  expect_equal(
    has_chunk(tbl, list("setup", c("test", "setup"))),
    c(TRUE, TRUE)
  )

  expect_equal(
    has_chunk(
      tbl,
      list(
        c("test", "setup"),
        c("test", "setup"),
        c("test", "setup")
      )
    ),
    c(TRUE, TRUE, TRUE)
  )

  expect_equal(
    has_chunk(
      tbl,
      list(
        c("test", "setup"),
        c("hello", "R Markdown", "cars"),
        c("hello", "R Markdown", ""),
        c("hello", "Including Plots", "pressure")
      )
    ),
    c(TRUE, TRUE, TRUE, TRUE)
  )

  expect_equal(
    has_chunk(
      tbl,
      list(
        c("test", "setup"),
        c("hello", "R Markdown", "cars"),
        c("hello", "R Markdown", "cars_plot"),
        c("hello", "R Markdown", ""),
        c("hello", "Including Plots", "pressure"),
        c("hello", "Including Plots", "pressure_plot")
      )
    ),
    c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE)
  )
})
