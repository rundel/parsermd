test_that("rmd_ast S7 class works", {
  # Valid AST
  ast = rmd_ast(nodes = list(
    rmd_yaml(yaml = list(title = "Test")),
    rmd_heading(name = "Section", level = 1L),
    rmd_markdown(lines = "Some text")
  ))
  expect_s3_class(ast, "rmd_ast")
  expect_length(ast@nodes, 3)
  
  # Empty AST
  empty_ast = rmd_ast(nodes = list())
  expect_s3_class(empty_ast, "rmd_ast")
  expect_length(empty_ast@nodes, 0)
  
  # Invalid - wrong type for nodes property
  expect_snapshot_error(
    rmd_ast(nodes = "not_a_list")
  )
})

test_that("rmd_yaml S7 class works", {
  # Valid yaml
  yaml = rmd_yaml(yaml = list(title = "Test", author = "Me"))
  expect_s3_class(yaml, "rmd_yaml")
  expect_equal(yaml@yaml$title, "Test")
  
  # Valid empty yaml
  empty_yaml = rmd_yaml(yaml = list())
  expect_s3_class(empty_yaml, "rmd_yaml")
  
  # Invalid - wrong type for yaml property
  expect_snapshot_error(
    rmd_yaml(yaml = "not_a_list")
  )
})

test_that("rmd_heading S7 class works", {
  # Valid heading
  heading = rmd_heading(name = "Test Heading", level = 1L)
  expect_s3_class(heading, "rmd_heading")
  expect_equal(heading@name, "Test Heading")
  expect_equal(heading@level, 1L)
  
  # Invalid level (out of range)
  expect_snapshot_error(
    rmd_heading(name = "Test", level = 7L)
  )
  
  # Invalid level (wrong length)
  expect_snapshot_error(
    rmd_heading(name = "Test", level = c(1L, 2L))
  )
  
  # Invalid name (wrong length)
  expect_snapshot_error(
    rmd_heading(name = c("Test", "Two"), level = 1L)
  )
})

test_that("rmd_chunk S7 class works", {
  # Valid chunk
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(),
    yaml_options = list(),
    code = c("x = 1", "y = 2"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(chunk, "rmd_chunk")
  expect_equal(chunk@engine, "r")
  expect_equal(chunk@name, "test")
  
  # Invalid engine (wrong length)
  expect_snapshot_error(
    rmd_chunk(
      engine = c("r", "python"),
      name = "test",
      options = list(),
      yaml_options = list(),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (too small)
  expect_snapshot_error(
    rmd_chunk(
      engine = "r",
      name = "test",
      options = list(),
      yaml_options = list(),
      code = character(),
      indent = "",
      n_ticks = 2L
    )
  )
})

test_that("rmd_raw_chunk S7 class works", {
  # Valid raw chunk
  raw_chunk = rmd_raw_chunk(
    format = "html",
    code = c("<div>", "</div>"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(raw_chunk, "rmd_raw_chunk")
  expect_equal(raw_chunk@format, "html")
  
  # Invalid format (wrong length)
  expect_snapshot_error(
    rmd_raw_chunk(
      format = c("html", "latex"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (too small)
  expect_snapshot_error(
    rmd_raw_chunk(
      format = "html",
      code = character(),
      indent = "",
      n_ticks = 2L
    )
  )
})

test_that("rmd_markdown S7 class works", {
  # Valid markdown
  markdown = rmd_markdown(lines = c("This is", "markdown text"))
  expect_s3_class(markdown, "rmd_markdown")
  expect_equal(markdown@lines, c("This is", "markdown text"))
  
  # Invalid lines (empty)
  expect_snapshot_error(
    rmd_markdown(lines = character())
  )
  
  # Valid single line
  single_line = rmd_markdown(lines = "Single line")
  expect_s3_class(single_line, "rmd_markdown")
  expect_equal(single_line@lines, "Single line")
})

test_that("rmd_code_block S7 class works", {
  # Valid code block
  code_block = rmd_code_block(
    attr = "python",
    code = c("print('hello')", "x = 1"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(code_block, "rmd_code_block")
  expect_equal(code_block@attr, "python")
  
  # Invalid attr (wrong length)
  expect_snapshot_error(
    rmd_code_block(
      attr = c("python", "r"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (wrong length)
  expect_snapshot_error(
    rmd_code_block(
      attr = "python",
      code = character(),
      indent = "",
      n_ticks = c(3L, 4L)
    )
  )
})

test_that("rmd_fenced_div_open S7 class works", {
  # Valid fenced div open
  div_open = rmd_fenced_div_open(attr = c("note", "warning"))
  expect_s3_class(div_open, "rmd_fenced_div_open")
  expect_equal(div_open@attr, c("note", "warning"))
  
  # Valid empty attr
  empty_div = rmd_fenced_div_open(attr = character())
  expect_s3_class(empty_div, "rmd_fenced_div_open")
  expect_equal(empty_div@attr, character())
})

test_that("rmd_fenced_div_close S7 class works", {
  # Valid fenced div close
  div_close = rmd_fenced_div_close()
  expect_s3_class(div_close, "rmd_fenced_div_close")
})

test_that("rmd_inline_code S7 class works", {
  # Valid inline code
  inline_code = rmd_inline_code(
    engine = "r",
    code = "x + 1",
    braced = TRUE,
    start = 10L,
    length = 5L
  )
  expect_s3_class(inline_code, "rmd_inline_code")
  expect_equal(inline_code@engine, "r")
  expect_equal(inline_code@code, "x + 1")
  expect_equal(inline_code@braced, TRUE)
  
  # Invalid braced (wrong length)  
  expect_snapshot_error(
    rmd_inline_code(
      engine = "r",
      code = "x + 1",
      braced = c(TRUE, FALSE),
      start = -1L,
      length = -1L
    )
  )
  
  # Invalid engine (wrong length)
  expect_snapshot_error(
    rmd_inline_code(
      engine = c("r", "python"),
      code = "x + 1",
      braced = TRUE,
      start = -1L,
      length = -1L
    )
  )
})

test_that("rmd_shortcode S7 class works", {
  # Valid shortcode
  shortcode = rmd_shortcode(
    func = "embed",
    args = c("video.mp4", "width=300"),
    start = 15L,
    length = 20L
  )
  expect_s3_class(shortcode, "rmd_shortcode")
  expect_equal(shortcode@func, "embed")
  expect_equal(shortcode@args, c("video.mp4", "width=300"))
  
  # Invalid func (wrong length)
  expect_snapshot_error(
    rmd_shortcode(
      func = c("embed", "include"),
      args = character(),
      start = -1L,
      length = -1L
    )
  )
  
  # Valid empty args
  empty_args = rmd_shortcode(
    func = "embed",
    args = character(),
    start = -1L,
    length = -1L
  )
  expect_s3_class(empty_args, "rmd_shortcode")
  expect_equal(empty_args@args, character())
})

test_that("S7 inheritance works", {
  # All classes should inherit from rmd_node
  expect_true(S7::S7_inherits(rmd_yaml(yaml = list()), rmd_node))
  expect_true(S7::S7_inherits(rmd_heading(name = "Test", level = 1L), rmd_node))
  expect_true(S7::S7_inherits(rmd_chunk(
    engine = "r", name = "", options = list(), yaml_options = list(),
    code = character(), indent = "", n_ticks = 3L
  ), rmd_node))
  expect_true(S7::S7_inherits(rmd_markdown(lines = "test"), rmd_node))
})