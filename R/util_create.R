create_ast = function(...) {
  ast = list(...)
  class(ast) = c("rmd_ast", "list")

  ast
}

create_yaml = function(..., parse = TRUE) {
  yaml = c(...)
  yaml = as.character(yaml)
  class(yaml) = "rmd_yaml"

  if (parse)
    yaml = parse_yaml(yaml)

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

create_chunk = function(name = NULL, engine = "r", options = list(), code = NULL, indent="") {
  checkmate::assert_character(name, len = 1, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(engine, len = 1, any.missing = FALSE)
  checkmate::assert_list(options, any.missing = FALSE, names = "named")
  checkmate::assert_character(code, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(indent, len = 1, any.missing = FALSE)

  if (is.null(name))
    name = ""

  if (is.null(code))
    code = ""

  if (length(options) == 0)
    names(options) = character()

  structure(
    list(
      engine = engine,
      name = name,
      options = options,
      code = code,
      indent = indent
    ),
    class = "rmd_chunk"
  )
}
