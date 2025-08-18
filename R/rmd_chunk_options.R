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
#' @param yaml_style logical, if `TRUE` (default) return option names in YAML style (with hyphens), if `FALSE` return normalized style (with dots)
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
#' str(rmd_get_options(rmd, "include"))
#' 
#' # Get options in YAML style (default) vs normalized style
#' chunk = rmd_chunk("r", "test", options = list(`fig-width` = 8, eval = TRUE))
#' rmd_get_options(chunk, yaml_style = TRUE)   # fig-width
#' rmd_get_options(chunk, yaml_style = FALSE)  # fig.width
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
#' @param yaml_style logical, if `TRUE` (default) return option names in YAML style (with hyphens), if `FALSE` return normalized style (with dots)
#' @export
rmd_get_options = function(x, ..., defaults = list(), yaml_style = TRUE) {
  UseMethod("rmd_get_options")
}

#' @exportS3Method
rmd_get_options.default = function(x, ..., defaults = list(), yaml_style = TRUE) {
  NULL
}

#' @exportS3Method
rmd_get_options.rmd_chunk = function(x, ..., defaults = list(), yaml_style = TRUE) {
  opts = unlist(list(...))

  chunk_opts = x@options

  if (length(opts) == 0) {
    # Return all options, converting names based on yaml_style
    if (yaml_style && !is.null(names(chunk_opts))) {
      names(chunk_opts) = yamlize_option_names(names(chunk_opts))
    }
    chunk_opts
  } else {
    checkmate::assert_character(opts, any.missing = FALSE)

    # Normalize option names (replace - with .) before lookup
    normalized_opts = normalize_option_names(opts)
    
    res = purrr::map(
      normalized_opts, ~ chunk_opts[[ .x ]] %||% defaults[[ .x ]]
    )
    # Set result names based on yaml_style preference
    if (yaml_style) {
      names(res) = opts  # Keep original names (may have hyphens)
    } else {
      names(res) = normalized_opts  # Use normalized names (with dots)
    }
    res
  }
}

#' @exportS3Method
rmd_get_options.rmd_ast = function(x, ..., defaults = list(), yaml_style = TRUE) {
  purrr::map(x@nodes, rmd_get_options, ..., defaults = defaults, yaml_style = yaml_style)
}

#' @exportS3Method
rmd_get_options.rmd_tibble = function(x, ..., defaults = list(), yaml_style = TRUE) {
  rmd_get_options(as_ast(x), ..., defaults = defaults, yaml_style = yaml_style)
}


