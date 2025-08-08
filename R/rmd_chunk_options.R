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
#' @param defaults A named list of default values for the options.
#'
#' @return `rmd_set_options` returns the modified version of the original object.
#'
#' `rmd_get_options` returns a list of the requested options (or all options if none
#' are specified). Non-chunk nodes return `NULL`.
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))
#'
#' str(rmd_get_options(rmd))
#' str(rmd_get_options(rmd), "include")
#'
#' rmd_set_options(rmd, include = TRUE)
#'
NULL


normalize_option_names = function(names) {
  # Convert YAML-style names (dashes) to traditional names (dots)
  gsub("-", ".", names, fixed = TRUE)
}

yamlize_option_names = function(names) {
  # Convert traditional names (dots) to YAML-style names (dashes)
  gsub(".", "-", names, fixed = TRUE)
}

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

  # Normalize option names (replace - with .) before setting
  normalized_names = normalize_option_names(names(opts))
  
  for(i in seq_along(opts)) {
    x@options[[ normalized_names[i] ]] = opts[[i]]
  }

  x
}

#' @exportS3Method
rmd_set_options.rmd_ast = function(x, ...) {
  x@nodes = purrr::map(x@nodes, rmd_set_options, ...)
  x
}

#' @exportS3Method
rmd_set_options.rmd_tibble = function(x, ...) {
  # Convert to AST, modify it, then convert back to tibble
  modified_ast = rmd_set_options(as_ast(x), ...)
  as_tibble(modified_ast)
}




#' @rdname chunk_options
#' @export
rmd_get_options = function(x, ..., defaults = list()) {
  UseMethod("rmd_get_options")
}

#' @exportS3Method
rmd_get_options.default = function(x, ..., defaults = list()) {
  NULL
}

#' @exportS3Method
rmd_get_options.rmd_chunk = function(x, ..., defaults = list()) {
  opts = unlist(list(...))

  chunk_opts = x@options

  if (length(opts) == 0) {
    chunk_opts
  } else {
    checkmate::assert_character(opts, any.missing = FALSE)

    # Normalize option names (replace - with .) before lookup
    normalized_opts = normalize_option_names(opts)
    
    res = purrr::map(
      normalized_opts, ~ chunk_opts[[ .x ]] %||% defaults[[ .x ]]
    )
    names(res) = opts  # Keep original names in result
    res
  }
}

#' @exportS3Method
rmd_get_options.rmd_ast = function(x, ..., defaults = list()) {
  purrr::map(x@nodes, rmd_get_options, ..., defaults = defaults)
}

#' @exportS3Method
rmd_get_options.rmd_tibble = function(x, ..., defaults = list()) {
  rmd_get_options(as_ast(x), ..., defaults = defaults)
}


