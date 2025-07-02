test_that("rmd_modify works with rmd_ast", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test basic modification of all nodes
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "test_attr") = "modified"
    x
  })
  
  expect_true(all(purrr::map_lgl(modified, ~attr(., "test_attr") == "modified")))
  expect_s3_class(modified, "rmd_ast")
  expect_equal(length(modified), length(rmd))
})

test_that("rmd_modify works with selection", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test modification of selected nodes only
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "chunk_modified") = TRUE
    x
  }, has_type("rmd_chunk"))
  
  # Check that only chunks were modified
  chunk_indices = which(rmd_node_type(rmd) == "rmd_chunk")
  non_chunk_indices = which(rmd_node_type(rmd) != "rmd_chunk")
  
  expect_true(all(purrr::map_lgl(modified[chunk_indices], ~attr(., "chunk_modified") %||% FALSE)))
  expect_true(all(purrr::map_lgl(modified[non_chunk_indices], ~is.null(attr(., "chunk_modified")))))
})

test_that("rmd_modify passes named arguments to function", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test passing named arguments
  modified = rmd_modify(rmd, .f = function(x, prefix) {
    attr(x, "prefix") = prefix
    x
  }, has_type("rmd_chunk"), prefix = "test_prefix")
  
  chunk_indices = which(rmd_node_type(rmd) == "rmd_chunk")
  expect_true(all(purrr::map_lgl(modified[chunk_indices], ~attr(., "prefix") == "test_prefix")))
})

test_that("rmd_modify works with multiple selection criteria", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test multiple selection arguments
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "multi_select") = TRUE
    x
  }, has_type("rmd_chunk"), has_type("rmd_heading"))
  
  target_types = c("rmd_chunk", "rmd_heading")
  target_indices = which(rmd_node_type(rmd) %in% target_types)
  non_target_indices = which(!rmd_node_type(rmd) %in% target_types)
  
  expect_true(all(purrr::map_lgl(modified[target_indices], ~attr(., "multi_select") %||% FALSE)))
  expect_true(all(purrr::map_lgl(modified[non_target_indices], ~is.null(attr(., "multi_select")))))
})

test_that("rmd_modify works with rmd_tibble", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  rmd_tbl = as_tibble(rmd)
  
  # Test modification of tibble
  modified_tbl = rmd_modify(rmd_tbl, .f = function(x) {
    attr(x, "tibble_modified") = TRUE
    x
  }, has_type("rmd_chunk"))
  
  expect_s3_class(modified_tbl, "rmd_tibble")
  expect_true("ast" %in% names(modified_tbl))
  
  # Check that modifications were applied to the AST within the tibble
  chunk_indices = which(rmd_node_type(modified_tbl$ast) == "rmd_chunk")
  expect_true(all(purrr::map_lgl(modified_tbl$ast[chunk_indices], ~attr(., "tibble_modified") %||% FALSE)))
})

test_that("rmd_modify handles empty selection", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test with selection that matches nothing
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "should_not_exist") = TRUE
    x
  }, has_type("nonexistent_type"))
  
  # No nodes should be modified
  expect_true(all(purrr::map_lgl(modified, ~is.null(attr(., "should_not_exist")))))
  expect_equal(modified, rmd)  # Should be unchanged
})

test_that("rmd_modify handles label-based selection", {
  rmd_text = c(
    "# Test",
    "",
    "```{r setup}",
    "1 + 1",
    "```",
    "",
    "Some text",
    "",
    "```{r analysis}",
    "2 + 2",
    "```"
  )
  
  rmd = parse_rmd(rmd_text)
  
  # Test selection by chunk label
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "setup_modified") = TRUE
    x
  }, "setup")
  
  setup_node = rmd_select(modified, "setup")[[1]]
  analysis_node = rmd_select(modified, "analysis")[[1]]
  
  expect_true(attr(setup_node, "setup_modified") %||% FALSE)
  expect_true(is.null(attr(analysis_node, "setup_modified")))
})

test_that("rmd_modify validates .f argument", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  expect_error(
    rmd_modify(rmd, .f = "not_a_function"),
    "Assertion on '.f' failed"
  )
  
  expect_error(
    rmd_modify(rmd, .f = 123),
    "Assertion on '.f' failed"
  )
})

