test_that("rmd_node_label works with different node types", {
  # Create test AST with various node types and labels
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "setup", code = "library(dplyr)"),
      rmd_chunk(engine = "r", name = "", code = "plot(cars)", options = list(label = "plot-cars")),
      rmd_chunk(engine = "r", name = "", code = "summary(data)"),  # no name or label
      rmd_heading(name = "Introduction", level = 1L),
      rmd_markdown(lines = "Some text"),
      rmd_yaml(yaml = list(title = "Test"))
    )
  )
  
  # Test label extraction
  labels = rmd_node_label(original_ast)
  
  # Expected labels: name from @name, label from options, empty string (no name/label), heading uses default (NA), markdown uses default (NA), yaml uses default (NA)
  expected_labels = c("setup", "plot-cars", "", NA_character_, NA_character_, NA_character_)
  
  expect_equal(labels, expected_labels)
})

test_that("rmd_node_label handles chunk options", {
  # Create test AST with combined options (from both traditional and YAML sources)
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "", code = "x = 1", options = list(label = "from-yaml")),
      rmd_chunk(engine = "r", name = "", code = "y = 2", options = list(label = "combined-label"))
    )
  )
  
  # Test label extraction
  labels = rmd_node_label(original_ast)
  
  expected_labels = c("from-yaml", "combined-label")
  
  expect_equal(labels, expected_labels)
})

test_that("rmd_node_type works with all node types", {
  # Create test AST with all major node types
  original_ast = rmd_ast(
    nodes = list(
      rmd_yaml(yaml = list(title = "Test")),
      rmd_heading(name = "Section", level = 1L),
      rmd_chunk(engine = "r", name = "code", code = "x = 1"),
      rmd_raw_chunk(format = "r", code = "y = 2"),
      rmd_code_block(classes = ".python", code = "print('hello')"),
      rmd_code_block_literal(attr = "r, echo=TRUE", code = "z = 3"),
      rmd_markdown(lines = "Some text"),
      rmd_fenced_div_open(classes = ".note"),
      rmd_fenced_div_close()
    )
  )
  
  # Test type extraction
  types = rmd_node_type(original_ast)
  
  expected_types = c("rmd_yaml", "rmd_heading", "rmd_chunk", "rmd_raw_chunk", 
                     "rmd_code_block", "rmd_code_block_literal", "rmd_markdown", 
                     "rmd_fenced_div_open", "rmd_fenced_div_close")
  
  expect_equal(types, expected_types)
})

test_that("rmd_node_length works with different node types", {
  # Create test AST with nodes of different lengths
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "code", code = c("x = 1", "y = 2", "z = 3")),
      rmd_raw_chunk(format = "r", code = c("a", "b")),
      rmd_markdown(lines = c("Line 1", "Line 2", "Line 3", "Line 4")),
      rmd_yaml(yaml = list(title = "Test", author = "Me", date = "2023-01-01")),
      rmd_heading(name = "Section", level = 1L),  # should return NA
      rmd_code_block(classes = ".python", code = "print('hello')"),  # should return NA (no specific method)
      rmd_code_block_literal(attr = "r", code = c("w = 4", "x = 5"))  # should return NA (no specific method)
    )
  )
  
  # Test length extraction
  lengths = rmd_node_length(original_ast)
  
  # Expected: 3 code lines, 2 code lines, 4 text lines, 3 yaml items, NA, NA, NA
  expected_lengths = c(3L, 2L, 4L, 3L, NA_integer_, NA_integer_, NA_integer_)
  
  expect_equal(lengths, expected_lengths)
})

