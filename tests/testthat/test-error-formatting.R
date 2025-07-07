test_that("Single-line parser errors are formatted correctly", {
  expect_snapshot_error(
    check_qstring_parser("unterminated")
  )
  
  expect_snapshot_error(
    check_chunk_parser("```{r abc.def}")
  )
  
  expect_snapshot_error(
    check_qstring_parser("'unterminated quote")
  )
})

test_that("Error messages with expected information", {
  expect_snapshot_error(
    check_chunk_parser("```{r x=}")
  )
})

test_that("Multiline expression", {
  expect_snapshot_error(
    parse_rmd(
  ':::{.content-visible when-format="HTML}
::::{.column-screen}
Hello
::::
:::'
)
  )
})

test_that("Line number padding works correctly", {

  doc_with_many_lines = paste(
    "line 1",
    "line 2", 
    "line 3",
    "line 4",
    "line 5",
    "line 6",
    "line 7",
    "line 8",
    "line 9",
    "```{r invalid.syntax}",
    sep = "\n"
  )
  
  expect_snapshot_error(
    parse_rmd(doc_with_many_lines)
  )
})