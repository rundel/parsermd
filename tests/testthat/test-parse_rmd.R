test_that("minimal.Rmd", {
  ast = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))

  expected_ast = rmd_ast(
    rmd_yaml(
      title = "Minimal",
      author = "Colin Rundel",
      date = "7/21/2020",
      output = "html_document"
    ),
    rmd_heading("Setup", 1),
    rmd_chunk(
      name = "setup", options = list(include = "FALSE"),
      code = "knitr::opts_chunk$set(echo = TRUE)"
    ),
    rmd_heading("Content", 1),
    rmd_heading("R Markdown", 2),
    rmd_markdown(
      rmd_markdown_line('This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, '),
      rmd_markdown_line('PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.'),
      rmd_markdown_line(''),
      rmd_markdown_line('When you click the **Knit** button a document will be generated that includes both content as well '),
      rmd_markdown_line('as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:'),
      rmd_markdown_line('')
    ),
    rmd_chunk(
      name = "cars", code = "summary(cars)"
    ),
    rmd_chunk(
      name = "unnamed-chunk-1", code = "knitr::knit_patterns$get()"
    ),
    rmd_heading("Including Plots", 2),
    rmd_markdown(
      rmd_markdown_line("You can also embed plots, for example:"),
      rmd_markdown_line("")
    ),
    rmd_chunk(
      name = "pressure", options = list(echo = "FALSE"),
      code = "plot(pressure)"
    ),
    rmd_markdown(
      rmd_markdown_line("Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code "),
      rmd_markdown_line("that generated the plot.")
    )
  )

  expect_identical(ast, expected_ast)
})

test_that("Found issues", {

  # No newline at the end
  expect_equal(
    parse_rmd("```{r}\n1+1\n```"),
    rmd_ast(rmd_chunk(name = "unnamed-chunk-1", code = "1+1"))
  )
})


