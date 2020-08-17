#' @export
as_document = function(obj, ...) {
  UseMethod("as_document")
}

#' @export
as_document.default = function(obj, ...) {
  stop("Unsupports type:", class(obj))
}

#' @export
as_document.rmd_ast = function(ast, padding = "") {
  unlist(
    purrr::map(
      ast,
      ~ c(as_document(.x), padding)
    )
  )
}

#' @export
as_document.rmd_markdown = function(md) {
  as.character(md)
}

#' @export
as_document.rmd_chunk = function(chunk) {
  if (chunk$name != "") {
    details = chunk$name

    if (length(chunk$options) > 0)
      details = paste0(details, ", ")
  } else {
    details = ""
  }

  if (length(chunk$options) > 0)
    details = paste0(
      details,
      paste(names(chunk$options), "=", chunk$options, collapse=", ")
    )

  lines = c(
    paste0("```{", chunk$engine, details, "}"),
    chunk$code,
    "```"
  )

  paste0(
    chunk$indent,
    lines
  )
}

#' @export
as_document.rmd_heading = function(h) {
  paste(
    paste(rep("#", h$level), collapse=""),
    h$name
  )
}

#' @export
as_document.rmd_yaml = function(yaml) {
  c(
    "---",
    as.character(yaml),
    "---"
  )
}

#' @export
as_document.rmd_yaml_list = function(yaml) {
  as_document.rmd_yaml(
    strsplit(yaml::as.yaml(yaml), "\n")[[1]]
  )
}


