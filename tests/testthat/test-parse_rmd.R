test_that("minimal.Rmd", {
  ast = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))

  expected_ast = rmd_ast( list(
    rmd_yaml( list(
      title = "Minimal",
      author = "Colin Rundel",
      date = "7/21/2020",
      output = "html_document"
    ) ),
    rmd_heading("Setup", 1L),
    rmd_chunk(
      label = "setup", options = list(include = FALSE),
      code = "knitr::opts_chunk$set(echo = TRUE)"
    ),
    rmd_heading("Content", 1L),
    rmd_heading("R Markdown", 2L),
    rmd_markdown( c(
      'This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, ',
      'PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.',
      '',
      'When you click the **Knit** button a document will be generated that includes both content as well ',
      'as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:'
    ) ),
    rmd_chunk(
      label = "cars", code = "summary(cars)"
    ),
    rmd_chunk(
      label = "unnamed-chunk-1", code = "knitr::knit_patterns$get()"
    ),
    rmd_heading("Including Plots", 2L),
    rmd_markdown(
      "You can also embed plots, for example:"
    ),
    rmd_chunk(
      label = "pressure", options = list(echo = FALSE),
      code = "plot(pressure)"
    ),
    rmd_markdown( c(
      "Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code ",
      "that generated the plot."
    ) )
  ) )

  expect_identical(ast, expected_ast)
})

test_that("Found issues", {

  # No newline at the end
  expect_equal(
    parse_rmd("```{r}\n1+1\n```"),
    rmd_ast( list(
      rmd_chunk(label = "unnamed-chunk-1", code = "1+1")
    ) )
  )
})


