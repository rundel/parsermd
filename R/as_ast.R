#' @title Convert an object into an `rmd_ast`.
#'
#' @description
#' Currently only supports conversion of `rmd_tibble`s.
#'
#' @param x Object to convert
#'
#' @examples
#' parse_rmd(system.file("hw01.Rmd", package="parsermd")) %>%
#'   as_tibble() %>%
#'   as_ast()
#'
#' @export
as_ast = function(x, ...) {
  UseMethod("as_ast")
}

#' @rdname as_ast
#' @export
as_ast.default = function(x, ...) {
  stop("Unsupported class: ", paste0(class(x), collapse = ", "))
}

#' @rdname as_ast
#' @export
as_ast.rmd_tibble = function(x, ...) {
  x$ast
}