test_that("rmd_node_content works with different node types", {
  # Create test AST with various content
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "code", code = c("library(dplyr)", "data %>% filter(x > 0)")),
      rmd_raw_chunk(format = "r", code = c("raw line 1", "raw line 2")),
      rmd_markdown(lines = c("This is markdown", "with multiple lines")),
      rmd_code_block(classes = ".python", code = c("print('hello')", "print('world')")),
      rmd_code_block_literal(attr = "python", code = c("import pandas", "df.head()")),
      rmd_heading(name = "Section", level = 1L),  # should return NA
      rmd_yaml(yaml = list(title = "Test"))  # should return NA (no specific method)
    )
  )
  
  # Test content extraction
  content = rmd_node_content(original_ast)
  
  expected_content = c(
    "library(dplyr)\ndata %>% filter(x > 0)",
    "raw line 1\nraw line 2", 
    "This is markdown\nwith multiple lines",
    "print('hello')\nprint('world')",
    "import pandas\ndf.head()",
    NA_character_,  # rmd_heading has no content method
    NA_character_   # rmd_yaml has no content method
  )
  
  expect_equal(content, expected_content)
})

test_that("rmd_node_attr works with different attributes", {
  # Create test AST with just chunks and headings to test specific attributes
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "test", code = "x = 1", options = list(eval = TRUE)),
      rmd_heading(name = "Introduction", level = 2L)
    )
  )
  
  # Test attribute extraction for chunk-specific properties
  chunk_ast = rmd_ast(nodes = list(rmd_chunk(engine = "python", name = "py-test", code = "print('hello')")))
  heading_ast = rmd_ast(nodes = list(rmd_heading(name = "Section", level = 1L)))
  
  # Test chunk attributes
  chunk_engine = rmd_node_attr(chunk_ast, "engine")
  chunk_name = rmd_node_attr(chunk_ast, "name")
  chunk_code = rmd_node_attr(chunk_ast, "code")
  
  # Test heading attributes  
  heading_name = rmd_node_attr(heading_ast, "name")
  heading_level = rmd_node_attr(heading_ast, "level")
  
  expect_equal(chunk_engine, list("python"))
  expect_equal(chunk_name, list("py-test"))
  expect_equal(chunk_code, list("print('hello')"))
  expect_equal(heading_name, list("Section"))
  expect_equal(heading_level, list(1L))
})

test_that("rmd_node_engine extracts engines correctly", {
  # Create test AST with different engines
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "r-code", code = "x = 1"),
      rmd_chunk(engine = "python", name = "py-code", code = "x = 1"),
      rmd_raw_chunk(format = "bash", code = "echo 'hello'"),
      rmd_heading(name = "Section", level = 1L),  # no engine
      rmd_markdown(lines = "Text")  # no engine
    )
  )
  
  # Test engine extraction
  engines = rmd_node_engine(original_ast)
  
  expected_engines = c("r", "python", NA_character_, NA_character_, NA_character_)
  
  expect_equal(engines, expected_engines)
})

test_that("rmd_node_options extracts chunk options correctly", {
  # Create test AST with only chunks (since only chunks have options)
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "code1", code = "x = 1", options = list(eval = TRUE, echo = FALSE)),
      rmd_chunk(engine = "r", name = "code2", code = "y = 2"),  # no options
      rmd_chunk(engine = "python", name = "code3", code = "z = 3", options = list(fig.width = 8))
    )
  )
  
  # Test options extraction
  options = rmd_node_options(original_ast)
  
  expected_options = list(
    list(eval = TRUE, echo = FALSE),
    list() |> stats::setNames(character()),
    list(fig.width = 8)
  )
  
  expect_equal(options, expected_options)
})

test_that("rmd_node_code extracts code correctly", {
  # Create test AST with different code content
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", name = "single", code = "x = 1"),
      rmd_chunk(engine = "r", name = "multi", code = c("library(dplyr)", "data %>% summarise(n())")),
      rmd_raw_chunk(format = "bash", code = c("#!/bin/bash", "echo 'hello'")),
      rmd_heading(name = "Section", level = 1L),  # no code
      rmd_markdown(lines = "Text")  # no code
    )
  )
  
  # Test code extraction
  codes = rmd_node_code(original_ast)
  
  expected_codes = list(
    "x = 1",
    c("library(dplyr)", "data %>% summarise(n())"),
    c("#!/bin/bash", "echo 'hello'"),
    NULL,
    NULL
  )
  
  expect_equal(codes, expected_codes)
})

