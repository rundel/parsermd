#' @export
rmd_template = function(rmd, inc_content, inc_labels) {
  UseMethod("rmd_template")
}

#' @export
rmd_template.default = function(rmd, ...) {
  stop("Unable to generate an Rmd template from an object with class: ", class(rmd))
}


#' @export
rmd_template.rmd_ast = function(rmd, inc_content = FALSE, inc_labels = TRUE) {
  rmd_template( as_tibble(rmd), inc_content = inc_content, inc_labels = inc_labels )
}


#' @export
rmd_template.rmd_tibble = function(rmd, inc_content = FALSE, inc_labels = TRUE) {
  if (!inc_labels) {
    rmd = dplyr::select(tmpl, -label)
  }

  if (inc_content) {
    rmd$content = rmd_node_content(rmd)
  }

  rmd = dplyr::select(rmd, -ast)
  class(rmd) = c("rmd_template", "tbl_df", "tbl", "data.frame")

  rmd
}
