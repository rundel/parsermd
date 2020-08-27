#' @export
rmd_has_node = function(obj, ...) {
  UseMethod("rmd_has_node")
}

#' @export
rmd_has_node.default = function(obj, ...) {
  stop("Unable to subset an object with class: ", class(obj))
}

#' @export
rmd_has_node.rmd_ast = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  subset = comb_subset(ast, sec_refs, type_refs, name_refs, combine = `|`)
  any(subset)
}

#' @export
rmd_has_node.rmd_tibble = function(df, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  rmd_has_node(df$ast, sec_refs, type_refs, name_refs)
}


