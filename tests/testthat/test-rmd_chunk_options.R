test_that("rmd_get_options normalizes dash option names", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.width = 8, fig.height = 6, out.width = "100%"),
    code = "plot(cars)"
  )
  
  # Test getting options using dash notation
  result_dash = rmd_get_options(chunk, "fig-width", "out-width")
  result_dot = rmd_get_options(chunk, "fig.width", "out.width")
  
  # Expected results
  expected_dash = list(`fig-width` = 8, `out-width` = "100%")
  expected_dot = list(fig.width = 8, out.width = "100%")
  
  expect_equal(result_dash, expected_dash)
  expect_equal(result_dot, expected_dot)
})

test_that("rmd_set_options normalizes dash option names", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    code = "plot(cars)"
  )
  
  # Set options using dash notation
  result = rmd_set_options(chunk, `fig-width` = 10, `out-height` = "75%")
  
  # Expected chunk with normalized option names
  expected_chunk1 = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.width = 10, out.height = "75%"),
    code = "plot(cars)"
  )

  expected_chunk2 = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(`fig-width` = 10, `out-height` = "75%"),
    code = "plot(cars)"
  )

  
  expect_equal(result, expected_chunk1)
  expect_equal(result, expected_chunk2)
})

test_that("rmd_set_options and rmd_get_options work together with normalization", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test", 
    code = "plot(cars)"
  )
  
  # Set options using dash notation
  updated_chunk = rmd_set_options(chunk, `fig-width` = 8, `fig-height` = 6)
  
  # Get options using both notations
  dash_result = rmd_get_options(updated_chunk, "fig-width", "fig-height")
  dot_result = rmd_get_options(updated_chunk, "fig.width", "fig.height")
  
  # Expected results
  expected_dash = list(`fig-width` = 8, `fig-height` = 6)
  expected_dot = list(fig.width = 8, fig.height = 6)
  
  expect_equal(dash_result, expected_dash)
  expect_equal(dot_result, expected_dot)
})

test_that("rmd_get_options works with defaults and normalization", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.width = 8),
    code = "plot(cars)"
  )
  
  defaults = list(fig.height = 6, out.width = "100%")
  
  # Get options using dash notation with defaults
  result = rmd_get_options(chunk, "fig-width", "fig-height", "out-width", defaults = defaults)
  
  # Expected result with defaults applied
  expected_result = list(
    `fig-width` = 8,        # from chunk
    `fig-height` = 6,       # from defaults
    `out-width` = "100%"     # from defaults
  )
  
  expect_equal(result, expected_result)
})

test_that("normalization preserves complex option names", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    code = "plot(cars)"
  )
  
  # Set options with multiple dashes/dots
  updated_chunk = rmd_set_options(chunk, 
    `fig-cap-location` = "bottom",
    `out-extra-css` = "color: red"
  )
  
  # Expected chunk with normalized option names
  expected_chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red"),
    code = "plot(cars)"
  )
  
  expect_equal(updated_chunk, expected_chunk)
  
  # Test retrieval with both notations
  dash_result = rmd_get_options(updated_chunk, "fig-cap-location", "out-extra-css")
  dot_result = rmd_get_options(updated_chunk, "fig.cap.location", "out.extra.css")
  
  expected_dash = list(`fig-cap-location` = "bottom", `out-extra-css` = "color: red")
  expected_dot = list(fig.cap.location = "bottom", out.extra.css = "color: red")
  
  expect_equal(dash_result, expected_dash)
  expect_equal(dot_result, expected_dot)
})

test_that("rmd_set_options works with rmd_ast objects", {
  # Create a minimal AST with multiple chunks
  chunk1 = rmd_chunk("r", "chunk1", code = "x = 1")
  chunk2 = rmd_chunk("python", "chunk2", code = "y = 2")  
  markdown1 = rmd_markdown(lines = "Some text")
  
  ast = rmd_ast(nodes = list(chunk1, markdown1, chunk2))
  
  # Set options on all chunks
  result = rmd_set_options(ast, include = FALSE, echo = TRUE)
  
  # Check that only chunks were modified
  expect_equal(result@nodes[[1]]@options$include, FALSE)
  expect_equal(result@nodes[[1]]@options$echo, TRUE)
  expect_equal(result@nodes[[3]]@options$include, FALSE) 
  expect_equal(result@nodes[[3]]@options$echo, TRUE)
  
  # Markdown node should be unchanged
  expect_equal(result@nodes[[2]], markdown1)
})

