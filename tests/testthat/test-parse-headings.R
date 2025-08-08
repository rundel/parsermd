test_that("markdown - headings", {
  expect_equal(
    check_markdown_heading_parser("# h1\n"),
    rmd_heading("h1", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("## h2\n"),
    rmd_heading("h2", 2L)
  )

  expect_equal(
    check_markdown_heading_parser("### h3\n"),
    rmd_heading("h3", 3L)
  )

  expect_equal(
    check_markdown_heading_parser("#### h4\n"),
    rmd_heading("h4", 4L)
  )

  expect_equal(
    check_markdown_heading_parser("##### h5\n"),
    rmd_heading("h5", 5L)
  )

  expect_equal(
    check_markdown_heading_parser("###### h6\n"),
    rmd_heading("h6", 6L)
  )
})

test_that("markdown - headings - blank", {

  expect_equal(
    check_markdown_heading_parser("# \n"),
    rmd_heading("", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("###### \n"),
    rmd_heading("", 6L)
  )

  expect_equal(
    check_markdown_heading_parser("#\n"),
    rmd_heading("", 1L)
  )

  expect_equal(
    check_markdown_heading_parser("######\n"),
    rmd_heading("", 6L)
  )

})