test_that("rmd_node functions work with empty AST", {
  # Create empty AST
  empty_ast = rmd_ast(nodes = list())
  
  # Test all functions with empty AST
  expect_equal(rmd_node_label(empty_ast), character(0))
  expect_equal(rmd_node_type(empty_ast), character(0))
  expect_equal(rmd_node_length(empty_ast), integer(0))
  expect_equal(rmd_node_content(empty_ast), character(0))
  expect_equal(rmd_node_engine(empty_ast), character(0))
  expect_equal(rmd_node_attr(empty_ast, "name"), list())
  expect_equal(rmd_node_options(empty_ast), list())
  expect_equal(rmd_node_code(empty_ast), list())
})

test_that("rmd_node functions work with single nodes", {
  # Test with individual node objects
  chunk_node = rmd_chunk(engine = "r", name = "test", code = c("x = 1", "y = 2"), options = list(eval = TRUE))
  heading_node = rmd_heading(name = "Introduction", level = 2L)
  markdown_node = rmd_markdown(lines = c("Some text", "More text"))
  
  # Test individual node functions
  expect_equal(rmd_node_label(chunk_node), "test")
  expect_equal(rmd_node_label(heading_node), NA_character_)
  expect_equal(rmd_node_label(markdown_node), NA_character_)
  
  expect_equal(rmd_node_type(chunk_node), "rmd_chunk")
  expect_equal(rmd_node_type(heading_node), "rmd_heading")
  expect_equal(rmd_node_type(markdown_node), "rmd_markdown")
  
  expect_equal(rmd_node_length(chunk_node), 2L)
  expect_equal(rmd_node_length(heading_node), NA_integer_)
  expect_equal(rmd_node_length(markdown_node), 2L)
  
  expect_equal(rmd_node_content(chunk_node), "x = 1\ny = 2")
  expect_equal(rmd_node_content(heading_node), NA_character_)
  expect_equal(rmd_node_content(markdown_node), "Some text\nMore text")
})

test_that("rmd_node_attr validates input", {
  # Create simple AST
  test_ast = rmd_ast(
    nodes = list(rmd_chunk(engine = "r", name = "test", code = "x = 1"))
  )
  
  # Test input validation
  expect_error(rmd_node_attr(test_ast, c("name", "engine")), "Must have length 1")
  expect_error(rmd_node_attr(test_ast, 123), "Must be of type 'character'")
  expect_error(rmd_node_attr(test_ast, character(0)), "Must have length 1")
})

test_that("rmd_node functions handle complex chunk labels correctly", {
  # Test edge cases for chunk labels
  original_ast = rmd_ast(
    nodes = list(
      # Name takes precedence over options
      rmd_chunk(engine = "r", name = "chunk-name", code = "x = 1", options = list(label = "option-label")),
      # Options label when name is empty
      rmd_chunk(engine = "r", name = "", code = "y = 2", options = list(label = "from-options")),
      # YAML options label when name and options are empty/missing
      rmd_chunk(engine = "r", name = "", code = "z = 3", options = list(label = "from-yaml")),
      # No label anywhere
      rmd_chunk(engine = "r", name = "", code = "w = 4")
    )
  )
  
  labels = rmd_node_label(original_ast)
  
  expected_labels = c("chunk-name", "from-options", "from-yaml", "")
  
  expect_equal(labels, expected_labels)
})

test_that("rmd_node_label assignment works", {
  # Test assignment for rmd_chunk
  chunk = rmd_chunk("r", "original_name", code = "1 + 1")
  expect_equal(rmd_node_label(chunk), "original_name")
  
  rmd_node_label(chunk) = "new_name"
  expect_equal(rmd_node_label(chunk), "new_name")
  
  # Test error for unsupported types
  expect_snapshot_error({x = list(); rmd_node_label(x) = "test"})
  expect_snapshot_error({x = data.frame(); rmd_node_label(x) = "test"})
  
  # Test validation
  expect_snapshot_error({chunk = rmd_chunk("r", "test", code = "1"); rmd_node_label(chunk) = NA_character_})
  expect_snapshot_error({chunk = rmd_chunk("r", "test", code = "1"); rmd_node_label(chunk) = c("a", "b")})
})

