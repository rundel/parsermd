test_that("Basics", {
  ast = rmd_ast(
    rmd_chunk(code = "x = 1"),
    rmd_chunk(code = "y = 2")
  )

  expect_equal(
    ast,
    rmd_ast_append(
      rmd_ast(rmd_chunk(code = "x = 1")),
      rmd_chunk(code = "y = 2")
    )
  )

  expect_equal(
    ast,
    rmd_ast_prepend(
      rmd_ast(rmd_chunk(code = "y = 2")),
      rmd_chunk(code = "x = 1")
    )
  )

  ast = rmd_ast(
    rmd_chunk(code = "x = 1"),
    rmd_chunk(code = "y = 2"),
    rmd_chunk(code = "z = 3")
  )

  expect_equal(
    ast,
    rmd_ast_append(
      rmd_ast(rmd_chunk(code = "x = 1")),
      rmd_chunk(code = "y = 2"),
      rmd_chunk(code = "z = 3")
    )
  )

  expect_equal(
    ast,
    rmd_ast_prepend(
      rmd_ast(rmd_chunk(code = "z = 3")),
      rmd_chunk(code = "x = 1"),
      rmd_chunk(code = "y = 2")
    )
  )
})
