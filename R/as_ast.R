#' @title Convert an object into an `rmd_ast`.
#'
#' @description
#' Currently only supports conversion of `rmd_tibble` objects back to `rmd_ast`.
#'
#' @param x Object to convert
#' @param ... Unused, for extensibility.
#'
#' @examples
#' parse_rmd(system.file("examples/hw01.Rmd", package="parsermd")) %>%
#'   as_tibble() %>%
#'   as_ast()
#'
#' @return Returns an `rmd_ast` object.
#'
#' @export
as_ast = function(x, ...) {
  UseMethod("as_ast")
}

#' @exportS3Method
as_ast.default = function(x, ...) {
  stop("Unsupported class: ", paste0(class(x), collapse = ", "))
}

#' @exportS3Method
as_ast.rmd_tibble = function(x, ...) {
  x[["ast"]]
}
