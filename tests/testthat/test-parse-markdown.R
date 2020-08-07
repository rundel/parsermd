make_md_heading_obj = function(name, level) {
  structure(list(name = name, level = level), class = "rmd_heading")
}


test_that("markdown - headings", {
  expect_equal(
    rmdast:::check_markdown_heading_parser("# h1\n"),
    make_md_heading_obj("h1", 1)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("## h2\n"),
    make_md_heading_obj("h2", 2)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("### h3\n"),
    make_md_heading_obj("h3", 3)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("#### h4\n"),
    make_md_heading_obj("h4", 4)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("##### h5\n"),
    make_md_heading_obj("h5", 5)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("###### h6\n"),
    make_md_heading_obj("h6", 6)
  )
})

test_that("markdown - headings - blank", {

  expect_equal(
    rmdast:::check_markdown_heading_parser("# \n"),
    make_md_heading_obj("", 1)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("###### \n"),
    make_md_heading_obj("", 6)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("#\n"),
    make_md_heading_obj("", 1)
  )

  expect_equal(
    rmdast:::check_markdown_heading_parser("######\n"),
    make_md_heading_obj("", 6)
  )

})

test_that("markdown", {

  expect_equal(
    rmdast:::check_markdown_parser("test\ntest\n"),
    list(c("test", "test"))
  )

  expect_equal(
    rmdast:::check_markdown_parser("test\n# h1\n"),
    list("test", make_md_heading_obj("h1", 1))
  )

  expect_equal(
    rmdast:::check_markdown_parser("test\n# h1\ntest\n"),
    list("test", make_md_heading_obj("h1", 1), "test")
  )

  expect_equal(
    rmdast:::check_markdown_parser("# h1\n## h2\ntest\n### h3\nhello\n"),
    list(
      make_md_heading_obj("h1", 1),
      make_md_heading_obj("h2", 2),
      "test",
      make_md_heading_obj("h3", 3),
      "hello"
    )
  )
})

