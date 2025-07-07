test_that("basic yaml option parsing", {
  parse = function(x) {
    unclass( parse_yaml(
      check_yaml_option_parser(x)
    ) )
  }

  expect_identical(parse("#| foo: bar"), list(foo = "bar"))
  expect_identical(parse("  #| foo: bar"), list(foo = "bar"))
  expect_identical(parse("    #| foo: bar"), list(foo = "bar"))
  expect_identical(parse("#|  foo: bar"), list(foo = "bar"))
  expect_identical(parse("#| foo:  bar"), list(foo = "bar"))
  expect_identical(parse("#| foo : bar"), list(foo = "bar"))
  expect_identical(parse("#| foo:  bar\n#| hello: world"), list(foo = "bar", hello = "world"))
  expect_identical(
    parse("#| foo:  bar\n#| hello: world\n#| here: there"),
    list(foo = "bar", hello = "world", here = "there")
  )
})

test_that("chunk with yaml options", {

  expect_identical(
    check_chunk_parser("```{r}\n#| foo: bar\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(foo = "bar")
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#| foo: bar\n#| hello: world\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(foo = "bar", hello = "world")
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#| echo: true\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(echo = TRUE)
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#| fig-width: 100\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(`fig-width` = 100L)
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#| fig-width: 0.5\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(`fig-width` = 0.5)
    )
  )
})


test_that("yaml options with break", {

  expect_identical(
    check_chunk_parser("```{r}\n#| echo: true\n```\n"),
    rmd_chunk(
      engine = "r", code=character(),
      options = list(echo = TRUE)
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n\n#| echo: true\n```\n"),
    rmd_chunk(
      engine = "r", code=c("", "#| echo: true")
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#|\n#| echo: true\n```\n"),
    rmd_chunk(
      engine = "r", code=c("#|", "#| echo: true")
    )
  )

  expect_identical(
    check_chunk_parser("```{r}\n#| echo: true\n#| \n#| fig-width: 10\n```\n"),
    rmd_chunk(
      engine = "r",
      options = list(echo = TRUE, `fig-width` = 10L)
    )
  )

  ## Indented

  expect_identical(
    check_chunk_parser("  ```{r}\n  #| echo: true\n  ```\n"),
    rmd_chunk(
      engine = "r", code=c("#| echo: true"), indent = "  "
    )
  )

  expect_identical(
    check_chunk_parser("\t```{r}\n\t#| echo: true\n\t```\n"),
    rmd_chunk(
      engine = "r", code=c("#| echo: true"), indent = "\t"
    )
  )
})

test_that("parse full document with yaml options", {

  if (!dir.exists('examples'))
    skip('Additional example files not available')

  ast = parse_rmd("examples/knitr-examples/125-dash-options.Rmd")
  expected_ast = rmd_ast( list(
    rmd_yaml( list(
      title = "Using dash options in YAML options header"
    ) ),
    rmd_markdown(
      "In Quarto, it is recommended to use YAML options format with dash in option name instead of dot. In knitr 1.44, any chunk option with dash will be transformed to its dot counterpart. This is because knitr is responsible for engine option parsing in Quarto. "
    ),
    rmd_markdown(
      "This document checks that YAML options are parsed correctly and that dash option are correctly converted when provided in YAML. "
    ),
    rmd_chunk(
      engine = "r",
      name = "unnamed-chunk-1",
      options = list(
        eval = TRUE,
        echo = FALSE,
        `out-width` = 850L,
        `sql-max-print` = 1000L,
        `fig-cap` = "caption",
        `fig-dpi` = 750L,
        `fig-format` = "svg"
      ),
      code = 'knitr::opts_current$get(c("echo","out.width", "sql.max.print", "fig.cap", "dpi", "dev"))'
    )
  ) )

  expect_identical(ast, expected_ast)
})

test_that("Array arguments", {
  
  expect_equal(
    check_chunk_parser("```{r}\n#| layout: [[1,1], [1]]\n```\n"),
    rmd_chunk(options = list(layout = list(c(1,1), 1)))
  )

  expect_equal(
    check_chunk_parser("```{r}\n#| layout:\n#| - - 1\n#|   - 1\n#| - 1\n```\n"),
    rmd_chunk(options = list(layout = list(c(1,1), 1)))
  )

  expect_equal(
    check_chunk_parser("```{r}\n#| layout: [[1,1], [1]]\n```\n"),
    check_chunk_parser("```{r}\n#| layout:\n#| - - 1\n#|   - 1\n#| - 1\n```\n")
  )


})
