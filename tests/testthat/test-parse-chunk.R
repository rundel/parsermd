check_chunk_parser_yaml = function(x) {
  parse_yaml(check_chunk_parser(x))
}



test_that("chunk parsing - Basic", {
  expect_equal(
    check_chunk_parser_yaml("```{r}\n```\n"),
    create_chunk()
  )

  expect_equal(
    check_chunk_parser_yaml("```{r test}\n```\n"),
    create_chunk(name = "test")
  )

  expect_equal(
    check_chunk_parser_yaml("```{r x=1}\n```\n"),
    create_chunk(options = list(x = "1"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r x=1, y=2}\n```\n"),
    create_chunk(options = list(x = "1", y = "2"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r test, x=1, y=2}\n```\n"),
    create_chunk(name = "test", options = list(x = "1", y = "2"))
  )
})



test_that("chunk parsing - option names", {

  expect_equal(
    check_chunk_parser_yaml("```{r x=1}\n```\n"),
    create_chunk(options = list(x = "1"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r .x=1}\n```\n"),
    create_chunk(options = list(".x" = "1"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r \"x\"=1}\n```\n"),
    create_chunk(options = list("x" = "1"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r 'x'=1}\n```\n"),
    create_chunk(options = list("x" = "1"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r `x`=1}\n```\n"),
    create_chunk(options = list("x" = "1"))
  )
})

test_that("chunk parsing - option values", {

  expect_equal(
    check_chunk_parser_yaml("```{r x=log(1)}\n```\n"),
    create_chunk(options = list(x = "log(1)"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r x=paste(\"hello\", 1)}\n```\n"),
    create_chunk(options = list(x = "paste(\"hello\", 1)"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r x=\"}\"}\n```\n"),
    create_chunk(options = list(x = '"}"'))
  )
})

test_that("chunk parsing - code", {
  expect_equal(
    check_chunk_parser_yaml("```{r}\n1+1\n```\n"),
    create_chunk(code = "1+1")
  )

  expect_equal(
    check_chunk_parser_yaml("```{r}\nlog(3)\n```\n"),
    create_chunk(code = "log(3)")
  )

  expect_equal(
    check_chunk_parser_yaml("```{r}\n\"```\"\n```\n"),
    create_chunk(code = '"```"')
  )

  expect_equal(
    check_chunk_parser_yaml("```{r}\n1\nx\n3\n```\n"),
    create_chunk(code = c("1", "x", "3"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r}\n1\n\n3\n```\n"),
    create_chunk(code = c("1", "", "3"))
  )
})


test_that("chunk parsing - issues", {
  # allow dashes
  expect_equal(
    check_chunk_parser_yaml("```{r load-packages, message=FALSE}\n```\n"),
    create_chunk(name="load-packages", options = list(message="FALSE"))
  )

  # allow engine, opt1=val for a chunk
  expect_equal(
    check_chunk_parser_yaml("```{r, include=FALSE}\n```\n"),
    create_chunk(options = list(include="FALSE"))
  )

  # trailing white spaces causes an issue
  expect_equal(
    check_chunk_parser_yaml("```{r} \n```\n"),
    create_chunk()
  )

  expect_equal(
    check_chunk_parser_yaml("```{r}\n``` \n"),
    create_chunk()
  )

  expect_equal(
    check_chunk_parser_yaml("```{r} \n``` \n"),
    create_chunk()
  )
})


test_that("chunk parsing - indented", {

  expect_equal(
    check_chunk_parser_yaml("  ```{r test, include=FALSE}\n  1+1\n  ```\n"),
    create_chunk(
      name = "test", options = list(include = "FALSE"),
      code = "1+1", indent = "  "
    )
  )

  expect_equal(
    check_chunk_parser_yaml("\t```{r}\n\tprint('hello indented world')\n\t```\n"),
    create_chunk(
      code = "print('hello indented world')", indent = "\t"
    )
  )

  expect_equal(
    check_chunk_parser_yaml("> ```{r}\n> print('hello indented world')\n> ```\n"),
    create_chunk(
      code = "print('hello indented world')", indent = "> "
    )
  )

  expect_error(
    check_chunk_parser_yaml("> ```{r}\n  ```\n"),
  )

  expect_error(
    check_chunk_parser_yaml("```{r}\n ```\n"),
  )

  expect_error(
    check_chunk_parser_yaml(" ```{r}\n```\n"),
  )
})

test_that("chunk parsing - sequential", {

  expect_equal(
    check_multi_chunk_parser("```{r}\n1 + 1\n```{r}\nrnorm(10)\n```\n"),
    check_multi_chunk_parser("```{r}\n1 + 1\n```\n```{r}\nrnorm(10)\n```\n")
  )

  expect_equal(
    check_multi_chunk_parser("```{r include = FALSE}\n1 + 1\n```{r}\nrnorm(10)\n```\n"),
    check_multi_chunk_parser("```{r include = FALSE}\n1 + 1\n```\n```{r}\nrnorm(10)\n```\n")
  )

  expect_equal(
    check_multi_chunk_parser("```{r}\n1 + 1\n```{r include = FALSE}\nrnorm(10)\n```\n"),
    check_multi_chunk_parser("```{r}\n1 + 1\n```\n```{r include = FALSE}\nrnorm(10)\n```\n")
  )

  expect_equal(
    check_multi_chunk_parser("> ```{r}\n> 1 + 1\n> ```{r}\n> rnorm(10)\n> ```\n"),
    check_multi_chunk_parser("> ```{r}\n> 1 + 1\n> ```\n> ```{r}\n> rnorm(10)\n> ```\n")
  )

})

test_that("chunk parsing - comma after engine", {
  expect_equal(
    check_chunk_parser_yaml("```{r, bob}\n```\n"),
    create_chunk(name = "bob")
  )

  expect_equal(
    check_chunk_parser_yaml("```{r, include = FALSE}\n```\n"),
    create_chunk(option = list(include="FALSE"))
  )

  expect_equal(
    check_chunk_parser_yaml("```{r, bob, include = FALSE}\n```\n"),
    create_chunk(name = "bob", option = list(include="FALSE"))
  )
})


test_that("chunk parsing - variants", {
  # Cover all possible variants of labels and options

  parse = check_chunk_parser_yaml

  # No label, no options
  expect_equal( parse("```{r}\n```\n"),   create_chunk() )
  expect_equal( parse("```{r,}\n```\n"),  create_chunk() )
  expect_equal( parse("```{r,,}\n```\n"), create_chunk() )

  # Label, no options
  expect_equal( parse("```{r m}\n```\n"),  create_chunk(name = "m") )
  expect_equal( parse("```{r m,}\n```\n"), create_chunk(name = "m") )

  # No label, options
  expect_equal( parse("```{r x=1}\n```\n"),   create_chunk(option = list(x = "1")) )
  expect_equal( parse("```{r x=1,}\n```\n"),  create_chunk(option = list(x = "1")) )
  expect_equal( parse("```{r, x=1}\n```\n"),  create_chunk(option = list(x = "1")) )
  expect_equal( parse("```{r, x=1,}\n```\n"), create_chunk(option = list(x = "1")) )

  expect_equal( parse("```{r x=1, y=1}\n```\n"),
                create_chunk(option = list(x="1", y="1")) )
  expect_equal( parse("```{r x=1, y=1,}\n```\n"),
                create_chunk(option = list(x="1", y="1")) )
  expect_equal( parse("```{r, x=1, y=1}\n```\n"),
                create_chunk(option = list(x="1", y="1")) )
  expect_equal( parse("```{r, x=1, y=1,}\n```\n"),
                create_chunk(option = list(x="1", y="1")) )

  # label, options
  expect_equal( parse("```{r m, x=1}\n```\n"),
                create_chunk(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r m, x=1,}\n```\n"),
                create_chunk(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r, m, x=1}\n```\n"),
                create_chunk(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r, m, x=1,}\n```\n"),
                create_chunk(name = "m", option = list(x = "1")) )
})

test_that("chunk parsing - bad chunks", {
  parse = check_chunk_parser

  # Basic chunks
  expect_snapshot_error( parse("```{}\n```\n") )
  expect_snapshot_error( parse("```{r\n```\n") )
  expect_snapshot_error( parse("```r}\n```\n") )
  expect_snapshot_error( parse("```{r}\n``\n") )

  # Bad labels or options
  expect_snapshot_error( parse("```{r m, m}\n```\n") )
  expect_snapshot_error( parse("```{r abc.def}\n```\n") )
  expect_snapshot_error( parse("```{r m x=1}\n```\n") )
  expect_snapshot_error( parse("```{r x=}\n```\n") )
  expect_snapshot_error( parse("```{r x=, y=1}\n```\n") )
  expect_snapshot_error( parse("```{r x=1, y=}\n```\n") )
})


test_that("chunk parsing - raw attribute chunk", {
  parse = check_chunk_parser

  make_raw_chunk = function(format, code = character(), indent = "") {
    structure(
      list(format = format, code = code, indent = indent),
      class = "rmd_raw_chunk"
    )
  }

  expect_equal( parse("```{=html}\n```\n"),   make_raw_chunk("html") )
  expect_equal( parse("```{=md}\n```\n"),   make_raw_chunk("md") )

  # Check code
  expect_equal(
    parse("```{=html}\n<h1>hello</h1>\n```\n"),
    make_raw_chunk("html", code = "<h1>hello</h1>")
  )

  # Check indent
  expect_equal(
    parse("   ```{=html}\n   <h1>hello</h1>\n   ```\n"),
    make_raw_chunk("html", code = "<h1>hello</h1>", indent = "   ")
  )

  # Bad
  expect_error( parse("```{=}\n```\n"))
  expect_error( parse("```{==}\n```\n"))
  expect_error( parse("```{=a=}\n```\n"))
  expect_error( parse("```{a=}\n```\n"))
})
