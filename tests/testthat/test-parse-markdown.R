test_that("markdown - headings", {
  expect_equal(
    parsermd:::check_markdown_heading_parser("# h1\n"),
    create_heading("h1", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("## h2\n"),
    create_heading("h2", 2)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("### h3\n"),
    create_heading("h3", 3)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("#### h4\n"),
    create_heading("h4", 4)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("##### h5\n"),
    create_heading("h5", 5)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("###### h6\n"),
    create_heading("h6", 6)
  )
})

test_that("markdown - headings - blank", {

  expect_equal(
    parsermd:::check_markdown_heading_parser("# \n"),
    create_heading("", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("###### \n"),
    create_heading("", 6)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("#\n"),
    create_heading("", 1)
  )

  expect_equal(
    parsermd:::check_markdown_heading_parser("######\n"),
    create_heading("", 6)
  )

})


make_md_obj = function(...) {
  md = as.character(list(...))
  class(md) = "rmd_markdown"

  md
}


test_that("markdown", {

  expect_equal(
    check_markdown_parser("test\ntest\n"),
    list(make_md_obj("test", "test"))
  )

  expect_equal(
    check_markdown_parser("test\n# h1\n"),
    list(make_md_obj("test"), create_heading("h1", 1))
  )

  expect_equal(
    check_markdown_parser("test\n# h1\ntest\n"),
    list(make_md_obj("test"), create_heading("h1", 1), make_md_obj("test"))
  )

  expect_equal(
    check_markdown_parser("# h1\n## h2\ntest\n### h3\nhello\n"),
    list(
      create_heading("h1", 1),
      create_heading("h2", 2),
      make_md_obj("test"),
      create_heading("h3", 3),
      make_md_obj("hello")
    )
  )
})

