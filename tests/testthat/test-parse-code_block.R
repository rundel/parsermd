

test_that("code block parsing - Basic", {
  expect_equal(
    check_code_block_parser("```\n```\n"),
    create_code_block()
  )

  expect_equal(
    check_code_block_parser("```r\n```\n"),
    create_code_block(attr = "r")
  )

  expect_equal(
    check_code_block_parser("``` r\n```\n"),
    create_code_block(attr = "r")
  )

  expect_equal(
    check_code_block_parser("```{{r}}\n```\n"),
    create_code_block(attr = "{{r}}")
  )

  expect_equal( # Check proper disabiguation of code block vs. chunk
    parse_rmd("```{{r}}\n```\n"),
    create_ast(
      create_code_block(attr = "{{r}}")
    )
  )

  expect_equal(
    check_code_block_parser("```abc def\n```\n"),
    create_code_block(attr = "abc def")
  )

  expect_equal(
    check_code_block_parser("``` abc def\n```\n"),
    create_code_block(attr = "abc def")
  )


  expect_equal(
    check_code_block_parser("````\n````\n"),
    create_code_block(n_ticks = 4L)
  )

  expect_equal(
    check_code_block_parser("````r\n````\n"),
    create_code_block(attr="r", n_ticks=4L)
  )

  expect_equal(
    check_code_block_parser("````r\n```\n````\n"),
    create_code_block(attr="r", n_ticks=4L, code="```")
  )

  expect_equal(
    check_code_block_parser("````r\n```\n```\n````\n"),
    create_code_block(attr="r", n_ticks=4L, code=c("```", "```"))
  )

  expect_snapshot(
    check_code_block_parser("````r\n````\n````\n"),
    error=TRUE
  )
})

test_that("code block parsing - Indents", {
  expect_equal(
    check_code_block_parser("  ```\n  ```\n"),
    create_code_block(indent="  ")
  )

  expect_equal(
    check_code_block_parser("\t```\n\t```\n"),
    create_code_block(indent="\t")
  )

  expect_equal(
    check_code_block_parser("> ```\n> ```\n"),
    create_code_block(indent="> ")
  )

  expect_snapshot(
    check_code_block_parser("  ```\n\t```\n"),
    error=TRUE
  )

  expect_snapshot(
    check_code_block_parser("  ```\n> ```\n"),
    error=TRUE
  )

  expect_snapshot(
    check_code_block_parser("  ```\n   ```\n"),
    error=TRUE
  )

  # With code

  expect_equal(
    check_code_block_parser("  ```\n  1+1\n  ```\n"),
    create_code_block(indent="  ", code="1+1")
  )

  expect_equal(
    check_code_block_parser("\t```\n\t1+1\n\t```\n"),
    create_code_block(indent="\t", code="1+1")
  )

  expect_equal(
    check_code_block_parser("> ```\n> 1+1\n> ```\n"),
    create_code_block(indent="> ", code="1+1")
  )

  ## Handling of blank lines within indented blocks
  expect_equal(
    check_code_block_parser("  ```\n  1+1\n  \n  2+2\n  ```\n"),
    check_code_block_parser("  ```\n  1+1\n\n  2+2\n  ```\n")
  )

  expect_equal(
    check_code_block_parser("  ```\n  1+1\n\n  2+2\n  ```\n"),
    create_code_block(indent="  ", code=c("1+1","","2+2"))
  )
})
