test_that("rmd_has_chunk", {
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

  expect_true(rmd_has_chunk(ast, name_refs = c("setup")))
  expect_true(rmd_has_chunk(ast, sec_refs = "test", name_refs = "setup"))

  expect_true(rmd_has_chunk(ast, name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, name_refs = "unnamed-chunk-1"))
  expect_true(rmd_has_chunk(ast, name_refs = "pressure"))

  expect_true(rmd_has_chunk(ast, sec_refs = c("hello", "R Markdown"), name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, sec_refs = c("hello", "R Markdown"), name_refs = "unnamed-chunk-1"))
  expect_true(rmd_has_chunk(ast, sec_refs = c("hello", "Including Plots"), name_refs = "pressure"))

  expect_true(rmd_has_chunk(ast, sec_refs = "R Markdown", name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, sec_refs = "hello", name_refs = "cars"))

  # No name ref
  expect_true(rmd_has_chunk(ast, sec_refs = "test"))
  expect_true(rmd_has_chunk(ast, sec_refs = "hello"))
  expect_true(rmd_has_chunk(ast, sec_refs = "R Markdown"))
  expect_true(rmd_has_chunk(ast, sec_refs = "Including Plots"))
  expect_true(rmd_has_chunk(ast, sec_refs = c("hello", "R Markdown")))
  expect_true(rmd_has_chunk(ast, sec_refs = c("hello", "Including Plots")))

  expect_false(rmd_has_chunk(ast, sec_refs = c("test", "hello")))
  expect_false(rmd_has_chunk(ast, sec_refs = c("test", "R Markdown")))

  # Bad Chunk refs
  expect_false(rmd_has_chunk(ast, sec_refs = c("hello", "R Markdown"),  name_refs = "pressure"))
  expect_false(rmd_has_chunk(ast, sec_refs = c("Including Plots"),  name_refs = "cars"))
})


test_that("rmd_has_markdown", {

  # minimal.Rmd
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

  expect_true(rmd_has_markdown(ast))
  expect_true(rmd_has_markdown(ast, sec_refs = "hello"))
  expect_true(rmd_has_markdown(ast, sec_refs = c("hello", "R Markdown")))
  expect_true(rmd_has_markdown(ast, sec_refs = c("hello", "Including Plots")))

  expect_false(rmd_has_markdown(ast, sec_refs = c("test")))


  # hw02-complex.Rmd
  ast = parse_rmd(system.file("hw02-complex.Rmd", package = "parsermd"))

  expect_true(rmd_has_markdown(ast, sec_refs = "Answer"))

  expect_true(rmd_has_markdown(ast, sec_refs = c("Exercise *", "Answer")))
  expect_true(rmd_has_markdown(ast, sec_refs = c("Exercise 1", "Answer")))
  expect_true(rmd_has_markdown(ast, sec_refs = c("Exercise 2", "Answer")))

  expect_true(rmd_has_markdown(ast, sec_refs = c("Exercise *", "Scratch")))
  expect_true(rmd_has_markdown(ast, sec_refs = c("Exercise 1", "Scratch")))
  expect_false(rmd_has_markdown(ast, sec_refs = c("Exercise 2", "Scratch")))
})
