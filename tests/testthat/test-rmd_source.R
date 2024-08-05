test_that("Basic sourcing", {
  ast = rmd_ast(
    rmd_chunk(code = "x = 1"),
    rmd_chunk(code = "y = 2"),
    rmd_chunk(code = "z = 3")
  )

  rmd_source(ast, local=TRUE)

  expect_equal(x, 1)
  expect_equal(y, 2)
  expect_equal(z, 3)

  ast = rmd_ast(
    rmd_chunk(code = "x = 1"),
    rmd_chunk(code = "y = 2"),
    rmd_chunk(code = "z = 3"),
    rmd_chunk(code = "x = 4")
  )

  rmd_source(ast, local=TRUE)

  expect_equal(x, 4)
  expect_equal(y, 2)
  expect_equal(z, 3)
})


test_that("eval stuff", {
  ast = rmd_ast(
    rmd_chunk(code = "x = 1", options = list(eval = TRUE)),
    rmd_chunk(code = "y = 2", options = list(eval = FALSE))
  )

  rmd_source(ast, local=TRUE, use_eval = TRUE)
  expect_equal(x, 1)
  expect_error(y, regexp = "object 'y' not found")


  rmd_source(ast, local=TRUE, use_eval = FALSE)
  expect_equal(x, 1)
  expect_equal(y, 2)
})


test_that("function scope", {
  ast = rmd_ast(
    rmd_chunk(code = "x = 1"),
    rmd_chunk(code = "y = 2")
  )
  f = function() {
    rmd_source(ast, local = TRUE)
    list(x, y)
  }

  expect_equal(
    f(), list(1,2)
  )
  expect_error(x, regexp = "object 'x' not found")
  expect_error(y, regexp = "object 'y' not found")

  g = function() {
    rmd_source(ast, local = TRUE)
    ls()
  }

  expect_equal(
    g(), c("x", "y")
  )
})


test_that("echo", {
  ast = rmd_ast(
    rmd_chunk(name = "Chunk 1", code = "x = 1"),
    rmd_chunk(name = "Chunk 2", code = "y = 2")
  )

  expect_snapshot(rmd_source(ast, local=TRUE, echo=TRUE))

  expect_snapshot(rmd_source(ast, local=TRUE, echo=TRUE, label_comment = FALSE))
})
