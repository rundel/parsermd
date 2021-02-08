#' @rdname rmd_has_node
#' @title Determine if an rmd object has a specific node
#' @description
#' Returns `TRUE` if the a matching node exists within the rmd object.
#'
#' @inheritParams rmd_subset
#' @export
rmd_has_node = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, ...) {
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

#' @rdname rmd_has_node
#' @export
rmd_has_chunk = function(x, sec_refs = NULL, name_refs = NULL, ...) {
  rmd_has_node(x, sec_refs = sec_refs, type_refs = "rmd_chunk", name_refs = name_refs, ...)
}

#' @rdname rmd_has_node
#' @export
rmd_has_markdown = function(x, sec_refs = NULL, ...) {
  rmd_has_node(x, sec_refs = sec_refs, type_refs = "rmd_markdown", ...)
}
