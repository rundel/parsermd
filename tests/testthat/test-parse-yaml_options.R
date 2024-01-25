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
  parse = function(x) {
    parse_yaml( parsermd:::check_chunk_parser(x) )
  }

  expect_identical(
    parse("```{r}\n#| foo: bar\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(foo = "bar")
    )
  )

  expect_identical(
    parse("```{r}\n#| foo: bar\n#| hello: world\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(foo = "bar", hello = "world")
    )
  )

  expect_identical(
    parse("```{r}\n#| echo: true\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(echo = TRUE)
    )
  )

  expect_identical(
    parse("```{r}\n#| fig-width: 100\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(`fig-width` = 100L)
    )
  )

  expect_identical(
    parse("```{r}\n#| fig-width: 0.5\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(`fig-width` = 0.5)
    )
  )
})


test_that("yaml options with break", {
  parse = function(x) {
    parse_yaml( parsermd:::check_chunk_parser(x) )
  }

  expect_identical(
    parse("```{r}\n#| echo: true\n```\n"),
    create_chunk(
      engine = "r", code=character(),
      yaml_options = list(echo = TRUE)
    )
  )

  expect_identical(
    parse("```{r}\n\n#| echo: true\n```\n"),
    create_chunk(
      engine = "r", code=c("", "#| echo: true")
    )
  )

  expect_identical(
    parse("```{r}\n#|\n#| echo: true\n```\n"),
    create_chunk(
      engine = "r", code=c("#|", "#| echo: true")
    )
  )

  expect_identical(
    parse("```{r}\n#| echo\n#| echo: true\n```\n"),
    create_chunk(
      engine = "r", code=c("#| echo", "#| echo: true")
    )
  )

  expect_identical(
    parse("```{r}\n#| echo: true\n#| echo\n```\n"),
    create_chunk(
      engine = "r", code=c("#| echo"),
      yaml_options = list(echo = TRUE)
    )
  )

  expect_identical(
    parse("```{r}\n#| echo: true\n#|\n#| fig-width: 10\n```\n"),
    create_chunk(
      engine = "r", code=c("#|", "#| fig-width: 10"),
      yaml_options = list(echo = TRUE)
    )
  )

  ## Indented

  expect_identical(
    parse("  ```{r}\n  #| echo: true\n  ```\n"),
    create_chunk(
      engine = "r", code=c("#| echo: true"), indent = "  "
    )
  )

  expect_identical(
    parse("\t```{r}\n\t#| echo: true\n\t```\n"),
    create_chunk(
      engine = "r", code=c("#| echo: true"), indent = "\t"
    )
  )
})

test_that("parse full document with yaml options", {
  ast = parse_rmd(system.file("tests/testthat/knitr-examples/125-dash-options.Rmd", package = "parsermd"))
  expected_ast = create_ast(
    create_yaml(
      title = "Using dash options in YAML options header"
    ),
    create_markdown(
      "In Quarto, it is recommended to use YAML options format with dash in option name instead of dot. In knitr 1.44, any chunk option with dash will be transformed to its dot counterpart. This is because knitr is responsible for engine option parsing in Quarto. ",
      "",
      "This document checks that YAML options are parsed correctly and that dash option are correctly converted when provided in YAML. ",
      ""
    ),
    create_chunk(
      engine = "r",
      name = "unnamed-chunk-1",
      yaml_options = list(
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
  )

  expect_identical(ast, expected_ast)
})