test_that("rmd_node_options assignment works", {
  # Test assignment for rmd_chunk
  chunk = rmd_chunk("r", "test", code = "1 + 1", options = list(eval = TRUE))
  expect_equal(rmd_node_options(chunk), list(eval = TRUE))
  
  # Test setting new options
  rmd_node_options(chunk) = list(echo = FALSE, fig.width = 8)
  expected_options = list(eval = TRUE, echo = FALSE, fig.width = 8)
  expect_equal(rmd_node_options(chunk), expected_options)
  
  # Test overwriting existing options
  rmd_node_options(chunk) = list(eval = FALSE)
  expected_options = list(eval = FALSE, echo = FALSE, fig.width = 8)
  expect_equal(rmd_node_options(chunk), expected_options)
  
  # Test error for unsupported types
  expect_snapshot_error({x = list(); rmd_node_options(x) = list(test = TRUE)})
  expect_snapshot_error({x = data.frame(); rmd_node_options(x) = list(test = TRUE)})
  
  # Test validation
  expect_snapshot_error({chunk = rmd_chunk("r", "test", code = "1"); rmd_node_options(chunk) = "not a list"})
  expect_snapshot_error({chunk = rmd_chunk("r", "test", code = "1"); rmd_node_options(chunk) = list(1, 2, 3)})  # unnamed list
})

test_that("rmd_node_attr assignment works", {
  # Test assignment for rmd_chunk
  chunk = rmd_chunk("r", "test", code = "1 + 1")
  expect_equal(rmd_node_attr(chunk, "engine"), "r")
  
  # Test setting engine
  rmd_node_attr(chunk, "engine") = "python"
  expect_equal(rmd_node_attr(chunk, "engine"), "python")
  
  # Test setting name
  rmd_node_attr(chunk, "name") = "new_name"
  expect_equal(rmd_node_attr(chunk, "name"), "new_name")
  
  # Test error for unsupported types
  expect_snapshot_error({x = list(); rmd_node_attr(x, "test") = "value"})
  expect_snapshot_error({x = data.frame(); rmd_node_attr(x, "test") = "value"})
})

test_that("rmd_node_set_label works and is pipeable", {
  # Test basic functionality
  chunk = rmd_chunk("r", "original", code = "1 + 1")
  result = rmd_node_set_label(chunk, "new_label")
  
  expect_equal(rmd_node_label(result), "new_label")
  expect_true(S7::S7_inherits(result, rmd_chunk))
  
  # Test piping
  result = rmd_chunk("r", "test", code = "x = 1") |>
    rmd_node_set_label("piped_label")
  
  expect_equal(rmd_node_label(result), "piped_label")
  
  # Test chaining with other functions
  result = rmd_chunk("r", "test", code = "x = 1") |>
    rmd_node_set_label("chained_label") |>
    rmd_node_set_options(eval = FALSE)
  
  expect_equal(rmd_node_label(result), "chained_label")
  expect_equal(rmd_node_options(result), list(eval = FALSE))
})

test_that("rmd_node_set_options works and is pipeable", {
  # Test basic functionality with new signature
  chunk = rmd_chunk("r", "test", code = "1 + 1", options = list(eval = TRUE))
  result = rmd_node_set_options(chunk, echo = FALSE)
  
  expected_options = list(eval = TRUE, echo = FALSE)
  expect_equal(rmd_node_options(result), expected_options)
  expect_true(S7::S7_inherits(result, rmd_chunk))
  
  # Test piping with multiple options
  result = rmd_chunk("r", "test", code = "x = 1") |>
    rmd_node_set_options(fig.width = 8, eval = FALSE)
  
  expect_equal(rmd_node_options(result), list(fig.width = 8, eval = FALSE))
  
  # Test chaining with other functions
  result = rmd_chunk("r", "original", code = "x = 1") |>
    rmd_node_set_label("chained") |>
    rmd_node_set_options(echo = TRUE, warning = FALSE)
  
  expect_equal(rmd_node_label(result), "chained")
  expect_equal(rmd_node_options(result), list(echo = TRUE, warning = FALSE))
})

