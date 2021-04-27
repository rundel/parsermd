test_that("check output - with content", {
  ast = parse_rmd(system.file("hw02-complex.Rmd", package="parsermd"))
  ans = rmd_select(ast, by_section(c("Exercise *", "Answer")))
  template = rmd_template(ans, keep_content = TRUE)

  expect_snapshot( rmd_check_template(ast, template) )
  expect_snapshot( rmd_check_template(as_tibble(ast)[1,], template) ) # Just the YAML
  expect_snapshot( rmd_check_template(as_tibble(ast)[9:10,], template) ) # Just Ex1
  expect_snapshot( rmd_check_template(as_tibble(ast)[15:19,], template) ) # Just Ex2
})

test_that("check output - without content", {
  ast = parse_rmd(system.file("hw02-complex.Rmd", package="parsermd"))
  ans = rmd_select(ast, by_section(c("Exercise *", "Answer")))
  template = rmd_template(ans, keep_content = FALSE)

  expect_snapshot( rmd_check_template(ast, template) )
  expect_snapshot( rmd_check_template(as_tibble(ast)[1,], template) ) # Just the YAML
  expect_snapshot( rmd_check_template(as_tibble(ast)[9:10,], template) ) # Just Ex1
  expect_snapshot( rmd_check_template(as_tibble(ast)[15:19,], template) ) # Just Ex2
})
