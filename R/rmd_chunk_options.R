#' @name chunk_options
#' @rdname chunk_options
#'
#' @title Get and set code chunk options
#'
#' @description Helper functions for obtaining or changing chunk options
#' within an rmd object.
#'
#' @param x An `rmd_ast`, `rmd_tibble`, or any rmd ast node object.
#' @param ... Either a collection of named values for the setter or a character values
#' of the option names for the getter.
#'
#' @return `rmd_set_options` returns the modified version of the original object.
#'
#' `rmd_get_options` returns a list of the requested options (or all options if none
#' are specified). Non-chunk nodes return `NULL`.
#'
#' @examples
#' rmd = parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
#'
#' str(rmd_get_options(rmd))
#' str(rmd_get_options(rmd), "include")
#'
#' rmd_set_options(rmd, include = TRUE)
#'
NULL

#' @rdname chunk_options
#' @export
rmd_set_options = function(x, ...) {
  UseMethod("rmd_set_options")
}

#' @exportS3Method
rmd_set_options.default = function(x, ...) {
  x
}

#' @exportS3Method
rmd_set_options.rmd_chunk = function(x, ...) {
  opts = list(...)

  if (is.null(names(opts)) | any(names(opts) == ""))
    stop("All options must be named", call. = FALSE)

  for(i in seq_along(opts)) {
    x[["options"]][[ names(opts)[i] ]] = opts[[i]]
  }

  x
}

#' @exportS3Method
rmd_set_options.rmd_ast = function(x, ...) {
  ast = purrr::map(x, rmd_set_options, ...)

  class(ast) = c("rmd_ast", "list")
  ast
}

#' @exportS3Method
rmd_set_options.rmd_tibble = function(x, ...) {
  x$ast = rmd_set_options.rmd_ast(x$ast, ...)

  x
}




#' @rdname chunk_options
#' @export
rmd_get_options = function(x, ...) {
  UseMethod("rmd_get_options")
}

#' @exportS3Method
rmd_get_options.default = function(x, ...) {
  NULL
}

#' @exportS3Method
rmd_get_options.rmd_chunk = function(x, ...) {
  opts = unlist(list(...))

  if (length(opts) == 0)
    x[["options"]]
  else
    x[["options"]][ opts ]
}

#' @exportS3Method
rmd_get_options.rmd_ast = function(x, ...) {
  opts = unlist(list(...))

  purrr::map(x, rmd_get_options, opts)
}

#' @exportS3Method
rmd_get_options.rmd_tibble = function(x, ...) {
  rmd_get_options.rmd_ast(x$ast, ...)
}


