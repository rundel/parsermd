test_that("yaml parsing - good yaml", {
  parse = function(x) parse_yaml(check_yaml_parser(x))

  expect_equal(
    parse("---\n---\n"),
    rmd_yaml()
  )

  expect_equal( # Trailing spaces are ok
    parse("--- \n---\n"),
    rmd_yaml()
  )

  expect_equal(
    parse("---\n--- \n"),
    rmd_yaml()
  )

  expect_equal(
    parse("---\nvalue: 1\n---\n"),
    rmd_yaml(value=1)
  )

  expect_equal(
    parse("---\nvalue: 1\nname: bob\n---\n"),
    rmd_yaml(value= 1, name= "bob")
  )

  expect_equal(
    parse("---\nvalue: \"---\"\n---\n"),
    rmd_yaml(value = "---")
  )

  yaml = '---
title: "Title"
author:
- John Doe
- Jane Doe
---\n'

  expect_equal(
    parse(yaml),
    rmd_yaml( title = "Title", author = c("John Doe", "Jane Doe") )
  )
})

test_that("yaml parsing - bad yaml", {
  expect_snapshot(check_yaml_parser("--\n---\n"), error=TRUE)
  expect_snapshot(check_yaml_parser("---\n--\n"), error=TRUE)
  expect_snapshot(check_yaml_parser("----\n---\n"), error=TRUE)
  expect_snapshot(check_yaml_parser("---\n----\n"), error=TRUE)
  expect_snapshot(check_yaml_parser("---\n"), error=TRUE)
})

test_that("yaml parsing - blank lines", {
  parse = function(x) parse_yaml(check_yaml_parser(x))

  expect_equal(
    parse("---\nvalue: 1\n\n---\n"),
    rmd_yaml(value=1)
  )

  expect_equal(
    parse("---\nvalue1: 1\n\nvalue2: 2\n---\n"),
    rmd_yaml(value1=1, value2=2)
  )

  expect_snapshot(
    parse("---\n\n---\n"),
    error=TRUE
  )

  expect_snapshot(
    parse("---\n\nvalue: 1\n---\n"),
    error=TRUE
  )
})

test_that("GitHub #25 - Unicode + YAML", {

  # Failed w/ the following case:
  # docker run -it --rm rocker/r-devel bash
  # apt update
  # apt install -y locales-all
  # LANG=en_US.iso88591 LC_ALL=en_US.iso88591 R
  # install.packages("parsermd")

  rmd = "---\nauthor: \"Sébastien Rochette\"\n---\n"

  expect_s3_class(parse_rmd(rmd), "rmd_ast")
})

test_that("Pandoc - yaml metadata block", { # See https://pandoc.org/MANUAL.html#extension-yaml_metadata_block
  parse = function(x) parse_yaml(check_yaml_parser(x))

  expect_equal(
    parse("---\n...\n"),
    rmd_yaml()
  )

  expect_equal(
    parse("---\nvalue: 1\n...\n"),
    rmd_yaml(value=1)
  )

  expect_equal(
    parse_rmd("---\n---\n---\n...\n"),
    rmd_ast(
      rmd_yaml(),
      rmd_yaml()
    )
  )

  expect_equal(
    parse_rmd("---\nvalue: 1\n---\n---\nvalue: 2\n...\n"),
    rmd_ast(
      rmd_yaml(value=1),
      rmd_yaml(value=2)
    )
  )

  expect_equal(
    parse_rmd("---\n\n...\n"),
    rmd_ast(
      rmd_markdown("---","","...")
    )
  )

  expect_equal(
    parse_rmd("---\n\n---\n---\n...\n"),
    rmd_ast(
      rmd_markdown("---",""),
      rmd_yaml(),
      rmd_markdown("...")
    )
  )

  expect_equal(
    parse_rmd("---\n---\n---\n\n...\n"),
    rmd_ast(
      rmd_yaml(),
      rmd_markdown("---","","...")
    )
  )
})
