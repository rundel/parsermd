test_that("code block parsing", {

  expect_equal(
    check_code_block_parser("```\n1+1\n```\n"),
    create_code_block(code = "1+1")
  )

  expect_equal(
    check_code_block_parser("```r\n1+1\n```\n"),
    create_code_block(code = "1+1", info = "r")
  )

  expect_equal(
    check_code_block_parser("```{}\n1+1\n```\n"),
    create_code_block(code = "1+1", info = "{}")
  )

  expect_equal(
    check_code_block_parser("```{r}\n1+1\n```\n"),
    create_code_block(code = "1+1", info = "{r}")
  )

  expect_equal(
    check_code_block_parser("~~~\n1+1\n~~~\n"),
    create_code_block(code = "1+1", fence = "~~~")
  )

  expect_equal(
    check_code_block_parser("~~~r\n1+1\n~~~\n"),
    create_code_block(code = "1+1", info = "r", fence = "~~~")
  )

  expect_equal(
    check_code_block_parser("~~~{}\n1+1\n~~~\n"),
    create_code_block(code = "1+1", info = "{}", fence = "~~~")
  )

  expect_equal(
    check_code_block_parser("~~~{r}\n1+1\n~~~\n"),
    create_code_block(code = "1+1", info = "{r}", fence = "~~~")
  )
})

test_that("long fences", {

  for (i in c(4,6,9,12)) {
    fence_tick = paste(rep('`', i), collapse="")
    fence_tilde = paste(rep('~', i), collapse="")

    expect_equal(
      check_code_block_parser(paste0(fence_tick, '\n', fence_tick, '\n')),
      create_code_block(code = character(), fence = fence_tick)
    )

    expect_equal(
      check_code_block_parser(paste0(fence_tilde, '\n', fence_tilde, '\n')),
      create_code_block(code = character(), fence = fence_tilde)
    )
  }

  expect_error(check_code_block_parser("``\n```\n"))
  expect_error(check_code_block_parser("```\n``\n"))
  expect_error(check_code_block_parser("````\n```\n"))
  expect_error(check_code_block_parser("```\n````\n"))

  expect_error(check_code_block_parser("~~\n~~~\n"))
  expect_error(check_code_block_parser("~~~\n~~\n"))
  expect_error(check_code_block_parser("~~~~\n~~~\n"))
  expect_error(check_code_block_parser("~~~\n~~~~\n"))

})

test_that("mixed fences", {

  expect_equal(
    check_code_block_parser("```\n1+1\n~~~\n```\n"),
    create_code_block(code = c("1+1","~~~") ,fence = "```")
  )

  expect_equal(
    check_code_block_parser("```\n1+1\n~~~~\n```\n"),
    create_code_block(code = c("1+1","~~~~") ,fence = "```")
  )

  expect_equal(
    check_code_block_parser("~~~\n1+1\n```\n~~~\n"),
    create_code_block(code = c("1+1","```") ,fence = "~~~")
  )

  expect_equal(
    check_code_block_parser("~~~\n1+1\n````\n~~~\n"),
    create_code_block(code = c("1+1","````") ,fence = "~~~")
  )

  # FIXME - Not sure about this one md4c parses as two code blocks
  expect_equal(
    check_code_block_parser("```\n1+1\n````\n```\n"),
    create_code_block(code = c("1+1","````") ,fence = "```")
  )
})

test_that("indents", {
  expect_equal(
    check_code_block_parser("  ~~~\n  1+1\n  ~~~\n"),
    create_code_block(code = c("1+1") ,fence = "~~~", indent = "  ")
  )

  expect_equal(
    check_code_block_parser("  ```\n  1+1\n  ```\n"),
    create_code_block(code = c("1+1") ,fence = "```", indent = "  ")
  )

  expect_equal(
    check_code_block_parser("    ```\n    1+1\n    ```\n"),
    create_code_block(code = c("1+1") ,fence = "```", indent = "    ")
  )

  expect_equal(
    check_code_block_parser("\t```\n\t1+1\n\t```\n"),
    create_code_block(code = c("1+1") ,fence = "```", indent = "\t")
  )

  expect_equal(
    check_code_block_parser(" \t```\n \t1+1\n \t```\n"),
    create_code_block(code = c("1+1") ,fence = "```", indent = " \t")
  )

  expect_error(check_code_block_parser("  ```\n 1+1\n ```\n"))
  expect_error(check_code_block_parser(" ```\n 1+1\n  ```\n"))
  expect_error(check_code_block_parser(" ```\n\t1+1\n ```\n"))
})


test_that("Verbatim code chunks", {
  expect_equal(
    check_code_block_parser("```{r, eval=TRUE}`r ''`\n1+1\n```\n"),
    create_code_block(
      code = c("1+1"),
      fence = "```",
      info = "{r, eval=TRUE}`r ''`"
    )
  )
})
