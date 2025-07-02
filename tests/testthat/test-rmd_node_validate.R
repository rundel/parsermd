test_that("rmd_node_validate.rmd_ast works", {
  # Valid AST
  expect_true(rmd_node_validate(rmd_ast(
    rmd_yaml(title = "Test"),
    rmd_heading("Section", 1),
    rmd_markdown(lines = "Some text")
  )))
  
  # Empty AST
  expect_true(rmd_node_validate(rmd_ast()))
  
  # Invalid - not a list
  expect_snapshot_error(rmd_node_validate(
    structure("not_a_list", class = "rmd_ast")
  ))
  
  # Invalid node type in AST
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      rmd_yaml(title = "Test"),
      structure(list(invalid = "node"), class = "invalid_node")
    ), class = c("rmd_ast", "list"))
  ))
  
  # Invalid node content in AST
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      rmd_yaml(title = "Test"),
      structure(list(name = "Test", level = 7), class = "rmd_heading")
    ), class = c("rmd_ast", "list"))
  ))
})

test_that("rmd_node_validate.rmd_yaml works", {
  # Valid yaml
  expect_true(rmd_node_validate(rmd_yaml(title = "Test", author = "Me")))
  
  # Invalid - not a list
  expect_snapshot_error(rmd_node_validate("not_a_list"))
})

test_that("rmd_node_validate.rmd_heading works", {
  # Valid heading
  expect_true(rmd_node_validate(rmd_heading("Test Heading", 1)))
  
  # Invalid level
  expect_snapshot_error(
    rmd_node_validate(structure(list(name = "Test", level = 7), class = "rmd_heading")))
  
  # Missing fields
  expect_snapshot_error(
    rmd_node_validate(structure(list(name = "Test"), class = "rmd_heading")))
})

test_that("rmd_node_validate.rmd_chunk works", {
  # Valid chunk
  expect_true(rmd_node_validate(
    rmd_chunk(name = "test", engine = "r", code = c("x = 1", "y = 2"))
))
  
  # Invalid engine type
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      engine = 123,
      name = "test", 
      options = list(), 
      yaml_options = structure(list(), class = "rmd_yaml"),
      code = c("x = 1", "y = 2"), 
      indent = "", 
      n_ticks = 3L
  ), class = "rmd_chunk")
))
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(engine = "r", name = "test"), class = "rmd_chunk"))
  )
})

test_that("rmd_node_validate.rmd_raw_chunk works", {
  # Valid raw chunk
  expect_true(rmd_node_validate(
    rmd_raw_chunk(format = "html", code = c("<div>", "</div>"))
))
  
  # Invalid format type
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      format = 123,
      code = c("<div>", "</div>"),
      indent = "",
      n_ticks = 3L
  ), class = "rmd_raw_chunk")
))
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(format = "html"), class = "rmd_raw_chunk"))
  )
})

test_that("rmd_node_validate.rmd_markdown works", {
  # Valid markdown
  expect_true(rmd_node_validate(
    rmd_markdown(lines = c("This is", "markdown text"))
))
  
  # Invalid lines type
  expect_snapshot_error(
    rmd_node_validate(structure(list(lines = 123), class = "rmd_markdown"))
  )
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(), class = "rmd_markdown"))
  )
})

test_that("rmd_node_validate.rmd_code_block works", {
  # Valid code block
  expect_true(rmd_node_validate(
    rmd_code_block(attr = "python", code = c("print('hello')", "x = 1"))
))
  
  # Invalid attr type
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      attr = 123,
      code = c("print('hello')", "x = 1"),
      indent = "",
      n_ticks = 3L
  ), class = "rmd_code_block")
))
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(attr = "python"), class = "rmd_code_block"))
  )
})

test_that("rmd_node_validate.rmd_fenced_div_open works", {
  # Valid fenced div open
  expect_true(rmd_node_validate(rmd_fenced_div_open(attr = "note")))
  
  # Invalid attr type
  expect_snapshot_error(
    rmd_node_validate(structure(list(attr = 123), class = "rmd_fenced_div_open"))
  )
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(), class = "rmd_fenced_div_open"))
  )
})

test_that("rmd_node_validate.rmd_fenced_div_close works", {
  # Valid fenced div close
  expect_true(rmd_node_validate(rmd_fenced_div_close()))
  
  # Invalid type (not list)
  expect_snapshot_error(
    rmd_node_validate(structure("not_a_list", class = "rmd_fenced_div_close"))
  )
})

test_that("rmd_node_validate.rmd_inline_code works", {
  # Valid inline code
  expect_true(rmd_node_validate(
    rmd_inline_code(engine = "r", code = "x + 1", braced = TRUE)
))
  
  # Invalid braced type
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      engine = "r",
      code = "x + 1", 
      braced = "not_logical"
  ), class = "rmd_inline_code")
))
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(engine = "r", code = "x + 1"), class = "rmd_inline_code"))
  )
})

test_that("rmd_node_validate.rmd_shortcode works", {
  # Valid shortcode
  expect_true(rmd_node_validate(
    rmd_shortcode(func = "embed", args = c("video.mp4", "width=300"))
))
  
  # Invalid func type
  expect_snapshot_error(rmd_node_validate(
    structure(list(
      func = 123,
      args = c("video.mp4", "width=300")
  ), class = "rmd_shortcode")
))
  
  # Missing required field
  expect_snapshot_error(
    rmd_node_validate(structure(list(func = "embed"), class = "rmd_shortcode"))
  )
})

test_that("rmd_node_validate.default works", {
  # Invalid object type
  expect_snapshot_error(
    rmd_node_validate(structure(list(x = 1, y = 2), class = "unknown_class"))
  )
})