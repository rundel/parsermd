test_that("markdown - headings", {
  expect_equal(
    parsermd:::check_markdown_heading_parser("# h1\n"),
    rmd_heading("h1", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("## h2\n"),
    rmd_heading("h2", 2)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("### h3\n"),
    rmd_heading("h3", 3)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("#### h4\n"),
    rmd_heading("h4", 4)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("##### h5\n"),
    rmd_heading("h5", 5)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("###### h6\n"),
    rmd_heading("h6", 6)
  )
})

test_that("markdown - headings - blank", {

  expect_equal(
    parsermd:::check_markdown_heading_parser("# \n"),
    rmd_heading("", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("###### \n"),
    rmd_heading("", 6)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("#\n"),
    rmd_heading("", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("######\n"),
    rmd_heading("", 6)
  )

})
