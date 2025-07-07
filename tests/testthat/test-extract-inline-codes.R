test_that("Inline code detection in text content", {
  

  expect_true(rmd_has_inline_code("Hello `r mean(x)` world"))
  expect_false(rmd_has_inline_code("Hello world"))
  

  expect_true(rmd_has_inline_code("`r x` and `python y`"))
  

  expect_true(rmd_has_inline_code("`{r} mean(x)`"))
  expect_true(rmd_has_inline_code("`{python} print('hello')`"))
  

  expect_true(rmd_has_inline_code("`r mean(x)`", "r"))
  expect_false(rmd_has_inline_code("`python print('hello')`", "r"))
  

  expect_true(rmd_has_inline_code("`python print('hello')`", "python*"))
  expect_false(rmd_has_inline_code("`r mean(x)`", "python*"))
})

test_that("Inline code detection in AST nodes", {

  rmd1 = parse_rmd(c("Hello `r mean(x)` world"))
  expect_equal(rmd_select(rmd1, has_inline_code()), rmd1[1])
  expect_equal(rmd_select(rmd1, has_inline_code("r")), rmd1[1])
  expect_equal(rmd_select(rmd1, has_inline_code("python")), rmd_ast(list()))
  

  rmd2 = parse_rmd(c("```{r}", "# Comment with `r inline_code`", "x = 1", "```"))
  expect_equal(rmd_select(rmd2, has_inline_code()), rmd_ast(list()))
  expect_equal(rmd_select(rmd2, has_inline_code("r")), rmd_ast(list()))
  expect_equal(rmd_select(rmd2, has_inline_code("python")), rmd_ast(list()))
  

  rmd3 = parse_rmd(c("Hello world", "```{r}", "print('hello')", "```"))
  expect_equal(rmd_select(rmd3, has_inline_code()), rmd_ast(list()))
})

test_that("rmd_has_inline_code() with different rmd classes", {
  

  rmd_ast_with_inline = parse_rmd(c("# Title", "Text with `r mean(x)` inline code"))
  rmd_ast_without_inline = parse_rmd(c("# Title", "Just normal text"))
  
  expect_true(any(rmd_has_inline_code(rmd_ast_with_inline)))
  expect_false(any(rmd_has_inline_code(rmd_ast_without_inline)))
  expect_true(any(rmd_has_inline_code(rmd_ast_with_inline, "r")))
  expect_false(any(rmd_has_inline_code(rmd_ast_with_inline, "python")))
  

  rmd_markdown_with_inline = parse_rmd("Text with `r sqrt(4)` inline code")[[1]]
  rmd_markdown_without_inline = parse_rmd("Just normal text")[[1]]
  
  expect_true(rmd_has_inline_code(rmd_markdown_with_inline))
  expect_false(rmd_has_inline_code(rmd_markdown_without_inline))
  expect_true(rmd_has_inline_code(rmd_markdown_with_inline, "r"))
  expect_false(rmd_has_inline_code(rmd_markdown_with_inline, "python"))
  

  rmd_chunk_with_inline = parse_rmd(c("```{r}", "# Comment with `r length(x)`", "x = 1", "```"))[[1]]
  rmd_chunk_without_inline = parse_rmd(c("```{r}", "x = 1", "```"))[[1]]
  
  expect_false(rmd_has_inline_code(rmd_chunk_with_inline))
  expect_false(rmd_has_inline_code(rmd_chunk_without_inline))
  expect_false(rmd_has_inline_code(rmd_chunk_with_inline, "r"))
  expect_false(rmd_has_inline_code(rmd_chunk_with_inline, "python"))
  

  rmd_yaml_with_inline = parse_rmd(c("---", "title: \"Document with `r version`\"", "---"))[[1]]
  rmd_yaml_without_inline = parse_rmd(c("---", "title: My Document", "---"))[[1]]
  
  expect_true(rmd_has_inline_code(rmd_yaml_with_inline))
  expect_false(rmd_has_inline_code(rmd_yaml_without_inline))
  expect_true(rmd_has_inline_code(rmd_yaml_with_inline, "r"))
  expect_false(rmd_has_inline_code(rmd_yaml_with_inline, "python"))
  

  rmd_heading_obj = parse_rmd("# My Title")[[1]]
  expect_false(rmd_has_inline_code(rmd_heading_obj))
  expect_false(rmd_has_inline_code(rmd_heading_obj, "r"))
  

  rmd_tibble_with_inline = as_tibble(parse_rmd("Text with `r mean(x)` inline code"))
  rmd_tibble_without_inline = as_tibble(parse_rmd("Just normal text"))
  
  expect_true(any(rmd_has_inline_code(rmd_tibble_with_inline)))
  expect_false(any(rmd_has_inline_code(rmd_tibble_without_inline)))
  expect_true(any(rmd_has_inline_code(rmd_tibble_with_inline, "r")))
  expect_false(any(rmd_has_inline_code(rmd_tibble_with_inline, "python")))
})

