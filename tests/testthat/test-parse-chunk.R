


test_that("chunk parsing - Basic", {
  expect_equal(
    check_chunk_parser("```{r}\n```\n"),
    rmd_chunk()
  )

  expect_equal(
    check_chunk_parser("```{r test}\n```\n"),
    rmd_chunk(name = "test")
  )

  expect_equal(
    check_chunk_parser("```{r x=1}\n```\n"),
    rmd_chunk(options = list(x = 1))
  )

  expect_equal(
    check_chunk_parser("```{r x=1, y=2}\n```\n"),
    rmd_chunk(options = list(x = 1, y = 2))
  )

  expect_equal(
    check_chunk_parser("```{r test, x=1, y=2}\n```\n"),
    rmd_chunk(name = "test", options = list(x = 1, y = 2))
  )
})



test_that("chunk parsing - option names", {

  expect_equal(
    check_chunk_parser("```{r x=1}\n```\n"),
    rmd_chunk(options = list(x = 1))
  )

  expect_equal(
    check_chunk_parser("```{r .x=1}\n```\n"),
    rmd_chunk(options = list(".x" = 1))
  )

  expect_equal(
    check_chunk_parser("```{r \"x\"=1}\n```\n"),
    rmd_chunk(options = list("x" = 1))
  )

  expect_equal(
    check_chunk_parser("```{r 'x'=1}\n```\n"),
    rmd_chunk(options = list("x" = 1))
  )

  expect_equal(
    check_chunk_parser("```{r `x`=1}\n```\n"),
    rmd_chunk(options = list("x" = 1))
  )
})

test_that("chunk parsing - option values", {

  expect_equal(
    check_chunk_parser("```{r x=log(1)}\n```\n"),
    rmd_chunk(options = list(x = "log(1)"))
  )

  expect_equal(
    check_chunk_parser("```{r x=paste(\"hello\", 1)}\n```\n"),
    rmd_chunk(options = list(x = "paste(\"hello\", 1)"))
  )

  expect_equal(
    check_chunk_parser("```{r x=\"}\"}\n```\n"),
    rmd_chunk(options = list(x = '"}"'))
  )
})

test_that("chunk parsing - code", {
  expect_equal(
    check_chunk_parser("```{r}\n1+1\n```\n"),
    rmd_chunk(code = "1+1")
  )

  expect_equal(
    check_chunk_parser("```{r}\nlog(3)\n```\n"),
    rmd_chunk(code = "log(3)")
  )

  expect_equal(
    check_chunk_parser("```{r}\n\"```\"\n```\n"),
    rmd_chunk(code = '"```"')
  )

  expect_equal(
    check_chunk_parser("```{r}\n1\nx\n3\n```\n"),
    rmd_chunk(code = c(1, "x", "3"))
  )

  expect_equal(
    check_chunk_parser("```{r}\n1\n\n3\n```\n"),
    rmd_chunk(code = c(1, "", "3"))
  )
})


test_that("chunk parsing - issues", {
  # allow dashes
  expect_equal(
    check_chunk_parser("```{r load-packages, message=FALSE}\n```\n"),
    rmd_chunk(name="load-packages", options = list(message=FALSE))
  )

  # allow engine, opt1=val for a chunk
  expect_equal(
    check_chunk_parser("```{r, include=FALSE}\n```\n"),
    rmd_chunk(options = list(include=FALSE))
  )

  # trailing white spaces causes an issue
  expect_equal(
    check_chunk_parser("```{r} \n```\n"),
    rmd_chunk()
  )

  expect_equal(
    check_chunk_parser("```{r}\n``` \n"),
    rmd_chunk()
  )

  expect_equal(
    check_chunk_parser("```{r} \n``` \n"),
    rmd_chunk()
  )
})


test_that("chunk parsing - indented", {

  expect_equal(
    check_chunk_parser("  ```{r test, include=FALSE}\n  1+1\n  ```\n"),
    rmd_chunk(
      name = "test", options = list(include = FALSE),
      code = "1+1", indent = "  "
    )
  )

  expect_equal(
    check_chunk_parser("    ```{r test, include=FALSE}\n    1+1\n    ```\n"),
    rmd_chunk(
      name = "test", options = list(include = FALSE),
      code = "1+1", indent = "    "
    )
  )

  expect_equal(
    check_chunk_parser("\t```{r}\n\tprint('hello indented world')\n\t```\n"),
    rmd_chunk(
      code = "print('hello indented world')", indent = "\t"
    )
  )

  expect_equal(
    check_chunk_parser("> ```{r}\n> print('hello indented world')\n> ```\n"),
    rmd_chunk(
      code = "print('hello indented world')", indent = "> "
    )
  )

  ## Bad indents

  expect_error(
    check_chunk_parser("> ```{r}\n  ```\n"),
  )

  expect_error(
    check_chunk_parser("```{r}\n ```\n"),
  )

  expect_error(
    check_chunk_parser(" ```{r}\n```\n"),
  )


  ## Handling of blank lines within indented blocks
  expect_equal(
    check_chunk_parser("  ```{r}\n  1+1\n  \n  2+2\n  ```\n"),
    check_chunk_parser("  ```{r}\n  1+1\n\n  2+2\n  ```\n")
  )

  expect_equal(
    check_chunk_parser("  ```{r}\n  1+1\n\n  2+2\n  ```\n"),
    rmd_chunk(indent="  ", code=c("1+1","","2+2"))
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
    check_chunk_parser("```{r, bob}\n```\n"),
    rmd_chunk(name = "bob")
  )

  expect_equal(
    check_chunk_parser("```{r, include = FALSE}\n```\n"),
    rmd_chunk(option = list(include=FALSE))
  )

  expect_equal(
    check_chunk_parser("```{r, bob, include = FALSE}\n```\n"),
    rmd_chunk(name = "bob", option = list(include=FALSE))
  )
})


