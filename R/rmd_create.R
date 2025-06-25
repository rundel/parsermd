#' @name rmd_create
#'
#' @title AST node creation
#'
#' @description Functions for creating ast nodes,
#'
#' * `rmd_ast()` - Create an ast container of nodes
#'
#' * `rmd_yaml()` - Create a yaml node
#'
#' * `rmd_heading()` - Create a heading node
#'
#' * `rmd_code_blokc()` - Create a markdown code block node
#'
#' * `rmd_chunk()` - Create a chunk node
#'
#' * `rmd_raw_chunk()` - Create a raw chunk node
#'
#' * `rmd_fenced_div_open()` - Create a fenced div open node
#'
#' * `rmd_fenced_div_close()` - Create a fenced div close node
#'
#' * `rmd_markdown()` - Create a markdown container node of `rmd_markdown_line`s
#'
#' * `rmd_inline_code()` - Create an inline code node
#'
#' * `rmd_shortcode()` - Create a shortcode node
#'
#' @param name Character. Heading or chunk name.
#' @param level Integer. Heading level (1-6).
#' @param attr Character. Attributes for code block or fenced div.
#' @param engine Character. Language engine for chunk or inline code
#' @param options List. Chunk options.
#' @param yaml_options List. Chunk yaml options.
#' @param code Character. Code lines for code block or chunk.
#' @param indent Character. Indentation for code block or chunk.
#' @param n_ticks Integer. Number of backticks for code block or chunk.
#' @param format Character. Format for raw chunk.
#' @param func Character. Shortcode function name.
#' @param args Character. Shortcode arguments.
#' @param start Integer. Shortcode start position.
#' @param length Integer. Shortcode length.
#' @param lines Character. Markdown text lines.
#' @param ... Elements within the node.
#'
#' @return An object with class matching the function name, e.g. `rmd_ast()` returns an `rmd_ast` object.
#'
NULL

#' @name rmd_create
#' @export
rmd_ast = function(...) {
  ast = list(...)

  purrr::walk(
    ast, checkmate::assert_multi_class, null.ok = TRUE,
    classes = c("rmd_markdown", "rmd_chunk", "rmd_raw_chunk", "rmd_yaml",
                "rmd_code_block", "rmd_fenced_div_open", "rmd_fenced_div_close", "rmd_heading",
                "rmd_inline_code")
  )

  class(ast) = c("rmd_ast", "list")

  ast
}

#' @name rmd_create
#' @export
rmd_yaml = function(...) {
  yaml = list(...)

  if (length(yaml) == 1 && is.list(yaml[[1]]))
    yaml = yaml[[1]]

  class(yaml) = "rmd_yaml"

  yaml
}





#' @name rmd_create
#' @export
rmd_heading = function(name, level) {
  checkmate::assert_character(name, len = 1, any.missing = FALSE)
  checkmate::assert_int(level, lower = 1, upper = 6, coerce = TRUE)

  structure(list(name = name, level = as.integer(level)), class = "rmd_heading")
}

#' @name rmd_create
#' @export
rmd_code_block = function(
  attr = "", code = character(), indent="", n_ticks = 3L
) {
  checkmate::assert_character(attr, len = 1, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(code, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(indent, len = 1, any.missing = FALSE)
  checkmate::assert_integer(n_ticks, len = 1, any.missing = FALSE)

  structure(
    list(
      attr = attr,
      code = code,
      indent = indent,
      n_ticks = n_ticks
    ),
    class = "rmd_code_block"
  )
}


#' @name rmd_create
#' @export
rmd_chunk = function(
  name = NULL, engine = "r", options = list(), yaml_options = list(), code = character(), indent="", n_ticks = 3L
) {
  checkmate::assert_character(name, len = 1, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(engine, len = 1, any.missing = FALSE)
  checkmate::assert_list(options, any.missing = FALSE, names = "named")
  checkmate::assert_list(yaml_options, any.missing = FALSE, names = "named")
  checkmate::assert_character(code, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(indent, len = 1, any.missing = FALSE)
  checkmate::assert_integer(n_ticks, len = 1, any.missing = FALSE)

  if (is.null(name))
    name = ""

  if (length(options) == 0)
    names(options) = character()

  #if (length(yaml_options) == 0)
  #  names(yaml_options) = character()

  if (!inherits(yaml_options, "rmd_yaml"))
    class(yaml_options) = "rmd_yaml"


  structure(
    list(
      engine = engine,
      name = name,
      options = options,
      yaml_options = yaml_options,
      code = code,
      indent = indent,
      n_ticks = n_ticks
    ),
    class = "rmd_chunk"
  )
}

#' @name rmd_create
#' @export
rmd_raw_chunk = function(format, code = character(), indent="", n_ticks=3L) {
  checkmate::assert_character(format, len = 1, any.missing = FALSE)
  checkmate::assert_character(code, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(indent, len = 1, any.missing = FALSE)
  checkmate::assert_integer(n_ticks, len = 1, any.missing = FALSE)

  structure(
    list(
      format = format,
      code = code,
      indent = indent,
      n_ticks = n_ticks
    ),
    class = "rmd_raw_chunk"
  )
}

#' @name rmd_create
#' @export
rmd_fenced_div_open = function(attr = character()) {
  checkmate::assert_character(attr, any.missing = FALSE, null.ok = TRUE)

  structure(
    attr,
    class = "rmd_fenced_div_open"
  )
}

#' @name rmd_create
#' @export
rmd_fenced_div_close = function() {
  structure(
    list(),
    class = "rmd_fenced_div_close"
  )
}

#' @name rmd_create
#' @export
rmd_markdown = function(lines = character()) {
  checkmate::assert_character(lines, any.missing = FALSE, min.len = 1)

  structure(
    list(lines = lines),
    class = "rmd_markdown"
  )
}



#' @name rmd_create
#' @export
rmd_inline_code = function(engine="", code="", braced = FALSE, start = -1L, length = -1L) {
  start = as.integer(start)
  length = as.integer(length)
  
  checkmate::assert_character(engine, len = 1, any.missing = FALSE)
  checkmate::assert_character(code, len = 1, any.missing = FALSE)
  checkmate::assert_logical(braced, len = 1, any.missing = FALSE)
  checkmate::assert_integer(start, len = 1)
  checkmate::assert_integer(length, len = 1)

  # Build the list object
  obj = list(
    engine = engine,
    code = code,
    braced = braced
  )
  
  # Only add start and length as named attributes if either is not -1
  if (start != -1L || length != -1L) {
    attr(obj, "start") = start
    attr(obj, "length") = length
  }

  structure(
    obj,
    class = "rmd_inline_code"
  )
}

#' @name rmd_create
#' @export
rmd_shortcode = function(func, args = character(), start = -1L, length = -1L) {
  start = as.integer(start)
  length = as.integer(length)
  
  checkmate::assert_character(func, len = 1, any.missing = FALSE)
  checkmate::assert_character(args, any.missing = FALSE)
  checkmate::assert_integer(start, len = 1)
  checkmate::assert_integer(length, len = 1)

  # Build the list object conditionally
  obj = list(
    func = func,
    args = args
  )
  
  # Only add start and length as named attributes if either is not -1
  if (start != -1L || length != -1L) {
    attr(obj, "start") = start
    attr(obj, "length") = length
  }

  structure(obj, class = "rmd_shortcode")
}

