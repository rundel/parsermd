#' @title Convert an `rmd_ast`, `rmd_tibble`, or any ast node into text.
#'
#' @param x `rmd_ast`, `rmd_tibble`, or parsermd node object.
#' @param padding Padding to add between nodes when assembling the text.
#' @param collapse If not `NULL`, use value to collapse lines.
#' @param ... Unused, for extensibility.
#'
#' @return Returns a character vector.
#'
#' @export
as_document = function(x, padding = "", collapse = NULL, ...) {
  UseMethod("as_document")
}

#' @exportS3Method
as_document.default = function(x, ...) {
  stop("Unsupported class:", paste(class(x), collapse=", "))
}

#' @exportS3Method
as_document.rmd_ast = function(x, padding = "", collapse = NULL, ...) {
  lines = unlist(
    purrr::map(x, ~ c(as_document(.x), padding))
  )

  if (!is.null(collapse))
    lines = paste(lines, collapse = collapse)

  lines
}

#' @exportS3Method
as_document.rmd_tibble = function(x, padding = "", collapse = NULL, ...) {
  as_document(x$ast, padding, collapse)
}


#' @exportS3Method
as_document.rmd_markdown = function(x, ...) {
  as.character(x)
}

#' @exportS3Method
as_document.rmd_chunk = function(x, ...) {
  if (x$name != "") {
    details = x$name

    if (length(x$options) > 0)
      details = paste0(details, ", ")
  } else {
    details = ""
  }

  if (length(x$options) > 0)
    details = paste0(
      details,
      paste(names(x$options), "=", x$options, collapse=", ")
    )

  if (details != "")
    details = paste0(" ", details)

  lines = c(
    paste0("```{", x$engine, details, "}"),
    x$code,
    "```"
  )

  paste0(
    x$indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_raw_chunk = function(x, ...) {
  lines = c(
    paste0("```{=", x$format,"}"),
    x$code,
    "```"
  )

  paste0(
    x$indent,
    lines
  )
}


#' @exportS3Method
as_document.rmd_heading = function(x, ...) {
  res = paste(
    paste(rep("#", x$level), collapse=""),
    x$name
  )

  if (length(x$classes) != 0)
    paste0(
      res, " {", paste(x$classes, collapse=" "), "}"
    )
  else
    res
}

#' @exportS3Method
as_document.rmd_yaml = function(x, ...) {
  c(
    "---",
    as.character(x),
    "---"
  )
}

#' @exportS3Method
as_document.rmd_yaml_list = function(x, ...) {
  as_document.rmd_yaml(
    strsplit(yaml::as.yaml(x), "\n")[[1]]
  )
}


