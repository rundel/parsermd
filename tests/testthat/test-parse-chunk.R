make_chunk_obj = function(
  engine = "r", name = "",
  options = structure(list(), names = character()),
  code = character(),
  indent = ""
) {
  structure(
    list(
      engine = engine, name = name, options = options, code = code, indent = indent
    ),
    class = "rmd_chunk"
  )
}





test_that("chunk parsing - Basic", {
  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n```\n"),
    make_chunk_obj()
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r test}\n```\n"),
    make_chunk_obj(name = "test")
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=1}\n```\n"),
    make_chunk_obj(options = list(x = "1"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=1, y=2}\n```\n"),
    make_chunk_obj(options = list(x = "1", y = "2"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r test, x=1, y=2}\n```\n"),
    make_chunk_obj(name = "test", options = list(x = "1", y = "2"))
  )
})

test_that("chunk parsing - name", {
  expect_equal(
    parsermd:::check_chunk_parser("```{r test}\n```\n"),
    make_chunk_obj(name = "test")
  )
})



test_that("chunk parsing - option names", {

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=1}\n```\n"),
    make_chunk_obj(options = list(x = "1"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r .x=1}\n```\n"),
    make_chunk_obj(options = list(".x" = "1"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r \"x\"=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r 'x'=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r `x`=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )
})

test_that("chunk parsing - option values", {

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=log(1)}\n```\n"),
    make_chunk_obj(options = list(x = "log(1)"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=paste(\"hello\", 1)}\n```\n"),
    make_chunk_obj(options = list(x = "paste(\"hello\", 1)"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r x=\"}\"}\n```\n"),
    make_chunk_obj(options = list(x = '"}"'))
  )
})

test_that("chunk parsing - code", {
  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n1+1\n```\n"),
    make_chunk_obj(code = "1+1")
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r}\nlog(3)\n```\n"),
    make_chunk_obj(code = "log(3)")
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n\"```\"\n```\n"),
    make_chunk_obj(code = '"```"')
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n1\nx\n3\n```\n"),
    make_chunk_obj(code = c("1", "x", "3"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n1\n\n3\n```\n"),
    make_chunk_obj(code = c("1", "", "3"))
  )
})


test_that("chunk parsing - issues", {
  # allow dashes
  expect_equal(
    parsermd:::check_chunk_parser("```{r load-packages, message=FALSE}\n```\n"),
    make_chunk_obj(name="load-packages", options = list(message="FALSE"))
  )

  # allow engine, opt1=val for a chunk
  expect_equal(
    parsermd:::check_chunk_parser("```{r, include=FALSE}\n```\n"),
    make_chunk_obj(options = list(include="FALSE"))
  )

  # trailing white spaces causes an issue
  expect_equal(
    parsermd:::check_chunk_parser("```{r} \n```\n"),
    make_chunk_obj()
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r}\n``` \n"),
    make_chunk_obj()
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r} \n``` \n"),
    make_chunk_obj()
  )



})


test_that("chunk parsing - indented", {

  expect_equal(
    parsermd:::check_chunk_parser("  ```{r test, include=FALSE}\n  1+1\n  ```\n"),
    make_chunk_obj(name = "test", options = list(include = "FALSE"), code = "1+1", indent = "  ")
  )

  expect_equal(
    parsermd:::check_chunk_parser("\t```{r}\n\tprint('hello indented world')\n\t```\n"),
    make_chunk_obj(code = "print('hello indented world')", indent = "\t")
  )

  expect_equal(
    parsermd:::check_chunk_parser("> ```{r}\n> print('hello indented world')\n> ```\n"),
    make_chunk_obj(code = "print('hello indented world')", indent = "> ")
  )

  expect_error(
    parsermd:::check_chunk_parser("> ```{r}\n  ```\n"),
  )

  expect_error(
    parsermd:::check_chunk_parser("```{r}\n ```\n"),
  )

  expect_error(
    parsermd:::check_chunk_parser(" ```{r}\n```\n"),
  )
})

