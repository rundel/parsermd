create_ast = function(...) {
  ast = list(...)
  class(ast) = c("rmd_ast", "list")

  ast
}

create_yaml = function(..., parse = FALSE) {
  yaml = list(...)

  if (length(yaml) == 1 && is.list(yaml[[1]]))
    yaml = yaml[[1]]

  if (parse)
    yaml = parse_yaml(as.character(unlist(yaml)))
  else
    class(yaml) = "rmd_yaml_list"

  yaml
}

create_markdown = function(...) {
  md = c(...)
  md = as.character(md)
  class(md) = "rmd_markdown"

  md
}

create_heading = function(name, level) {
  checkmate::assert_character(name, len = 1, any.missing = FALSE)
  checkmate::assert_int(level, lower = 1, upper = 6, coerce = TRUE)

  structure(list(name = name, level = as.integer(level)), class = "rmd_heading")
}

create_code_block = function(
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


create_chunk = function(
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

  if (!inherits(yaml_options, "rmd_yaml_list"))
    class(yaml_options) = "rmd_yaml_list"


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

create_raw_chunk = function(format, code = character(), indent="", n_ticks=3L) {
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

create_fenced_div_open = function(attrs = character()) {
  checkmate::assert_character(attrs, any.missing = FALSE, null.ok = TRUE)

  structure(
    attrs,
    class = "rmd_fenced_div_open"
  )
}

create_fenced_div_close = function() {
  structure(
    list(),
    class = "rmd_fenced_div_close"
  )
}
