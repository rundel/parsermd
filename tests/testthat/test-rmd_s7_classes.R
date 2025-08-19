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
    label = "test",
    options = list(),
    code = c("x = 1", "y = 2"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(chunk, "rmd_chunk")
  expect_equal(chunk@engine, "r")
  expect_equal(chunk@label, "test")
  
  # Invalid engine (wrong length)
  expect_snapshot_error(
    rmd_chunk(
      engine = c("r", "python"),
      label = "test",
      options = list(),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (too small)
  expect_snapshot_error(
    rmd_chunk(
      engine = "r",
      label = "test",
      options = list(),
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
  # Valid code block with classes
  code_block = rmd_code_block(
    id = character(),
    classes = c(".python"),
    attr = character(),
    code = c("print('hello')", "x = 1"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(code_block, "rmd_code_block")
  expect_equal(code_block@classes, ".python")
  
  # Valid code block with ID and attributes
  code_block_full = rmd_code_block(
    id = "#mycode",
    classes = c(".python", ".numberLines"),
    attr = c(startFrom = "10", linenos = "table"),
    code = c("print('hello')"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(code_block_full, "rmd_code_block")
  expect_equal(code_block_full@id, "#mycode")
  expect_equal(code_block_full@classes, c(".python", ".numberLines"))
  expect_equal(code_block_full@attr[["startFrom"]], "10")
  
  # Valid empty code block
  empty_block = rmd_code_block(
    id = character(),
    classes = character(),
    attr = character(),
    code = character(),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(empty_block, "rmd_code_block")
  
  # Invalid id (wrong length)
  expect_snapshot_error(
    rmd_code_block(
      id = c("#id1", "#id2"),
      classes = character(),
      attr = character(),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid classes (named)
  expect_snapshot_error(
    rmd_code_block(
      id = character(),
      classes = c(python = ".python"),
      attr = character(),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid attr (unnamed)
  expect_snapshot_error(
    rmd_code_block(
      id = character(),
      classes = character(),
      attr = c("value1", "value2"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (wrong length)
  expect_snapshot_error(
    rmd_code_block(
      id = character(),
      classes = character(),
      attr = character(),
      code = character(),
      indent = "",
      n_ticks = c(3L, 4L)
    )
  )
})

test_that("rmd_code_block_literal S7 class works", {
  # Valid code block literal
  code_block_literal = rmd_code_block_literal(
    attr = "r, echo=TRUE, eval=FALSE",
    code = c("x <- 1:10", "mean(x)"),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(code_block_literal, "rmd_code_block_literal")
  expect_equal(code_block_literal@attr, "r, echo=TRUE, eval=FALSE")
  expect_equal(code_block_literal@code, c("x <- 1:10", "mean(x)"))
  
  # Valid empty code block literal
  empty_literal = rmd_code_block_literal(
    attr = "",
    code = character(),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(empty_literal, "rmd_code_block_literal")
  expect_equal(empty_literal@attr, "")
  expect_equal(empty_literal@code, character())
  
  # Valid with nested braces in attr
  nested_braces = rmd_code_block_literal(
    attr = "r, code='function() { return(1) }'",
    code = character(),
    indent = "",
    n_ticks = 3L
  )
  expect_s3_class(nested_braces, "rmd_code_block_literal")
  expect_equal(nested_braces@attr, "r, code='function() { return(1) }'")
  
  # Invalid attr (wrong length)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = c("r", "python"),
      code = character(),
      indent = "",
      n_ticks = 3L
    )
  )
  
  # Invalid indent (wrong length)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = "r",
      code = character(),
      indent = c("", " "),
      n_ticks = 3L
    )
  )
  
  # Invalid n_ticks (too small)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = "r",
      code = character(),
      indent = "",
      n_ticks = 2L
    )
  )
  
  # Invalid n_ticks (wrong length)
  expect_snapshot_error(
    rmd_code_block_literal(
      attr = "r",
      code = character(),
      indent = "",
      n_ticks = c(3L, 4L)
    )
  )
})

test_that("rmd_fenced_div_open S7 class works", {
  # Valid fenced div with all properties
  div_open = rmd_fenced_div_open(
    id = "#myid", 
    classes = c(".note", ".warning"), 
    attr = c(title = "Test", role = "alert")
  )
  expect_s3_class(div_open, "rmd_fenced_div_open")
  expect_equal(div_open@id, "#myid")
  expect_equal(div_open@classes, c(".note", ".warning"))
  expect_equal(div_open@attr, c(title = "Test", role = "alert"))
  
  # Valid empty properties
  empty_div = rmd_fenced_div_open()
  expect_s3_class(empty_div, "rmd_fenced_div_open")
  expect_equal(empty_div@id, character())
  expect_equal(empty_div@classes, character())
  expect_equal(empty_div@attr, character())
  
  # Valid with only ID
  id_only = rmd_fenced_div_open(id = "#test")
  expect_equal(id_only@id, "#test")
  expect_equal(id_only@classes, character())
  expect_equal(id_only@attr, character())
  
  # Valid with only classes
  class_only = rmd_fenced_div_open(classes = c(".warning", ".large"))
  expect_equal(class_only@id, character())
  expect_equal(class_only@classes, c(".warning", ".large"))
  expect_equal(class_only@attr, character())
  
  # Valid with only attributes
  attr_only = rmd_fenced_div_open(attr = c(style = "color:red", width = "100px"))
  expect_equal(attr_only@id, character())
  expect_equal(attr_only@classes, character())
  expect_equal(attr_only@attr, c(style = "color:red", width = "100px"))
  
  # Test validators - ID without # prefix
  expect_snapshot_error(
    rmd_fenced_div_open(id = "myid")  # ID must start with #
  )
  
  # Test validators - class without . prefix
  expect_snapshot_error(
    rmd_fenced_div_open(classes = c("note"))  # Classes must start with .
  )
  
  # Test validators - multiple IDs not allowed
  expect_snapshot_error(
    rmd_fenced_div_open(id = c("#id1", "#id2"))
  )
  
  # Test validators - unnamed attr not allowed
  expect_snapshot_error(
    rmd_fenced_div_open(attr = c("value1", "value2"))
  )
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

test_that("rmd_span S7 class works", {
  # Valid span
  span = rmd_span(
    text = "emphasized text",
    id = "#myspan",
    classes = c(".emphasis", ".highlight"),
    attr = c(style = "color:red", role = "button")
  )
  expect_s3_class(span, "rmd_span")
  expect_equal(span@text, "emphasized text")
  expect_equal(span@id, "#myspan")
  expect_equal(span@classes, c(".emphasis", ".highlight"))
  expect_equal(span@attr, c(style = "color:red", role = "button"))
  
  # Valid span with empty properties
  empty_span = rmd_span(text = "text")
  expect_s3_class(empty_span, "rmd_span")
  expect_equal(empty_span@text, "text")
  expect_equal(empty_span@id, character())
  expect_equal(empty_span@classes, character())
  expect_equal(empty_span@attr, character())
  
  # Invalid text (wrong length)
  expect_snapshot_error(
    rmd_span(text = c("text1", "text2"))
  )
  
  # Invalid id (wrong length)
  expect_snapshot_error(
    rmd_span(text = "test", id = c("#id1", "#id2"))
  )
  
  # Invalid id (no # prefix)
  expect_snapshot_error(
    rmd_span(text = "test", id = "myid")
  )
  
  # Invalid classes (no . prefix)
  expect_snapshot_error(
    rmd_span(text = "test", classes = c("myclass"))
  )
  
  # Invalid attr (unnamed attributes)
  expect_snapshot_error(
    rmd_span(text = "test", attr = c("value1", "value2"))
  )
})

test_that("S7 inheritance works", {
  # AST node classes should inherit from rmd_node
  expect_true(S7::S7_inherits(rmd_yaml(yaml = list()), rmd_node))
  expect_true(S7::S7_inherits(rmd_heading(name = "Test", level = 1L), rmd_node))
  expect_true(S7::S7_inherits(rmd_chunk(
    engine = "r", label = "", options = list(),
    code = character(), indent = "", n_ticks = 3L
  ), rmd_node))
  expect_true(S7::S7_inherits(rmd_raw_chunk(format = "html", code = character()), rmd_node))
  expect_true(S7::S7_inherits(rmd_code_block(
    id = character(), classes = character(), attr = character(),
    code = character(), indent = "", n_ticks = 3L
  ), rmd_node))
  expect_true(S7::S7_inherits(rmd_code_block_literal(
    attr = "", code = character(), indent = "", n_ticks = 3L
  ), rmd_node))
  expect_true(S7::S7_inherits(rmd_markdown(lines = "test"), rmd_node))
  expect_true(S7::S7_inherits(rmd_fenced_div_open(), rmd_node))
  expect_true(S7::S7_inherits(rmd_fenced_div_close(), rmd_node))
  
  # Extracted element classes should NOT inherit from rmd_node
  expect_false(S7::S7_inherits(rmd_span(text = "test"), rmd_node))
  expect_false(S7::S7_inherits(rmd_inline_code(engine = "r", code = "x"), rmd_node))
  expect_false(S7::S7_inherits(rmd_shortcode(func = "test", args = character()), rmd_node))
})

test_that("rmd_ast balanced fenced div validation works", {
  # Valid: balanced fenced divs
  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".note")),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close()
    )),
    "rmd_ast"
  )
  
  # Valid: nested balanced fenced divs
  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".outer")),
      rmd_fenced_div_open(classes = c(".inner")),
      rmd_markdown(lines = "Content"),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    )),
    "rmd_ast"
  )
  
  # Valid: no fenced divs
  expect_s3_class(
    rmd_ast(nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Content")
    )),
    "rmd_ast"
  )
  
  # Valid: empty AST
  expect_s3_class(
    rmd_ast(nodes = list()),
    "rmd_ast"
  )
})

test_that("rmd_ast unbalanced fenced div validation fails", {
  # Invalid: unclosed fenced div
  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".note")),
      rmd_markdown(lines = "Content")
    ))
  )
  
  # Invalid: multiple unclosed fenced divs
  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".outer")),
      rmd_fenced_div_open(classes = c(".inner")),
      rmd_markdown(lines = "Content")
    ))
  )
  
  # Invalid: close before open
  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_close(),
      rmd_markdown(lines = "Content")
    ))
  )
  
  # Invalid: more closes than opens
  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".note")),
      rmd_fenced_div_close(),
      rmd_fenced_div_close()
    ))
  )
  
  # Invalid: unbalanced nested divs
  expect_snapshot_error(
    rmd_ast(nodes = list(
      rmd_fenced_div_open(classes = c(".outer")),
      rmd_fenced_div_open(classes = c(".inner")),
      rmd_fenced_div_close()
    ))
  )
})