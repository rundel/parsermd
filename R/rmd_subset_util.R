#' @name rmd_subset_util
#' @rdname rmd_subset_util
#' @title rmd_subset utility functions
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' Tools for selecting or checking a single node using [rmd_subset()] selection.
#'
#' @return
#' * `rmd_get_*()` functions returns a single Rmd node object (e.g. `rmd_heading`, `rmd_chunk`, `rmd_markdown`, etc.)
#'
#' * `rmd_has_*()` functions return `TRUE` if a matching node exists, `FALSE` otherwise.
#'
#' @inheritParams rmd_subset
#'
NULL

#' @rdname rmd_subset_util
#' @export
rmd_get_node = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_node()", "rmd_select()")

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

#' @rdname rmd_subset_util
#' @export
rmd_get_chunk = function(x, sec_refs = NULL, name_refs = NULL) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_chunk()", "rmd_select()")
  rmd_get_node(x, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs)
}

#' @rdname rmd_subset_util
#' @export
rmd_get_markdown = function(x, sec_refs = NULL) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_chunk()", "rmd_select()")
  rmd_get_node(x, sec_refs = sec_refs, type_refs = "rmd_markdown")
}





#' @rdname rmd_subset_util
#' @export
rmd_has_node = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_chunk()", "rmd_select()")
  UseMethod("rmd_has_node")
}

#' @exportS3Method
rmd_has_node.default = function(x, ...) {
  stop("Unable to subset an object with class: ", class(x))
}

#' @exportS3Method
rmd_has_node.rmd_ast = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  subset = comb_subset(x, sec_refs, type_refs, name_refs, combine = `|`, inc_parents = FALSE)
  any(subset)
}

#' @exportS3Method
rmd_has_node.rmd_tibble = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
  rmd_has_node(x$ast, sec_refs, type_refs, name_refs, ...)
}

#' @rdname rmd_subset_util
#' @export
rmd_has_chunk = function(x, sec_refs = NULL, name_refs = NULL, ...) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_chunk()", "rmd_select()")
  rmd_has_node(x, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs, ...)
}

#' @rdname rmd_subset_util
#' @export
rmd_has_markdown = function(x, sec_refs = NULL, ...) {
  lifecycle::deprecate_soft("0.1.0", "rmd_get_chunk()", "rmd_select()")
  rmd_has_node(x, sec_refs = sec_refs, type_refs = "rmd_markdown", ...)
}
