#' @export
as_ast = function(obj, ...) {
  UseMethod("as_ast")
}

#' @export
as_ast.default = function(obj, ...) {
  stop("Unsupports type: ", class(obj))
}

#' @export
as_ast.rmd_tibble = function(df) {
  df$ast
}
