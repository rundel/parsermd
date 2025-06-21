
test_that("markdown", {

  expect_identical(
    check_markdown_parser("test\n"),
    rmd_markdown(
      rmd_markdown_line("test")
    )
  )

  expect_identical(
    check_markdown_parser("test\ntest\n"),
    rmd_markdown(
      rmd_markdown_line("test"),
      rmd_markdown_line("test")
    )
  )

  expect_identical(
    check_markdown_parser("`r 1+1`\n"),
    rmd_markdown(
      rmd_markdown_line(
        rmd_inline_code(engine = "r", code="1+1")
      )
    )
  )

  expect_identical(
    check_markdown_parser("`{r} 1+1`\n"),
    rmd_markdown(
      rmd_markdown_line(
        rmd_inline_code(engine = "r", code="1+1")
      )
    )
  )

  expect_identical(
    check_markdown_parser("``r 1+1``\n"),
    rmd_markdown(
      rmd_markdown_line(
        "`", rmd_inline_code(engine = "r", code="1+1"), "`"
      )
    )
  )

  expect_identical(
    check_markdown_parser("``{r} 1+1``\n"),
    rmd_markdown(
      rmd_markdown_line("`", rmd_inline_code(engine = "r", code="1+1"), "`")
    )
  )
})

test_that("Mixed", {

  # With shortcodes now parsed post-processing, we expect 2 elements:
  # 1. Text containing the shortcode: "hello {{< test >}} "
  # 2. Inline code: `r 1+1`
  result = check_markdown_parser("hello {{< test >}} `r 1+1`\n")
  expect_equal(length(result[[1]]), 2)
  
  # First element should be text with embedded shortcode
  expect_true(is.character(result[[1]][[1]]))
  expect_true(grepl("\\{\\{< test >\\}\\}", result[[1]][[1]]))
  
  # Second element should be inline code
  expect_equal(result[[1]][[2]]$engine, "r")
  expect_equal(result[[1]][[2]]$code, "1+1")
})