test_that("rmd_get_options works with rmd_ast objects", {
  # Create chunks with different options
  chunk1 = rmd_chunk("r", "chunk1", options = list(include = TRUE, echo = FALSE), code = "x = 1")
  chunk2 = rmd_chunk("python", "chunk2", options = list(include = FALSE, eval = TRUE), code = "y = 2")
  markdown1 = rmd_markdown(lines = "Some text")
  
  ast = rmd_ast(nodes = list(chunk1, markdown1, chunk2))
  
  # Get all options
  result = rmd_get_options(ast)
  
  expect_equal(length(result), 3)
  expect_equal(result[[1]], list(include = TRUE, echo = FALSE))
  expect_null(result[[2]]) # markdown node returns NULL
  expect_equal(result[[3]], list(include = FALSE, eval = TRUE))
  
  # Get specific options
  specific_result = rmd_get_options(ast, "include", "echo")
  expect_equal(specific_result[[1]], list(include = TRUE, echo = FALSE))
  expect_null(specific_result[[2]])
  expect_equal(specific_result[[3]], list(include = FALSE, echo = NULL)) # echo not set, should be NULL
})

test_that("rmd_set_options works with rmd_tibble objects", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(rmd)
  
  # Set options on tibble
  result = rmd_set_options(tbl, include = TRUE, echo = FALSE)
  
  # Check that the result is still a tibble and options were set
  expect_s3_class(result, "rmd_tibble")
  
  # Convert back to verify changes
  result_ast = as_ast(result)
  chunk_rows = result$type == "rmd_chunk"
  
  # All chunk nodes should have the new options
  if (any(chunk_rows)) {
    chunk_nodes = result_ast@nodes[sapply(result_ast@nodes, function(x) inherits(x, "rmd_chunk"))]
    for (chunk in chunk_nodes) {
      expect_equal(chunk@options$include, TRUE)
      expect_equal(chunk@options$echo, FALSE)  
    }
  }
})

test_that("rmd_get_options works with rmd_tibble objects", {
  rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
  tbl = as_tibble(rmd)
  
  # Get options from tibble
  result = rmd_get_options(tbl)
  
  # Should return same as getting from AST
  ast_result = rmd_get_options(rmd)
  expect_equal(result, ast_result)
})

test_that("rmd_set_options handles unnamed options error", {
  chunk = rmd_chunk("r", "test", code = "x = 1")
  
  expect_snapshot_error(rmd_set_options(chunk, TRUE, FALSE))
  expect_snapshot_error(rmd_set_options(chunk, include = TRUE, FALSE))
})

test_that("rmd_set_options preserves existing options while adding new ones", {
  chunk = rmd_chunk("r", "test", options = list(include = TRUE, echo = FALSE), code = "x = 1")
  
  # Add new options without overwriting existing
  result = rmd_set_options(chunk, eval = FALSE, warning = TRUE)
  
  expected_options = list(include = TRUE, echo = FALSE, eval = FALSE, warning = TRUE)
  expect_equal(result@options, expected_options)
  
  # Overwrite existing option
  result2 = rmd_set_options(result, include = FALSE)
  expected_options2 = list(include = FALSE, echo = FALSE, eval = FALSE, warning = TRUE)
  expect_equal(result2@options, expected_options2)
})

test_that("rmd_get_options returns NULL for non-chunk nodes", {
  markdown = rmd_markdown(lines = "Some text")
  yaml = rmd_yaml(yaml = list("title: Test"))
  heading = rmd_heading(name = "Title", level = 1L)
  
  expect_null(rmd_get_options(markdown))
  expect_null(rmd_get_options(yaml))
  expect_null(rmd_get_options(heading))
})

