test_that("yaml parsing - good yaml", {

  expect_equal(parsermd:::check_yaml_parser("---\n---\n"),
               character())
  expect_equal(parsermd:::check_yaml_parser("---\nvalue: 1\n---\n"),
               "value: 1")
  expect_equal(parsermd:::check_yaml_parser("---\nvalue: 1\nname: bob\n---\n"),
               c("value: 1", "name: bob"))

  expect_equal(parsermd:::check_yaml_parser("---\nvalue: \"---\"\n---\n"),
               c("value: \"---\""))
})

test_that("yaml parsing - bad yaml", {
  expect_error(parsermd:::check_yaml_parser("--\n---\n"))
  expect_error(parsermd:::check_yaml_parser("---\n--\n"))
  expect_error(parsermd:::check_yaml_parser("----\n---\n"))
  expect_error(parsermd:::check_yaml_parser("---\n----\n"))
  expect_error(parsermd:::check_yaml_parser("---\n"))
})