test_that("rmd_node_set_attr works and is pipeable", {
  # Test basic functionality
  chunk = rmd_chunk("r", "test", code = "1 + 1")
  result = rmd_node_set_attr(chunk, "engine", "python")
  
  expect_equal(rmd_node_attr(result, "engine"), "python")
  expect_true(S7::S7_inherits(result, rmd_chunk))
  
  # Test piping
  result = rmd_chunk("r", "test", code = "x = 1") |>
    rmd_node_set_attr("engine", "julia")
  
  expect_equal(rmd_node_attr(result, "engine"), "julia")
  
  # Test chaining with other functions
  result = rmd_chunk("r", "original", code = "x = 1") |>
    rmd_node_set_label("attr_test") |>
    rmd_node_set_attr("engine", "python") |>
    rmd_node_set_options(eval = FALSE)
  
  expect_equal(rmd_node_label(result), "attr_test")
  expect_equal(rmd_node_attr(result, "engine"), "python")
  expect_equal(rmd_node_options(result), list(eval = FALSE))
})

test_that("pipeable setters handle errors correctly", {
  # Test that errors from underlying functions are propagated
  expect_snapshot_error(rmd_node_set_label(list(), "test"))
  expect_snapshot_error(rmd_node_set_options(list(), eval = TRUE))
  expect_snapshot_error(rmd_node_set_attr(list(), "test", "value"))
})

test_that("rmd_node_content assignment works for rmd_chunk", {
  # Test assignment for rmd_chunk
  chunk = rmd_chunk("r", "test", code = c("old line 1", "old line 2"))
  expect_equal(rmd_node_content(chunk), "old line 1\nold line 2")
  
  rmd_node_content(chunk) = c("new line 1", "new line 2", "new line 3")
  expect_equal(rmd_node_content(chunk), "new line 1\nnew line 2\nnew line 3")
  expect_equal(chunk@code, c("new line 1", "new line 2", "new line 3"))
  
  # Test single line assignment
  rmd_node_content(chunk) = "single line"
  expect_equal(rmd_node_content(chunk), "single line")
  expect_equal(chunk@code, "single line")
})

test_that("rmd_node_content assignment works for rmd_raw_chunk", {
  # Test assignment for rmd_raw_chunk
  raw_chunk = rmd_raw_chunk(format = "bash", code = c("echo hello", "echo world"))
  expect_equal(rmd_node_content(raw_chunk), "echo hello\necho world")
  
  rmd_node_content(raw_chunk) = c("#!/bin/bash", "echo 'new content'")
  expect_equal(rmd_node_content(raw_chunk), "#!/bin/bash\necho 'new content'")
  expect_equal(raw_chunk@code, c("#!/bin/bash", "echo 'new content'"))
})

test_that("rmd_node_content assignment works for rmd_markdown", {
  # Test assignment for rmd_markdown
  markdown = rmd_markdown(lines = c("Old paragraph 1", "Old paragraph 2"))
  expect_equal(rmd_node_content(markdown), "Old paragraph 1\nOld paragraph 2")
  
  rmd_node_content(markdown) = c("New paragraph 1", "New paragraph 2", "New paragraph 3")
  expect_equal(rmd_node_content(markdown), "New paragraph 1\nNew paragraph 2\nNew paragraph 3")
  expect_equal(markdown@lines, c("New paragraph 1", "New paragraph 2", "New paragraph 3"))
})

test_that("rmd_node_content assignment works for rmd_code_block", {
  # Test assignment for rmd_code_block
  code_block = rmd_code_block(classes = ".python", code = c("import os", "print('hello')"))
  expect_equal(rmd_node_content(code_block), "import os\nprint('hello')")
  
  rmd_node_content(code_block) = c("import sys", "print('world')", "sys.exit(0)")
  expect_equal(rmd_node_content(code_block), "import sys\nprint('world')\nsys.exit(0)")
  expect_equal(code_block@code, c("import sys", "print('world')", "sys.exit(0)"))
})

