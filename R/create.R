#' @export
create_yaml = function(...) {
  yaml = c(...)
  yaml = as.character(yaml)
  class(yaml) = "rmd_yaml"

  yaml
}

#' @export
create_markdown = function(...) {
  md = c(...)
  md = as.character(md)
  class(md) = "rmd_markdown"

  md
}

#' @export
create_heading = function(name, level) {
  checkmate::assert_character(name, len = 1, any.missing = FALSE)
  checkmate::assert_int(level, lower = 1, upper = 6, coerce = TRUE)

  structure(list(name = name, level = level), class = "rmd_heading")
}

#' @export
create_chunk = function(name = NULL, engine = "r", options = list(), code = NULL) {
  checkmate::assert_character(name, len = 1, any.missing = FALSE, null.ok = TRUE)
  checkmate::assert_character(engine, len = 1, any.missing = FALSE)
  checkmate::assert_list(options, any.missing = FALSE, names = "named")
  checkmate::assert_character(code, any.missing = FALSE, null.ok = TRUE)

  if (is.null(name))
    name = ""

  if (is.null(code))
    code = ""

  structure(
    list(
      engine = engine,
      name = name,
      options = options,
      code = code
    ),
    class = "rmd_chunk"
  )
}
