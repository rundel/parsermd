test_that("rmd_ast S7 class works", {

  ast = rmd_ast(nodes = list(
    rmd_yaml(yaml = list(title = "Test")),
    rmd_heading(name = "Section", level = 1L),
    rmd_markdown(lines = "Some text")
  ))
  expect_s3_class(ast, "rmd_ast")
  expect_length(ast@nodes, 3)
  

  empty_ast = rmd_ast(nodes = list())
  expect_s3_class(empty_ast, "rmd_ast")
  expect_length(empty_ast@nodes, 0)
  

  expect_snapshot_error(
    rmd_ast(nodes = "not_a_list")
  )
})

test_that("rmd_yaml S7 class works", {

  yaml = rmd_yaml(yaml = list(title = "Test", author = "Me"))
  expect_s3_class(yaml, "rmd_yaml")
  expect_equal(yaml@yaml$title, "Test")
  

  empty_yaml = rmd_yaml(yaml = list())
  expect_s3_class(empty_yaml, "rmd_yaml")
  

  expect_snapshot_error(
    rmd_yaml(yaml = "not_a_list")
  )
})

test_that("rmd_heading S7 class works", {

  heading = rmd_heading(name = "Test Heading", level = 1L)
  expect_s3_class(heading, "rmd_heading")
  expect_equal(heading@name, "Test Heading")
  expect_equal(heading@level, 1L)
  

  expect_snapshot_error(
    rmd_heading(name = "Test", level = 7L)
  )
  

  expect_snapshot_error(
    rmd_heading(name = "Test", level = c(1L, 2L))
  )
  

  expect_snapshot_error(
    rmd_heading(name = c("Test", "Two"), level = 1L)
  )
})

test_that("rmd_chunk S7 class works", {

  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(),
    code = c("x = 1", "y = 2"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(chunk, "rmd_chunk")
  expect_equal(chunk@engine, "r")
  expect_equal(chunk@name, "test")
  

  expect_snapshot_error(
    rmd_chunk(
      engine = c("r", "python"),
      name = "test",
      options = list(),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  

  expect_snapshot_error(
    rmd_chunk(
      engine = "r",
      name = "test",
      options = list(),
      code = character(),
      indent = "",
      n_ticks = 2L
    )
  )
})

test_that("rmd_raw_chunk S7 class works", {

  raw_chunk = rmd_raw_chunk(
    format = "html",
    code = c("<div>", "</div>"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(raw_chunk, "rmd_raw_chunk")
  expect_equal(raw_chunk@format, "html")
  

  expect_snapshot_error(
    rmd_raw_chunk(
      format = c("html", "latex"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  

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

  markdown = rmd_markdown(lines = c("This is", "markdown text"))
  expect_s3_class(markdown, "rmd_markdown")
  expect_equal(markdown@lines, c("This is", "markdown text"))
  

  expect_snapshot_error(
    rmd_markdown(lines = character())
  )
  

  single_line = rmd_markdown(lines = "Single line")
  expect_s3_class(single_line, "rmd_markdown")
  expect_equal(single_line@lines, "Single line")
})

test_that("rmd_code_block S7 class works", {

  code_block = rmd_code_block(
    attr = "python",
    code = c("print('hello')", "x = 1"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(code_block, "rmd_code_block")
  expect_equal(code_block@attr, "python")
  

  expect_snapshot_error(
    rmd_code_block(
      attr = c("python", "r"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  

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

  div_open = rmd_fenced_div_open(attr = c("note", "warning"))
  expect_s3_class(div_open, "rmd_fenced_div_open")
  expect_equal(div_open@attr, c("note", "warning"))
  

  empty_div = rmd_fenced_div_open(attr = character())
  expect_s3_class(empty_div, "rmd_fenced_div_open")
  expect_equal(empty_div@attr, character())
})

test_that("rmd_fenced_div_close S7 class works", {

  div_close = rmd_fenced_div_close()
  expect_s3_class(div_close, "rmd_fenced_div_close")
})

test_that("rmd_inline_code S7 class works", {

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
  

  expect_snapshot_error(
    rmd_inline_code(
      engine = "r",
      code = "x + 1",
      braced = c(TRUE, FALSE),
      start = -1L,
      length = -1L
    )
  )
  

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

  shortcode = rmd_shortcode(
    func = "embed",
    args = c("video.mp4", "width=300"),
    start = 15L,
    length = 20L
  )
  expect_s3_class(shortcode, "rmd_shortcode")
  expect_equal(shortcode@func, "embed")
  expect_equal(shortcode@args, c("video.mp4", "width=300"))
  

  expect_snapshot_error(
    rmd_shortcode(
      func = c("embed", "include"),
      args = character(),
      start = -1L,
      length = -1L
    )
  )
  

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

  expect_true(S7::S7_inherits(rmd_yaml(yaml = list()), rmd_node))
  expect_true(S7::S7_inherits(rmd_heading(name = "Test", level = 1L), rmd_node))
  expect_true(S7::S7_inherits(rmd_chunk(
    engine = "r", name = "", options = list(),
    code = character(), indent = "", n_ticks = 3L
  ), rmd_node))
  expect_true(S7::S7_inherits(rmd_markdown(lines = "test"), rmd_node))
})

test_that("rmd_ast balanced fenced div validation works", {

  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close()
    )),
    "rmd_ast"
  )
  

  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "outer"),
      rmd_fenced_div_open(attr = "inner"),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )),
    "rmd_ast"
  )
  

  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Content")
    )),
    "rmd_ast"
  )
  

  expect_s3_class(
    rmd_ast(nodes = list()),
    "rmd_ast"
  )
})

test_that("rmd_ast unbalanced fenced div validation fails", {

  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_markdown(lines = "Content")
    ))
  )
  

  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "outer"),
      rmd_fenced_div_open(attr = "inner"),
      rmd_markdown(lines = "Content")
    ))
  )
  

  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Content")
    ))
  )
  

  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "note"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ))
  )
  

  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(attr = "outer"),
      rmd_fenced_div_open(attr = "inner"),
      rmd_fenced_div_close()
    ))
  )
})