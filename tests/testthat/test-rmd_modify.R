test_that("rmd_modify works with rmd_ast", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_heading")) {
      x@name = "Modified Test"
    }
    x
  })
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Modified Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify works with selection", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "2 + 2"
    }
    x
  }, has_type("rmd_chunk"))
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify passes named arguments to function", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "test2", code = "2 + 2")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x, new_engine) {
    if (inherits(x, "rmd_chunk")) {
      x@engine = new_engine
    }
    x
  }, has_type("rmd_chunk"), new_engine = "python")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "python", name = "test1", code = "1 + 1"),
      rmd_chunk(engine = "python", name = "test2", code = "2 + 2")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify works with multiple selection criteria", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Another", level = 2L)
    )
  )
  

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
      rmd_chunk(engine = "r", name = "test", code = "modified"),
      rmd_markdown(lines = "Some text"),
      rmd_heading(name = "Modified Another", level = 2L)
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify handles empty selection", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "should not happen"
    }
    x
  }, has_type("rmd_chunk"))
  

  expect_equal(modified, original_ast)
})

test_that("rmd_modify handles label-based selection", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "analysis", code = "2 + 2")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "modified setup"
    }
    x
  }, "setup")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "modified setup"),
      rmd_chunk(engine = "r", name = "analysis", code = "2 + 2")
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

  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "chunk1", code = "1 + 1"),
      rmd_chunk(engine = "r", name = "chunk2", code = "2 + 2"),
      rmd_chunk(engine = "r", name = "chunk3", code = "3 + 3")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "range modified"
    }
    x
  }, "chunk1":"chunk3")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "chunk1", code = "range modified"),
      rmd_chunk(engine = "r", name = "chunk2", code = "range modified"),
      rmd_chunk(engine = "r", name = "chunk3", code = "range modified")
    )
  )
  
  expect_equal(modified, expected_ast)
})

test_that("rmd_modify preserves original object structure", {

  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Test", level = 1L),
      rmd_chunk(engine = "r", name = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  

  modified = rmd_modify(original_ast, .f = function(x) {
    if (inherits(x, "rmd_chunk")) {
      x@code = "modified"
    }
    x
  }, has_type("rmd_chunk"))
  

  expect_equal(length(modified), length(original_ast))
  expect_equal(rmd_node_type(modified), rmd_node_type(original_ast))
  expect_equal(rmd_node_label(modified), rmd_node_label(original_ast))
})

test_that("rmd_modify error handling", {

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
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) "not_an_rmd_node")
  )
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) NULL)
  )
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) list(content = "test"))
  )
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) structure(list(), class = "wrong_class"))
  )
})

test_that("rmd_modify validates chunk structure", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "test", code = "1 + 1")
    )
  )
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) {
      if (inherits(x, "rmd_chunk")) {

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
  

  expect_snapshot_error(
    rmd_modify(original_ast, .f = function(x) {
      if (inherits(x, "rmd_heading")) {

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