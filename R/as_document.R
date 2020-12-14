#' @title Convert an parsermd `rmd_ast` or related object into a text document
#'
#' @param obj `rmd_ast`, `rmd_tibble`, or parsermd node object
#' @param padding Padding to add between nodes when assembling the document.
#'
#' @export
as_document = function(obj, padding = "") {
  UseMethod("as_document")
}

#' @exportS3Method
as_document.default = function(obj) {
  stop("This function does not support class:", class(obj))
}

#' @exportS3Method
as_document.rmd_ast = function(ast, padding = "") {
  unlist(
    purrr::map(
      ast,
      ~ c(as_document(.x), padding)
    )
  )
}

#' @exportS3Method
as_document.rmd_tibble = function(tbl, padding = "") {
  as_document(tbl$ast, padding)
}


#' @exportS3Method
as_document.rmd_markdown = function(md) {
  as.character(md)
}

#' @exportS3Method
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

  if (details != "")
    details = paste0(" ", details)

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

#' @exportS3Method
as_document.rmd_heading = function(h) {
  paste(
    paste(rep("#", h$level), collapse=""),
    h$name
  )
}

#' @exportS3Method
as_document.rmd_yaml = function(yaml) {
  c(
    "---",
    as.character(yaml),
    "---"
  )
}

#' @exportS3Method
as_document.rmd_yaml_list = function(yaml) {
  as_document.rmd_yaml(
    strsplit(yaml::as.yaml(yaml), "\n")[[1]]
  )
}


