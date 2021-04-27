#' @rdname rmd_get_node
#' @title Extract a node from an rmd object
#' @description
#' `r lifecycle::badge('deprecated')`
#' Returns a single node using [rmd_subset] selection.
#'
#' @inheritParams rmd_subset
#' @export
rmd_get_node = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  lifecycle::deprecate_soft("0.0.2", "rmd_get_node()", "rmd_select()")

  UseMethod("rmd_get_node")
}

#' @exportS3Method
rmd_get_node.default = function(x, ...) {
  stop("Unable to subset an object with class: ", class(x))
}

#' @exportS3Method
rmd_get_node.rmd_ast = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  subset = comb_subset(x, sec_refs, type_refs, name_refs, inc_parents = FALSE, combine = `|`)

  if (sum(subset) > 1)
    stop("Multiple nodes match the given criteria.")

  if (sum(subset) == 0)
    NULL
  else
    x[[which(subset)]]
}

#' @exportS3Method
rmd_get_node.rmd_tibble = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  rmd_get_node(x$ast, sec_refs, type_refs, name_refs)
}

#' @rdname rmd_get_node
#' @export
rmd_get_chunk = function(x, sec_refs = NULL, name_refs = NULL) {
  lifecycle::deprecate_soft("0.0.2", "rmd_get_chunk()", "rmd_select()")
  rmd_get_node(x, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs)
}

#' @rdname rmd_get_node
#' @export
rmd_get_markdown = function(x, sec_refs = NULL) {
  lifecycle::deprecate_soft("0.0.2", "rmd_get_chunk()", "rmd_select()")
  rmd_get_node(x, sec_refs = sec_refs, type_refs = "rmd_markdown")
}
