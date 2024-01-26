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
as_document.character = function(x, ...) {
  x
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

  ticks = paste(rep('`', x$n_ticks), collapse="")

  lines = c(
    paste0(ticks, "{", x$engine, details, "}"),
    if (length(x$yaml_options) > 0)
      paste("#|", names(x$yaml_options), ":", x$yaml_options)
    else
      character(),
    x$code,
    ticks
  )

  paste0(
    x$indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_raw_chunk = function(x, ...) {
  ticks = paste(rep('`', x$n_ticks), collapse="")

  lines = c(
    paste0(ticks, "{=", x$format,"}"),
    x$code,
    ticks
  )

  paste0(
    x$indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_code_block = function(x, ...) {
  ticks = paste(rep('`', x$n_ticks), collapse="")

  lines = c(
    paste(ticks, x$attr),
    x$code,
    ticks
  )

  paste0(
    x$indent,
    lines
  )
}


#' @exportS3Method
as_document.rmd_heading = function(x, ...) {
  paste(
    paste(rep("#", x$level), collapse=""),
    x$name
  )
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

# FIXME - add depth counting to make :'s match for more readability

#' @exportS3Method
as_document.rmd_fenced_div_open = function(x, ...) {
  paste0(
    "::: {", paste(x, collapse=" "), "}"
  )
}


#' @exportS3Method
as_document.rmd_fenced_div_close = function(x, ...) {
  c(":::")
}

#' @exportS3Method
as_document.rmd_shortcode = function(x, ...) {
  paste0(
    "{{< ",
      paste(c(x$func, paste0(" ", x$args)), collapse="") ,
    " >}}"
  )
}


