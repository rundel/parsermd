#' @name rmd_ast_append
#'
#' @title Append or preprend nodes to an ast
#'
#' @description Functions for adding nodes to the beginning or end of an ast.
#'
#' @param x An object containing an `rmd_ast` of some kind, e.g.
#' `rmd_ast`, `rmd_tibble`, or `rmd_collection`.
#' @param ... A collections of ast nodes to append or prepend.
#'
#' @return An object of the same class as `x`
#'
NULL

#' @rdname rmd_ast_append
#' @export
rmd_ast_append = function(x, ...) {
  UseMethod("rmd_ast_append")
}

#' @exportS3Method
rmd_ast_append.default = function(x, ...) {
  classes = paste(class(x), collapse = ", ")
  stop("This function does not support class: ", classes)
}

#' @exportS3Method
rmd_ast_append.rmd_ast = function(x, ...) {
  # TODO - at checkmate checks
  c(x, list(...)) %>%
    magrittr::set_class(c("rmd_ast", "list"))
}

#' @exportS3Method
rmd_ast_append.rmd_tibble = function(x, ...) {
  as_tibble(
    rmd_ast_append(as_ast(x), ...)
  )
}

#' @exportS3Method
rmd_ast_append.qmd_collection = function(x, ...) {
  x[["ast"]] = purrr::map(x[["ast"]], rmd_ast_append, ...)
  x
}

#' @exportS3Method
rmd_ast_append.rmd_collection = function(x, ...) {
  rmd_ast_append.qmd_collection(x, ...)
}



#' @rdname rmd_ast_append
#' @export
rmd_ast_prepend = function(x, ...) {
  UseMethod("rmd_ast_prepend")
}

#' @exportS3Method
rmd_ast_prepend.default = function(x, ...) {
  classes = paste(class(x), collapse = ", ")
  stop("This function does not support class: ", classes)
}

#' @exportS3Method
rmd_ast_prepend.rmd_ast = function(x, ...) {
  # TODO - at checkmate checks
  c(list(...), x) %>%
    magrittr::set_class(c("rmd_ast", "list"))
}

#' @exportS3Method
rmd_ast_prepend.rmd_tibble = function(x, ...) {
  as_tibble(
    rmd_ast_prepend(as_ast(x), ...)
  )
}

#' @exportS3Method
rmd_ast_prepend.qmd_collection = function(x, ...) {
  x[["ast"]] = purrr::map(x[["ast"]], rmd_ast_prepend, ...)
  x
}

#' @exportS3Method
rmd_ast_prepend.rmd_collection = function(x, ...) {
  rmd_ast_prepend.qmd_collection(x, ...)
}