test_that("chunk parsing - variants", {
  # Cover all possible variants of labels and options

  parse = check_chunk_parser

  # No label, no options
  expect_equal( parse("```{r}\n```\n"),   rmd_chunk() )
  expect_equal( parse("```{r,}\n```\n"),  rmd_chunk() )
  expect_equal( parse("```{r,,}\n```\n"), rmd_chunk() )

  # Label, no options
  expect_equal( parse("```{r m}\n```\n"),  rmd_chunk(name = "m") )
  expect_equal( parse("```{r m,}\n```\n"), rmd_chunk(name = "m") )

  # No label, options
  expect_equal( parse("```{r x=1}\n```\n"),   rmd_chunk(option = list(x = 1)) )
  expect_equal( parse("```{r x=1,}\n```\n"),  rmd_chunk(option = list(x = 1)) )
  expect_equal( parse("```{r, x=1}\n```\n"),  rmd_chunk(option = list(x = 1)) )
  expect_equal( parse("```{r, x=1,}\n```\n"), rmd_chunk(option = list(x = 1)) )

  expect_equal( parse("```{r x=1, y=1}\n```\n"),
                rmd_chunk(option = list(x=1, y=1)) )
  expect_equal( parse("```{r x=1, y=1,}\n```\n"),
                rmd_chunk(option = list(x=1, y=1)) )
  expect_equal( parse("```{r, x=1, y=1}\n```\n"),
                rmd_chunk(option = list(x=1, y=1)) )
  expect_equal( parse("```{r, x=1, y=1,}\n```\n"),
                rmd_chunk(option = list(x=1, y=1)) )

  # label, options
  expect_equal( parse("```{r m, x=1}\n```\n"),
                rmd_chunk(name = "m", option = list(x = 1)) )
  expect_equal( parse("```{r m, x=1,}\n```\n"),
                rmd_chunk(name = "m", option = list(x = 1)) )
  expect_equal( parse("```{r, m, x=1}\n```\n"),
                rmd_chunk(name = "m", option = list(x = 1)) )
  expect_equal( parse("```{r, m, x=1,}\n```\n"),
                rmd_chunk(name = "m", option = list(x = 1)) )
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

  expect_equal( 
    check_chunk_parser("```{=html}\n```\n"), 
    rmd_raw_chunk("html")
  )
  expect_equal( 
    check_chunk_parser("```{=md}\n```\n"),   
    rmd_raw_chunk("md") 
  )

  # Check code
  expect_equal(
    check_chunk_parser("```{=html}\n<h1>hello</h1>\n```\n"),
    rmd_raw_chunk("html", code = "<h1>hello</h1>")
  )

  # Check indent
  expect_equal(
    check_chunk_parser("   ```{=html}\n   <h1>hello</h1>\n   ```\n"),
    rmd_raw_chunk("html", code = "<h1>hello</h1>", indent = "   ")
  )

  # Bad
  expect_snapshot( check_chunk_parser("```{=}\n```\n"),   error=TRUE)
  expect_snapshot( check_chunk_parser("```{==}\n```\n"),  error=TRUE)
  expect_snapshot( check_chunk_parser("```{=a=}\n```\n"), error=TRUE)
  expect_snapshot( check_chunk_parser("```{a=}\n```\n"),  error=TRUE)
})



test_that("chunk parsing - more than 3 ticks", {
  expect_equal(
    check_chunk_parser("```{r}\n```\n"), 
    rmd_chunk()
  )

  expect_equal(
    check_chunk_parser("````{r}\n````\n"), 
    rmd_chunk(n_ticks = 4L)
  )

  expect_equal(
    check_chunk_parser("`````{r}\n`````\n"), 
    rmd_chunk(n_ticks = 5L)
  )

  expect_equal(
    check_chunk_parser("  ````{r}\n  ````\n"), 
    rmd_chunk(n_ticks = 4L, indent = "  ")
  )

  expect_equal(
    check_chunk_parser("\t````{r}\n\t````\n"), 
    rmd_chunk(n_ticks = 4L, indent = "\t")
  )

  expect_equal(
    check_chunk_parser("> ````{r}\n> ````\n"), 
    rmd_chunk(n_ticks = 4L, indent = "> ")
  )

  ## Unbalanced ticks

  expect_snapshot(
    check_chunk_parser("````{r}\n```"), error=TRUE
  )

  expect_snapshot(
    check_chunk_parser("```{r}\n````"), error=TRUE
  )

  expect_snapshot(
    check_chunk_parser("````{r}\n`````"), error=TRUE
  )

  expect_snapshot(
    check_chunk_parser("`````{r}\n````"), error=TRUE
  )
})


test_that("chunk parsing - nested ticks", {
  
  expect_equal(
    check_chunk_parser("````{r}\n```\n````\n"), 
    rmd_chunk(code="```", n_ticks = 4L)
  )

  expect_equal(
    check_chunk_parser("````{r}\n```\n```\n````\n"),
    rmd_chunk(code=c("```","```"), n_ticks = 4L)
  )

  expect_equal(
    check_chunk_parser("````{r}\n```{r}\n```\n````\n"),
    rmd_chunk(code=c("```{r}","```"), n_ticks = 4L)
  )

  expect_equal(
    parse_rmd("````{r}\n````\n````\n````\n"),
    rmd_ast( list(
      rmd_chunk(n_ticks = 4L, name = "unnamed-chunk-1"),
      rmd_code_block(n_ticks = 4L)
    ) )
  )
})