test_that("rmd_node_content assignment works for rmd_code_block_literal", {
  # Test assignment for rmd_code_block_literal
  code_block_literal = rmd_code_block_literal(attr = "python", code = c("x = 1", "y = 2"))
  expect_equal(rmd_node_content(code_block_literal), "x = 1\ny = 2")
  
  rmd_node_content(code_block_literal) = c("a = 3", "b = 4", "c = 5")
  expect_equal(rmd_node_content(code_block_literal), "a = 3\nb = 4\nc = 5")
  expect_equal(code_block_literal@code, c("a = 3", "b = 4", "c = 5"))
})

test_that("rmd_node_content assignment validates input", {
  # Test validation for character input
  chunk = rmd_chunk("r", "test", code = "x = 1")
  
  # These should work
  rmd_node_content(chunk) = "valid string"
  rmd_node_content(chunk) = c("vector", "of", "strings")
  
  # These should fail
  expect_snapshot_error({rmd_node_content(chunk) = 123})
  expect_snapshot_error({rmd_node_content(chunk) = list("not", "character")})
  expect_snapshot_error({rmd_node_content(chunk) = NULL})
})

test_that("rmd_node_content assignment fails for unsupported types", {
  # Test error for unsupported types
  expect_snapshot_error({x = list(); rmd_node_content(x) = "test"})
  expect_snapshot_error({x = data.frame(); rmd_node_content(x) = "test"})
  expect_snapshot_error({x = rmd_heading("Test", 1L); rmd_node_content(x) = "test"})
  expect_snapshot_error({x = rmd_yaml(list(title = "Test")); rmd_node_content(x) = "test"})
})

test_that("rmd_node_set_content works and is pipeable", {
  # Test basic functionality for chunk
  chunk = rmd_chunk("r", "test", code = "old code")
  result = rmd_node_set_content(chunk, c("new line 1", "new line 2"))
  
  expect_equal(rmd_node_content(result), "new line 1\nnew line 2")
  expect_true(S7::S7_inherits(result, rmd_chunk))
  
  # Test piping with chunk
  result = rmd_chunk("r", "test", code = "x = 1") |>
    rmd_node_set_content(c("y = 2", "z = 3"))
  
  expect_equal(rmd_node_content(result), "y = 2\nz = 3")
  
  # Test with markdown
  result = rmd_markdown(lines = "old text") |>
    rmd_node_set_content(c("new paragraph 1", "new paragraph 2"))
  
  expect_equal(rmd_node_content(result), "new paragraph 1\nnew paragraph 2")
  
  # Test with code block
  result = rmd_code_block(classes = ".r", code = "old") |>
    rmd_node_set_content(c("library(dplyr)", "data %>% summarise()"))
  
  expect_equal(rmd_node_content(result), "library(dplyr)\ndata %>% summarise()")
  
  # Test chaining with other functions
  result = rmd_chunk("r", "original", code = "old") |>
    rmd_node_set_label("content_test") |>
    rmd_node_set_content(c("a = 1", "b = 2")) |>
    rmd_node_set_options(eval = FALSE, echo = TRUE)
  
  expect_equal(rmd_node_label(result), "content_test")
  expect_equal(rmd_node_content(result), "a = 1\nb = 2")
  expect_equal(rmd_node_options(result), list(eval = FALSE, echo = TRUE))
})

test_that("rmd_node_set_content handles errors correctly", {
  # Test that errors from underlying functions are propagated
  expect_snapshot_error(rmd_node_set_content(list(), "test"))
  expect_snapshot_error(rmd_node_set_content(rmd_heading("Test", 1L), "test"))
  expect_snapshot_error(rmd_node_set_content(rmd_chunk("r", "test", code = "x"), 123))
})
