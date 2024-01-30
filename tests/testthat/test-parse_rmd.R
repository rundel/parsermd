test_that("minimal.Rmd", {
  ast = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))

  expected_ast = create_ast(
    create_yaml(
      'title: "Minimal"',
      'author: "Colin Rundel"',
      'date: "7/21/2020"',
      'output: html_document',
      parse = TRUE
    ),
    create_heading("Setup", 1),
    create_chunk(
      name = "setup", options = list(include = "FALSE"),
      code = "knitr::opts_chunk$set(echo = TRUE)"
    ),
    create_heading("Content", 1),
    create_heading("R Markdown", 2),
    create_markdown(
      'This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, ',
      'PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.',
      '',
      'When you click the **Knit** button a document will be generated that includes both content as well ',
      'as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:',
      ''
    ),
    create_chunk(
      name = "cars", code = "summary(cars)"
    ),
    create_chunk(
      name = "unnamed-chunk-1", code = "knitr::knit_patterns$get()"
    ),
    create_heading("Including Plots", 2),
    create_markdown("You can also embed plots, for example:", ""),
    create_chunk(
      name = "pressure", options = list(echo = "FALSE"),
      code = "plot(pressure)"
    ),
    create_markdown(
      "Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code ",
      "that generated the plot."
    )
  )

  expect_identical(ast, expected_ast)
})

test_that("Found issues", {

  # No newline at the end
  expect_equal(
    parse_rmd("```{r}\n1+1\n```"),
    create_ast(create_chunk(name = "unnamed-chunk-1", code = "1+1"))
  )
})


