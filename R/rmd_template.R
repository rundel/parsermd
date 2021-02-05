#' @export
rmd_template = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE) {
  UseMethod("rmd_template")
}

#' @export
rmd_template.default = function(rmd, ...) {
  stop("Unable to generate an Rmd template from an object with class: ", class(rmd))
}


#' @export
rmd_template.rmd_ast = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE) {
  rmd_template( as_tibble(rmd), keep_content = keep_content, keep_labels = keep_labels )
}


#' @export
rmd_template.rmd_tibble = function(rmd, keep_content = FALSE, keep_labels = TRUE, keep_headings = FALSE, keep_yaml = FALSE) {
  if (!keep_labels)
    rmd = dplyr::select(tmpl, -.data[["label"]])

  if (keep_content)
    rmd$content = rmd_node_content(rmd)

  if (!keep_headings)
    rmd = dplyr::filter(rmd, .data[["type"]] != "rmd_heading")

  if (!keep_yaml)
    rmd = dplyr::filter(rmd, .data[["type"]] %in% c("rmd_yaml","rmd_yaml_list"))


  rmd = dplyr::select(rmd, -.data[["ast"]])
  class(rmd) = c("rmd_template", "tbl_df", "tbl", "data.frame")

  rmd
}
