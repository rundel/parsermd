test_that("rmd_has_chunk", {
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

  expect_true(rmd_has_chunk(ast, name_refs = c("setup")))
  expect_true(rmd_has_chunk(ast, sec_refs = "Setup", name_refs = "setup"))

  expect_true(rmd_has_chunk(ast, name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, name_refs = ""))
  expect_true(rmd_has_chunk(ast, name_refs = "pressure"))

  expect_true(rmd_has_chunk(ast, sec_refs = c("Content", "R Markdown"), name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, sec_refs = c("Content", "R Markdown"), name_refs = ""))
  expect_true(rmd_has_chunk(ast, sec_refs = c("Content", "Including Plots"), name_refs = "pressure"))

  expect_true(rmd_has_chunk(ast, sec_refs = "R Markdown", name_refs = "cars"))
  expect_true(rmd_has_chunk(ast, sec_refs = "Content", name_refs = "cars"))

  # No name ref
  expect_true(rmd_has_chunk(ast, sec_refs = "Setup"))
  expect_true(rmd_has_chunk(ast, sec_refs = "Content"))
  expect_true(rmd_has_chunk(ast, sec_refs = "R Markdown"))
  expect_true(rmd_has_chunk(ast, sec_refs = "Including Plots"))
  expect_true(rmd_has_chunk(ast, sec_refs = c("Content", "R Markdown")))
  expect_true(rmd_has_chunk(ast, sec_refs = c("Content", "Including Plots")))

  expect_false(rmd_has_chunk(ast, sec_refs = c("Content", "Setup")))
  expect_false(rmd_has_chunk(ast, sec_refs = c("Setuo", "R Markdown")))

  # Bad Chunk refs
  expect_false(rmd_has_chunk(ast, sec_refs = c("Setup", "R Markdown"),  name_refs = "pressure"))
  expect_false(rmd_has_chunk(ast, sec_refs = c("Including Plots"),  name_refs = "cars"))
})


test_that("rmd_has_markdown", {

  # minimal.Rmd
  ast = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

  expect_true(rmd_has_markdown(ast))

  expect_false(rmd_has_markdown(ast, sec_refs = c("Setup")))

  expect_true(rmd_has_markdown(ast, sec_refs = "Content"))
  expect_true(rmd_has_markdown(ast, sec_refs = c("Content", "R Markdown")))
  expect_true(rmd_has_markdown(ast, sec_refs = c("Content", "Including Plots")))




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
