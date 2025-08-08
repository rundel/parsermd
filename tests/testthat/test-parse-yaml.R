test_that("yaml parsing - good yaml", {

  expect_equal(
    check_yaml_parser("---\n---\n"),
    rmd_yaml()
  )

  expect_equal( # Trailing spaces are ok
    check_yaml_parser("--- \n---\n"),
    rmd_yaml()
  )

  expect_equal(
    check_yaml_parser("---\n--- \n"),
    rmd_yaml()
  )

  expect_equal(
    check_yaml_parser("---\nvalue: 1\n---\n"),
    rmd_yaml( list(value=1) )
  )

  expect_equal(
    check_yaml_parser("---\nvalue: 1\nname: bob\n---\n"),
    rmd_yaml( list(value= 1, name= "bob") )
  )

  expect_equal(
    check_yaml_parser("---\nvalue: \"---\"\n---\n"),
    rmd_yaml( list(value = "---") )
  )

  yaml = '---
title: "Title"
author:
- John Doe
- Jane Doe
---\n'

  expect_equal(
    check_yaml_parser(yaml),
    rmd_yaml( list(title = "Title", author = c("John Doe", "Jane Doe")) )
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

  expect_equal(
    check_yaml_parser("---\nvalue: 1\n\n---\n"),
    rmd_yaml( list(value=1) )
  )

  expect_equal(
    check_yaml_parser("---\nvalue1: 1\n\nvalue2: 2\n---\n"),
    rmd_yaml( list(value1=1, value2=2) )
  )

  expect_snapshot(
    check_yaml_parser("---\n\n---\n"),
    error=TRUE
  )

  expect_snapshot(
    check_yaml_parser("---\n\nvalue: 1\n---\n"),
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

  expect_equal(
    check_yaml_parser("---\n...\n"),
    rmd_yaml()
  )

  expect_equal(
    check_yaml_parser("---\nvalue: 1\n...\n"),
    rmd_yaml( list(value=1) )
  )

  expect_equal(
    parse_rmd("---\n---\n---\n...\n"),
    rmd_ast( list(
      rmd_yaml(),
      rmd_yaml()
    ) )
  )

  expect_equal(
    parse_rmd("---\nvalue: 1\n---\n---\nvalue: 2\n...\n"),
    rmd_ast( list(
      rmd_yaml( list(value=1) ),
      rmd_yaml( list(value=2) )
    ) )
  )

  expect_equal(
    parse_rmd("---\n\n...\n"),
    rmd_ast( list(
      rmd_markdown(c("---", "", "..."))
    ) )
  )

  expect_equal(
    parse_rmd("---\n\n---\n---\n...\n"),
    rmd_ast( list(
      rmd_markdown("---"),
      rmd_yaml(),
      rmd_markdown("...")
    ) )
  )

  expect_equal(
    parse_rmd("---\n---\n---\n\n...\n"),
    rmd_ast( list(
      rmd_yaml(),
      rmd_markdown(c("---", "", "..."))
    ) )
  )
})