test_that("rmd_set_options returns unchanged for non-chunk nodes", {
  markdown = rmd_markdown(lines = "Some text")
  yaml = rmd_yaml(yaml = list("title: Test"))
  heading = rmd_heading(name = "Title", level = 1L)
  
  expect_equal(rmd_set_options(markdown, include = FALSE), markdown)
  expect_equal(rmd_set_options(yaml, echo = TRUE), yaml)
  expect_equal(rmd_set_options(heading, eval = FALSE), heading)
})

test_that("rmd_get_options with defaults works correctly", {
  chunk = rmd_chunk("r", "test", options = list(include = TRUE), code = "x = 1")
  
  defaults = list(echo = FALSE, eval = TRUE, warning = FALSE)
  
  # Get existing option - should not use default
  result1 = rmd_get_options(chunk, "include", defaults = defaults)
  expect_equal(result1, list(include = TRUE))
  
  # Get non-existing option - should use default
  result2 = rmd_get_options(chunk, "echo", defaults = defaults) 
  expect_equal(result2, list(echo = FALSE))
  
  # Get mix of existing and non-existing
  result3 = rmd_get_options(chunk, "include", "echo", "eval", defaults = defaults)
  expect_equal(result3, list(include = TRUE, echo = FALSE, eval = TRUE))
})

test_that("option normalization works bidirectionally", {
  chunk = rmd_chunk("r", "test", code = "x = 1")
  
  # Set with dashes, get with dots
  chunk_dash = rmd_set_options(chunk, `fig-width` = 8, `fig-height` = 6)
  dot_result = rmd_get_options(chunk_dash, "fig.width", "fig.height")
  expect_equal(dot_result, list(fig.width = 8, fig.height = 6))
  
  # Set with dots, get with dashes
  chunk_dot = rmd_set_options(chunk, fig.width = 10, fig.height = 8)
  dash_result = rmd_get_options(chunk_dot, "fig-width", "fig-height")
  expect_equal(dash_result, list(`fig-width` = 10, `fig-height` = 8))
})

test_that("rmd_get_options yaml_style parameter works correctly", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.width = 8, fig.height = 6, out.width = "100%", eval = TRUE),
    code = "plot(cars)"
  )
  
  # Test getting all options with yaml_style = TRUE (default)
  yaml_all = rmd_get_options(chunk, yaml_style = TRUE)
  expected_yaml_all = list(`fig-width` = 8, `fig-height` = 6, `out-width` = "100%", eval = TRUE)
  expect_equal(yaml_all, expected_yaml_all)
  
  # Test getting all options with yaml_style = FALSE
  norm_all = rmd_get_options(chunk, yaml_style = FALSE)
  expected_norm_all = list(fig.width = 8, fig.height = 6, out.width = "100%", eval = TRUE)
  expect_equal(norm_all, expected_norm_all)
  
  # Test getting specific options with yaml_style = TRUE (dash input, dash output)
  yaml_specific = rmd_get_options(chunk, "fig-width", "out-width", yaml_style = TRUE)
  expected_yaml_specific = list(`fig-width` = 8, `out-width` = "100%")
  expect_equal(yaml_specific, expected_yaml_specific)
  
  # Test getting specific options with yaml_style = FALSE (dash input, dot output)
  norm_specific = rmd_get_options(chunk, "fig-width", "out-width", yaml_style = FALSE)
  expected_norm_specific = list(fig.width = 8, out.width = "100%")
  expect_equal(norm_specific, expected_norm_specific)
  
  # Test getting specific options with dot input and yaml_style = TRUE
  yaml_dot_input = rmd_get_options(chunk, "fig.width", "out.width", yaml_style = TRUE)
  expected_yaml_dot = list(fig.width = 8, out.width = "100%")  # Keep original input names
  expect_equal(yaml_dot_input, expected_yaml_dot)
  
  # Test getting specific options with dot input and yaml_style = FALSE
  norm_dot_input = rmd_get_options(chunk, "fig.width", "out.width", yaml_style = FALSE)
  expected_norm_dot = list(fig.width = 8, out.width = "100%")
  expect_equal(norm_dot_input, expected_norm_dot)
})