test_that("has_inline_code() selection helper with different rmd classes", {
  

  test_rmd = parse_rmd(c(
    "---",
    "title: \"Document with `r version` inline\"",
    "---",
    "",
    "# Section 1",
    "",
    "Text with `r mean(data)` inline code.",
    "",
    "```{r chunk1}",
    "# Code with `r length(x)` inline code",
    "x = 1",
    "```",
    "",
    "## Subsection", 
    "",
    "Normal text without inline codes.",
    "",
    "```{r chunk2}",
    "y = 2",
    "```",
    "",
    "Final text with `python print('hello')` and `{sql} SELECT * FROM table`."
  ))
  

  inline_nodes = rmd_select(test_rmd, has_inline_code())
  expect_equal(inline_nodes, test_rmd[c(1,3,8)])
  

  r_nodes = rmd_select(test_rmd, has_inline_code("r"))
  expect_equal(r_nodes, test_rmd[c(1,3)])
  expect_true(all(rmd_has_inline_code(r_nodes, engine = "r")))
  
  python_nodes = rmd_select(test_rmd, has_inline_code("python"), keep_yaml = FALSE)
  expect_equal(python_nodes, test_rmd[8])
  expect_true(rmd_has_inline_code(python_nodes, "python"))
  
  sql_nodes = rmd_select(test_rmd, has_inline_code("sql"), keep_yaml = FALSE)
  expect_equal(sql_nodes, test_rmd[8])
  expect_true(rmd_has_inline_code(sql_nodes, "sql"))
  


  nonexistent_nodes = rmd_select(test_rmd, has_inline_code("nonexistent"), keep_yaml = FALSE)
  expect_equal(nonexistent_nodes, rmd_ast(list()))
  

  multi_nodes = rmd_select(test_rmd, has_inline_code(c("python", "sql")), keep_yaml = FALSE)
  expect_equal(multi_nodes, test_rmd[8])
  

  chunk_with_inline = rmd_select(test_rmd, has_type("rmd_yaml") & has_inline_code())
  expect_equal(chunk_with_inline, test_rmd[c(1)])

  markdown_with_inline = rmd_select(test_rmd, has_type("rmd_markdown") & has_inline_code(), keep_yaml = FALSE)
  expect_equal(markdown_with_inline, test_rmd[c(3,8)])
})

test_that("has_inline_code() with edge cases", {
  

  no_inline_rmd = parse_rmd(c("# Title", "Just normal text", "```{r}", "x = 1", "```"))
  expect_equal(
    rmd_select(no_inline_rmd, has_inline_code()), 
    rmd_ast(list())
  )
  expect_equal(
    rmd_select(no_inline_rmd, has_inline_code("r")), 
    rmd_ast(list())
  )
  

  headings_only_rmd = parse_rmd(c("# Title 1", "## Subtitle", "### Subsubtitle"))
  expect_equal(
    rmd_select(headings_only_rmd, has_inline_code()), 
    rmd_ast(list())
  )
  

  complex_rmd = parse_rmd(c(
    "Start `r x` text",
    "Middle text `python y` more text", 
    "End text `{sql} SELECT z`"
  ))
  expect_equal(
    rmd_select(complex_rmd, has_inline_code()),
    complex_rmd[1]
  )
  expect_equal(
    rmd_select(complex_rmd, has_inline_code("r")), 
    complex_rmd[1]
  )
  expect_equal(
    rmd_select(complex_rmd, has_inline_code("python")),
    complex_rmd[1]
  )
  expect_equal(
    rmd_select(complex_rmd, has_inline_code("sql")),
    complex_rmd[1]
  )
})

test_that("Inline code extraction functionality", {
  

  expect_equal(
    rmd_extract_inline_code("Hello `r mean(x)` world", flatten = TRUE),
    list(rmd_inline_code("r", "mean(x)", FALSE, 6L, 11L))
  )
  

  expect_equal(
    rmd_extract_inline_code("`r x` and `python y`", flatten = TRUE),
    list(
      rmd_inline_code("r", "x", FALSE, 0L, 5L),
      rmd_inline_code("python", "y", FALSE, 10L, 10L)
    )
  )
  

  expect_equal(rmd_extract_inline_code("Hello world", flatten = TRUE), list())
  

  expect_equal(
    rmd_extract_inline_code(c("Text with `r mean(x)`", "Another `python y` text"), flatten = FALSE),
    list(
      list(rmd_inline_code("r", "mean(x)", FALSE, 10L, 11L)),
      list(rmd_inline_code("python", "y", FALSE, 8L, 10L))
    )
  )
  

  expect_equal(
    rmd_extract_inline_code(c("Text with `r mean(x)`", "Another `python y` text"), flatten = TRUE),
    list(
      rmd_inline_code("r", "mean(x)", FALSE, 10L, 11L),
      rmd_inline_code("python", "y", FALSE, 8L, 10L)
    )
  )
  

  expect_equal(rmd_extract_inline_code("No inline codes here", flatten = TRUE), list())
  

  expect_equal(
    rmd_extract_inline_code("Hello `r mean(x)` world", flatten = FALSE),
    list(list(rmd_inline_code("r", "mean(x)", FALSE, 6L, 11L)))
  )
  
  expect_equal(
    rmd_extract_inline_code("`r x` and `python y`", flatten = FALSE),
    list(list(
      rmd_inline_code("r", "x", FALSE, 0L, 5L),
      rmd_inline_code("python", "y", FALSE, 10L, 10L)
    ))
  )
  
  expect_equal(rmd_extract_inline_code("Hello world", flatten = FALSE), list(list()))
  

  expect_equal(
    rmd_extract_inline_code("`{r} mean(x)`", flatten = TRUE),
    list(rmd_inline_code("r", "mean(x)", TRUE, 0L, 13L))
  )
  

  expect_true(rmd_has_inline_code("`r paste('hello', 'world')`"))
  expect_true(rmd_has_inline_code("`{python} print('test')`"))
})
