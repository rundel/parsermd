#' @export
rmd_get_node = function(obj, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  UseMethod("rmd_get_node")
}

#' @export
rmd_get_node.default = function(obj, ...) {
  stop("Unable to subset an object with class: ", class(obj))
}

#' @export
rmd_get_node.rmd_ast = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  subset = comb_subset(ast, sec_refs, type_refs, name_refs, inc_parents = FALSE, combine = `|`)

  if (sum(subset) > 1)
    stop("Multiple nodes match the given criteria.")

  if (sum(subset) == 0)
    NULL
  else
    ast[[which(subset)]]
}

#' @export
rmd_get_node.rmd_tibble = function(df, sec_refs = NULL, type_refs = NULL, name_refs = NULL) {
  rmd_get_node(df$ast, sec_refs, type_refs, name_refs)
}


#' @export
rmd_get_chunk = function(obj, sec_refs = NULL, name_refs = NULL) {
  rmd_get_node(obj, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs)
}


#' @export
rmd_get_markdown = function(obj, sec_refs = NULL) {
  rmd_get_node(obj, sec_refs = sec_refs, type_refs = "rmd_markdown")
}
