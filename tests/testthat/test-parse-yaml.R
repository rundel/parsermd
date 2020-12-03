as_yaml = function(...) {
  structure(
    c(...), class = "rmd_yaml"
  )
}

test_that("yaml parsing - good yaml", {
  expect_equal(
    parsermd:::check_yaml_parser("---\n---\n"),
    as_yaml(character())
  )

  expect_equal(
    parsermd:::check_yaml_parser("---\nvalue: 1\n---\n"),
    as_yaml("value: 1")
  )

  expect_equal(
    parsermd:::check_yaml_parser("---\nvalue: 1\nname: bob\n---\n"),
    as_yaml("value: 1", "name: bob")
  )

  expect_equal(
    parsermd:::check_yaml_parser("---\nvalue: \"---\"\n---\n"),
    as_yaml("value: \"---\"")
  )
})

test_that("yaml parsing - authors", {

  yaml = '---
title: "Title"
author:
- John Doe
- Jane Doe
---\n'

  yaml_res = strsplit(yaml, "\n")[[1]]
  yaml_res = as_yaml( yaml_res[-c(1, length(yaml_res))] )

  expect_equal(parsermd:::check_yaml_parser(yaml), yaml_res)
})

test_that("yaml parsing - bad yaml", {
  expect_error(parsermd:::check_yaml_parser("--\n---\n"))
  expect_error(parsermd:::check_yaml_parser("---\n--\n"))
  expect_error(parsermd:::check_yaml_parser("----\n---\n"))
  expect_error(parsermd:::check_yaml_parser("---\n----\n"))
  expect_error(parsermd:::check_yaml_parser("---\n"))

  expect_snapshot_error(parsermd:::check_yaml_parser("--\n---\n"))
  expect_snapshot_error(parsermd:::check_yaml_parser("---\n--\n"))
  expect_snapshot_error(parsermd:::check_yaml_parser("----\n---\n"))
  expect_snapshot_error(parsermd:::check_yaml_parser("---\n----\n"))
  expect_snapshot_error(parsermd:::check_yaml_parser("---\n"))
})