test_that("rmd_get_options yaml_style works with defaults", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.width = 8),
    code = "plot(cars)"
  )
  
  defaults = list(fig.height = 6, out.width = "100%")
  
  # Test with yaml_style = TRUE (default)
  yaml_result = rmd_get_options(chunk, "fig-width", "fig-height", "out-width", 
                               defaults = defaults, yaml_style = TRUE)
  expected_yaml = list(`fig-width` = 8, `fig-height` = 6, `out-width` = "100%")
  expect_equal(yaml_result, expected_yaml)
  
  # Test with yaml_style = FALSE
  norm_result = rmd_get_options(chunk, "fig-width", "fig-height", "out-width", 
                               defaults = defaults, yaml_style = FALSE)
  expected_norm = list(fig.width = 8, fig.height = 6, out.width = "100%")
  expect_equal(norm_result, expected_norm)
})

test_that("rmd_get_options yaml_style works with AST and tibble objects", {
  chunk1 = rmd_chunk("r", "chunk1", options = list(fig.width = 8, eval = TRUE), code = "x = 1")
  chunk2 = rmd_chunk("python", "chunk2", options = list(fig.height = 6), code = "y = 2")
  markdown1 = rmd_markdown(lines = "Some text")
  
  ast = rmd_ast(nodes = list(chunk1, markdown1, chunk2))
  
  # Test AST with yaml_style = TRUE
  yaml_result = rmd_get_options(ast, yaml_style = TRUE)
  expected_yaml = list(
    list(`fig-width` = 8, eval = TRUE),
    NULL,
    list(`fig-height` = 6)
  )
  expect_equal(yaml_result, expected_yaml)
  
  # Test AST with yaml_style = FALSE  
  norm_result = rmd_get_options(ast, yaml_style = FALSE)
  expected_norm = list(
    list(fig.width = 8, eval = TRUE),
    NULL,
    list(fig.height = 6)
  )
  expect_equal(norm_result, expected_norm)
  
  # Test with tibble
  tbl = as_tibble(ast)
  yaml_tbl_result = rmd_get_options(tbl, yaml_style = TRUE)
  norm_tbl_result = rmd_get_options(tbl, yaml_style = FALSE)
  
  expect_equal(yaml_tbl_result, yaml_result)
  expect_equal(norm_tbl_result, norm_result)
})

test_that("rmd_get_options yaml_style works with complex option names", {
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red", eval = TRUE),
    code = "plot(cars)"
  )
  
  # Test all options with yaml_style = TRUE
  yaml_all = rmd_get_options(chunk, yaml_style = TRUE)
  expected_yaml_all = list(`fig-cap-location` = "bottom", `out-extra-css` = "color: red", eval = TRUE)
  expect_equal(yaml_all, expected_yaml_all)
  
  # Test all options with yaml_style = FALSE
  norm_all = rmd_get_options(chunk, yaml_style = FALSE)
  expected_norm_all = list(fig.cap.location = "bottom", out.extra.css = "color: red", eval = TRUE)
  expect_equal(norm_all, expected_norm_all)
  
  # Test specific options
  yaml_specific = rmd_get_options(chunk, "fig-cap-location", yaml_style = TRUE)
  norm_specific = rmd_get_options(chunk, "fig-cap-location", yaml_style = FALSE)
  
  expect_equal(yaml_specific, list(`fig-cap-location` = "bottom"))
  expect_equal(norm_specific, list(fig.cap.location = "bottom"))
})

test_that("rmd_chunk constructor normalizes option names automatically", {
  # Test that constructor normalizes hyphenated option names to dots
  chunk = rmd_chunk(
    engine = "r",
    label = "test",
    options = list(`fig-width` = 8, `fig-height` = 6, `out-width` = "100%"),
    code = "plot(cars)"
  )
  
  # Internal storage should use dots
  expect_equal(names(chunk@options), c("fig.width", "fig.height", "out.width"))
  expect_equal(chunk@options, list(fig.width = 8, fig.height = 6, out.width = "100%"))
  
  # But rmd_node_options should return YAML style by default
  yaml_options = rmd_node_options(chunk, yaml_style = TRUE)
  expect_equal(names(yaml_options), c("fig-width", "fig-height", "out-width"))
  
  # And normalized style when requested
  norm_options = rmd_node_options(chunk, yaml_style = FALSE)
  expect_equal(names(norm_options), c("fig.width", "fig.height", "out.width"))
})
