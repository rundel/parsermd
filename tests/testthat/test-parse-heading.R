test_that("headings - basics", {
  expect_equal(
    check_heading_parser("# hello\n"),
    create_heading("hello", 1L)
  )

  expect_equal(
    check_heading_parser("## hello\n"),
    create_heading("hello", 2L)
  )

  expect_equal(
    check_heading_parser("### hello\n"),
    create_heading("hello", 3L)
  )

  expect_equal(
    check_heading_parser("#### hello\n"),
    create_heading("hello", 4L)
  )

  expect_equal(
    check_heading_parser("##### hello\n"),
    create_heading("hello", 5L)
  )

  expect_equal(
    check_heading_parser("###### hello\n"),
    create_heading("hello", 6L)
  )

  expect_error(check_heading_parser(" hello\n"))
  expect_error(check_heading_parser("####### hello\n"))
})


test_that("headings - trailing ws", {
  expect_equal(
    check_heading_parser("# \n"),
    create_heading("", 1L)
  )

  expect_equal(
    check_heading_parser("# hello \n"),
    create_heading("hello", 1L)
  )

  expect_equal(
    check_heading_parser("# hello  \n"),
    create_heading("hello", 1L)
  )
})

test_that("headings - blank", {
  expect_equal(
    check_heading_parser("# \n"),
    create_heading("", 1L)
  )

  expect_equal(
    check_heading_parser("###### \n"),
    create_heading("", 6L)
  )

  expect_equal(
    check_heading_parser("#\n"),
    create_heading("", 1L)
  )

  expect_equal(
    check_heading_parser("######\n"),
    create_heading("", 6L)
  )
})

test_that("headings - clases", {
  expect_equal(
    check_heading_parser("# hello {}\n"),
    create_heading("hello", 1L)
  )

  expect_equal(
    check_heading_parser("# hello {.class1}\n"),
    create_heading("hello", 1L, ".class1")
  )

  expect_equal(
    check_heading_parser("# hello {.class1 .class2}\n"),
    create_heading("hello", 1L, c(".class1", ".class2"))
  )

  expect_equal(
    check_heading_parser("# hello {.class1 .class2 .class3}\n"),
    create_heading("hello", 1L, c(".class1", ".class2", ".class3"))
  )

  expect_equal(
    check_heading_parser("# hello {.hello-bye .bye_hello}\n"),
    create_heading("hello", 1L, c(".hello-bye", ".bye_hello"))
  )
})

test_that("headings - bad classes", {
  expect_error(check_heading_parser("# hello {class1}\n"))

  expect_error(check_heading_parser("# hello {.1}\n"))

  expect_error(check_heading_parser("# hello {.-1}\n"))

  expect_error(check_heading_parser("# hello {.--}\n"))
})