test_that("rmd_modify works with range selection", {
  rmd_text = c(
    "# Test",
    "",
    "```{r chunk1}",
    "1 + 1",
    "```",
    "",
    "```{r chunk2}",
    "2 + 2",
    "```",
    "",
    "```{r chunk3}",
    "3 + 3",
    "```"
  )
  
  rmd = parse_rmd(rmd_text)
  
  # Test range selection
  modified = rmd_modify(rmd, .f = function(x) {
    attr(x, "range_modified") = TRUE
    x
  }, "chunk1":"chunk3")
  
  chunk1_node = rmd_select(modified, "chunk1")[[1]]
  chunk2_node = rmd_select(modified, "chunk2")[[1]]
  chunk3_node = rmd_select(modified, "chunk3")[[1]]
  
  expect_true(attr(chunk1_node, "range_modified") %||% FALSE)
  expect_true(attr(chunk2_node, "range_modified") %||% FALSE)
  expect_true(attr(chunk3_node, "range_modified") %||% FALSE)
})

test_that("rmd_modify preserves original object structure", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  modified = rmd_modify(rmd, .f = function(x) {
    # Make a small modification
    attr(x, "test") = TRUE
    x
  }, has_type("rmd_chunk"))
  
  # Structure should be preserved
  expect_equal(length(modified), length(rmd))
  expect_equal(rmd_node_type(modified), rmd_node_type(rmd))
  expect_equal(rmd_node_label(modified), rmd_node_label(rmd))
})

test_that("rmd_modify error handling", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test unsupported type
  expect_error(
    rmd_modify("not_rmd_object", .f = identity),
    "Unsupported type"
  )
})

test_that("rmd_modify validates function results", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test function that returns invalid object
  expect_error(
    rmd_modify(rmd, .f = function(x) "not_an_rmd_node"),
    "Function must return a valid rmd node object"
  )
  
  # Test function that returns NULL
  expect_error(
    rmd_modify(rmd, .f = function(x) NULL),
    "Function must return a valid rmd node object"
  )
  
  # Test function that returns list without proper class
  expect_error(
    rmd_modify(rmd, .f = function(x) list(content = "test")),
    "Function must return a valid rmd node object"
  )
  
  # Test function that returns object with wrong class
  expect_error(
    rmd_modify(rmd, .f = function(x) structure(list(), class = "wrong_class")),
    "Function must return a valid rmd node object"
  )
  
  # Test that valid modifications pass validation
  expect_no_error({
    modified = rmd_modify(rmd, .f = function(x) {
      attr(x, "test_attribute") = "valid"
      x
    })
  })
})

test_that("rmd_modify validates chunk structure", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test function that returns incomplete chunk
  expect_error(
    rmd_modify(rmd, .f = function(x) {
      if (inherits(x, "rmd_chunk")) {
        # Return chunk missing required fields
        structure(list(engine = "r"), class = "rmd_chunk")
      } else {
        x
      }
    }, has_type("rmd_chunk")),
    "rmd_chunk validation failed.*missing required fields"
  )
})

test_that("rmd_modify validates heading structure", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test function that returns incomplete heading
  expect_error(
    rmd_modify(rmd, .f = function(x) {
      if (inherits(x, "rmd_heading")) {
        # Return heading missing required fields
        structure(list(name = "test"), class = "rmd_heading")
      } else {
        x
      }
    }, has_type("rmd_heading")),
    "rmd_heading validation failed.*missing required fields"
  )
})

test_that("rmd_modify reports multiple validation errors", {
  rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
  
  # Test function that returns heading with multiple issues
  expect_error(
    rmd_modify(rmd, .f = function(x) {
      if (inherits(x, "rmd_heading")) {
        # Return heading with multiple validation issues
        structure(list(name = 123, level = "invalid"), class = "rmd_heading")
      } else {
        x
      }
    }, has_type("rmd_heading")),
    "rmd_heading validation failed"
  )
  
  # Test function that returns chunk with multiple type issues
  expect_error(
    rmd_modify(rmd, .f = function(x) {
      if (inherits(x, "rmd_chunk")) {
        # Return chunk with wrong field types
        structure(list(
          engine = 123,           # should be character
          name = "test",
          options = "not_list",   # should be list
          yaml_options = list(),
          code = 456,            # should be character
          indent = "",
          n_ticks = 3
        ), class = "rmd_chunk")
      } else {
        x
      }
    }, has_type("rmd_chunk")),
    "rmd_chunk validation failed"
  )
})