#' @export
rmd_has_node = function(obj, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  UseMethod("rmd_has_node")
}

#' @export
rmd_has_node.default = function(obj, ...) {
  stop("Unable to subset an object with class: ", class(obj))
}

#' @export
rmd_has_node.rmd_ast = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  subset = comb_subset(ast, sec_refs, type_refs, name_refs, combine = `|`, inc_parents = FALSE)
  any(subset)
}

#' @export
rmd_has_node.rmd_tibble = function(df, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  rmd_has_node(df$ast, sec_refs, type_refs, name_refs)
}


#' @export
rmd_has_chunk = function(obj, sec_refs = NULL, name_refs = NULL) {
  rmd_has_node(obj, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs)
}


#' @export
rmd_has_markdown = function(obj, sec_refs = NULL) {
  rmd_has_node(obj, sec_refs = sec_refs, type_refs = "rmd_markdown")
}
