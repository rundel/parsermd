#' @title Create a template from an `rmd` object.
#' @description
#' Templates are objects which are meant to capture the structure of an R Markdown document and facilitate the
#' comparison between the template and new Rmd documents, usually to ensure the structure and/or content matches
#' sufficiently.
#'
#' @param rmd R Markdown document in the form of an `rmd_ast` or `rmd_tibble`.
#' @param keep_content Should the template keep the document's content (markdown text and chunk code).
#' @param keep_labels Should the template keep the document's code chunk labels.
#' @param keep_headings Should the template keep the document's headings.
#' @param keep_yaml Should the template keep the document's yaml.
#' @param ... Unused, for extensibility.
#'
#' @return Returns an `rmd_template` object, which is a derived tibble containing relevant structural
#' details of the document.
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package="parsermd"))
#'
#' rmd_select(rmd, by_section(c("Exercise *", "Solution"))) %>%
#'   rmd_template()

#' @export
rmd_template = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE, ...) {
  UseMethod("rmd_template")
}

#' @exportS3Method
rmd_template.default = function(rmd, ...) {
  stop("Unable to generate an Rmd template from an object with class: ", paste(class(rmd), collapse=", "))
}


#' @exportS3Method
rmd_template.rmd_ast = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE, ...) {
  rmd_template(
    as_tibble(rmd),
    keep_content = keep_content,
    keep_labels = keep_labels,
    keep_headings = keep_headings,
    keep_yaml = keep_yaml
  )
}


#' @exportS3Method
rmd_template.rmd_tibble = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE, ...) {
  if (!keep_labels)
    rmd = dplyr::select(rmd, -tidyselect::all_of("label"))

  if (keep_content)
    rmd$content = rmd_node_content(rmd)

  if (!keep_headings)
    rmd = dplyr::filter(rmd, .data[["type"]] != "rmd_heading")

  if (!keep_yaml)
    rmd = dplyr::filter(rmd, !(.data[["type"]] %in% c("rmd_yaml")))


  rmd = dplyr::select(rmd, -tidyselect::all_of("ast"))
  class(rmd) = c("rmd_template", "tbl_df", "tbl", "data.frame")

  rmd
}
