test_that("rmd_modify works with rmd_ast", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test basic modification of heading name
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_heading")) {
      x@name = "Modified Test"
    }
    x
  })
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Modified Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify works with selection", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test modification of selected chunk only
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "2 + 2"
    }
    x
  }, has_type("rmd_chunk"))
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify passes named arguments to function", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  # Test passing named arguments
  modified = rmd_modify(original_ast, .f = function(x, new_engine) {
    if (inherits(x, "rmd_chunk")) {
      x@engine = new_engine
    }
    x
  }, has_type("rmd_chunk"), new_engine = "python")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "python", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "python", label = "test2", code = "2 + 2")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify works with multiple selection criteria", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Another", level = 2L)
    )
  )
  
  # Test multiple selection arguments - modify both chunks and headings
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "modified"
    } else if (inherits(x, "rmd_heading")) {
      x@name = paste("Modified", x@name)
    }
    x
  }, has_type("rmd_chunk"), has_type("rmd_heading"))
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Modified Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "modified"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Modified Another", level = 2L)
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify handles empty selection", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Test with selection that matches nothing
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "should not happen"
    }
    x
  }, has_type("rmd_chunk"))
  
  # Should be unchanged since no chunks exist
  expect_equal(modified, original_ast)
})

test_that("rmd_modify handles label-based selection", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "setup", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "analysis", code = "2 + 2")
    )
  )
  
  # Test selection by chunk label
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "modified setup"
    }
    x
  }, "setup")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "setup", code = "modified setup"),
      rmd_chunk(engine = "r", label = "analysis", code = "2 + 2")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify validates .f argument", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L)
    )
  )
  
  expect_snapshot_error(
    rmd_modify(original_ast, .f = "not_a_function")
  )
  
  expect_snapshot_error(
    rmd_modify(original_ast, .f = 123)
  )
})

test_that("rmd_modify works with range selection", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "chunk1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "chunk2", code = "2 + 2"),
      rmd_chunk(engine = "r", label = "chunk3", code = "3 + 3")
    )
  )
  
  # Test range selection
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "range modified"
    }
    x
  }, "chunk1":"chunk3")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "chunk1", code = "range modified"),
      rmd_chunk(engine = "r", label = "chunk2", code = "range modified"),
      rmd_chunk(engine = "r", label = "chunk3", code = "range modified")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify preserves original object structure", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Make small modification to chunk code
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "modified"
    }
    x
  }, has_type("rmd_chunk"))
  
  # Structure should be preserved
  expect_equal(length(modified), length(original_ast))
  expect_equal(rmd_node_type(modified), rmd_node_type(original_ast))
  expect_equal(rmd_node_label(modified), rmd_node_label(original_ast))
})

test_that("rmd_modify error handling", {
  # Test unsupported type
  expect_snapshot_error(
    rmd_modify("not_rmd_object", .f = identity)
  )
})

test_that("rmd_modify validates function results", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L)
    )
  )
  
  # Test function that returns invalid object
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) "not_an_rmd_node")
  )
  
  # Test function that returns NULL
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) NULL)
  )
  
  # Test function that returns list without proper class
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) list(content = "test"))
  )
  
  # Test function that returns object with wrong class
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) structure(list(), class = "wrong_class"))
  )
})

test_that("rmd_modify validates chunk structure", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test", code = "1 + 1")
    )
  )
  
  # Test function that returns invalid chunk
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) {
      if (inherits(x, "rmd_chunk")) {
        # Return chunk with invalid engine type
        x@engine = 123
      }
      x
    }, has_type("rmd_chunk"))
  )
})

test_that("rmd_modify validates heading structure", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L)
    )
  )
  
  # Test function that returns invalid heading
  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) {
      if (inherits(x, "rmd_heading")) {
        # Return heading with invalid level
        x@level = 10L  # should be 1-6
      }
      x
    }, has_type("rmd_heading"))
  )
})

test_that("rmd_modify with yaml modifications", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Original", output = "html_document")),
      rmd_heading(name = "Test", level = 1L)
    )
  )
  
  # Test modification of yaml properties
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_yaml")) {
      x@yaml$title = "Modified Title"
    }
    x
  }, has_type("rmd_yaml"))
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Modified Title", output = "html_document")),
      rmd_heading(name = "Test", level = 1L)
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify with markdown modifications", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Original text"),
      rmd_markdown(lines = "Another paragraph")
    )
  )
  
  # Test modification of markdown content
  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_markdown")) {
      x@lines = paste("Modified:", x@lines)
    }
    x
  }, has_type("rmd_markdown"))
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "Modified: Original text"),
      rmd_markdown(lines = "Modified: Another paragraph")
    )
  )
  
  expect_equal(modified, expected_ast)
})