test_that("chunk parsing - sequential", {

  expect_equal(
    parsermd:::check_multi_chunk_parser("```{r}\n1 + 1\n```{r}\nrnorm(10)\n```\n"),
    parsermd:::check_multi_chunk_parser("```{r}\n1 + 1\n```\n```{r}\nrnorm(10)\n```\n")
  )

  expect_equal(
    parsermd:::check_multi_chunk_parser("```{r include = FALSE}\n1 + 1\n```{r}\nrnorm(10)\n```\n"),
    parsermd:::check_multi_chunk_parser("```{r include = FALSE}\n1 + 1\n```\n```{r}\nrnorm(10)\n```\n")
  )

  expect_equal(
    parsermd:::check_multi_chunk_parser("```{r}\n1 + 1\n```{r include = FALSE}\nrnorm(10)\n```\n"),
    parsermd:::check_multi_chunk_parser("```{r}\n1 + 1\n```\n```{r include = FALSE}\nrnorm(10)\n```\n")
  )

  expect_equal(
    parsermd:::check_multi_chunk_parser("> ```{r}\n> 1 + 1\n> ```{r}\n> rnorm(10)\n> ```\n"),
    parsermd:::check_multi_chunk_parser("> ```{r}\n> 1 + 1\n> ```\n> ```{r}\n> rnorm(10)\n> ```\n")
  )

})

test_that("chunk parsing - comma after engine", {
  expect_equal(
    parsermd:::check_chunk_parser("```{r, bob}\n```\n"),
    make_chunk_obj(name = "bob")
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r, include = FALSE}\n```\n"),
    make_chunk_obj(option = list(include="FALSE"))
  )

  expect_equal(
    parsermd:::check_chunk_parser("```{r, bob, include = FALSE}\n```\n"),
    make_chunk_obj(name = "bob", option = list(include="FALSE"))
  )
})


test_that("chunk parsing - variants", {
  # Cover all possible variants of labels and options

  parse = parsermd:::check_chunk_parser

  # No label, no options
  expect_equal( parse("```{r}\n```\n"),   make_chunk_obj() )
  expect_equal( parse("```{r,}\n```\n"),  make_chunk_obj() )
  expect_equal( parse("```{r,,}\n```\n"), make_chunk_obj() )

  # Label, no options
  expect_equal( parse("```{r m}\n```\n"),  make_chunk_obj(name = "m") )
  expect_equal( parse("```{r m,}\n```\n"), make_chunk_obj(name = "m") )

  # No label, options
  expect_equal( parse("```{r x=1}\n```\n"),   make_chunk_obj(option = list(x = "1")) )
  expect_equal( parse("```{r x=1,}\n```\n"),  make_chunk_obj(option = list(x = "1")) )
  expect_equal( parse("```{r, x=1}\n```\n"),  make_chunk_obj(option = list(x = "1")) )
  expect_equal( parse("```{r, x=1,}\n```\n"), make_chunk_obj(option = list(x = "1")) )

  expect_equal( parse("```{r x=1, y=1}\n```\n"),
                make_chunk_obj(option = list(x="1", y="1")) )
  expect_equal( parse("```{r x=1, y=1,}\n```\n"),
                make_chunk_obj(option = list(x="1", y="1")) )
  expect_equal( parse("```{r, x=1, y=1}\n```\n"),
                make_chunk_obj(option = list(x="1", y="1")) )
  expect_equal( parse("```{r, x=1, y=1,}\n```\n"),
                make_chunk_obj(option = list(x="1", y="1")) )

  # label, options
  expect_equal( parse("```{r m, x=1}\n```\n"),
                make_chunk_obj(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r m, x=1,}\n```\n"),
                make_chunk_obj(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r, m, x=1}\n```\n"),
                make_chunk_obj(name = "m", option = list(x = "1")) )
  expect_equal( parse("```{r, m, x=1,}\n```\n"),
                make_chunk_obj(name = "m", option = list(x = "1")) )
})

test_that("chunk parsing - bad chunks", {
  parse = parsermd:::check_chunk_parser

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
  parse = parsermd:::check_chunk_parser

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
