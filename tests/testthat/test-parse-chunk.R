make_chunk_obj = function(
  engine = "r", name = "",
  options = structure(list(), names = character()),
  code = character()
) {
  structure(
    list(
      engine = engine, name = name, options = options, code = code
    ),
    class = "rmd_chunk"
  )
}


test_that("chunk parsing - Basic", {
  expect_equal(
    rmdast:::check_chunk_parser("```{r}\n```\n"),
    make_chunk_obj()
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r test}\n```\n"),
    make_chunk_obj(name = "test")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=1}\n```\n"),
    make_chunk_obj(options = list(x = "1"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=1, y=2}\n```\n"),
    make_chunk_obj(options = list(x = "1", y = "2"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r test, x=1, y=2}\n```\n"),
    make_chunk_obj(name = "test", options = list(x = "1", y = "2"))
  )
})

test_that("chunk parsing - name", {
  expect_equal(
    rmdast:::check_chunk_parser("```{r test}\n```\n"),
    make_chunk_obj(name = "test")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r \"test\"}\n```\n"),
    make_chunk_obj(name = "test")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r 'test'}\n```\n"),
    make_chunk_obj(name = "test")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r `test`}\n```\n"),
    make_chunk_obj(name = "test")
  )
})



test_that("chunk parsing - option names", {

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=1}\n```\n"),
    make_chunk_obj(options = list(x = "1"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r .x=1}\n```\n"),
    make_chunk_obj(options = list(".x" = "1"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r \"x\"=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r 'x'=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r `x`=1}\n```\n"),
    make_chunk_obj(options = list("x" = "1"))
  )
})

test_that("chunk parsing - option values", {

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=log(1)}\n```\n"),
    make_chunk_obj(options = list(x = "log(1)"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=paste(\"hello\", 1)}\n```\n"),
    make_chunk_obj(options = list(x = "paste(\"hello\", 1)"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r x=\"}\"}\n```\n"),
    make_chunk_obj(options = list(x = '"}"'))
  )
})

test_that("chunk parsing - code", {
  expect_equal(
    rmdast:::check_chunk_parser("```{r}\n1+1\n```\n"),
    make_chunk_obj(code = "1+1")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r}\nlog(3)\n```\n"),
    make_chunk_obj(code = "log(3)")
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r}\n\"```\"\n```\n"),
    make_chunk_obj(code = '"```"')
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r}\n1\nx\n3\n```\n"),
    make_chunk_obj(code = c("1", "x", "3"))
  )

  expect_equal(
    rmdast:::check_chunk_parser("```{r}\n1\n\n3\n```\n"),
    make_chunk_obj(code = c("1", "", "3"))
  )
})
