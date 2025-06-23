#' Shortcode detection and extraction utilities
#'
#' @description Functions for detecting and extracting shortcodes from AST nodes
#' after the initial parsing phase.
#'
#' @param x An AST node, list of nodes, or character vector
#' @param func_name Optional character vector of function names to match (supports regex patterns)
#'
#' @return 
#' - `rmd_has_shortcode()`: logical vector indicating which nodes contain shortcodes
#' - `rmd_extract_shortcodes()`: list of shortcode objects found in the content
#'
#' @name shortcode_utils
NULL

#' @rdname shortcode_utils
#' @export
rmd_has_shortcode = function(x, func_name = NULL) {
  UseMethod("rmd_has_shortcode")
}

#' @export
rmd_has_shortcode.rmd_ast = function(x, func_name = NULL) {
  purrr::map_lgl(x, rmd_has_shortcode, func_name = func_name)
}

#' @export
rmd_has_shortcode.rmd_tibble = function(x, func_name = NULL) {
  rmd_has_shortcode(as_ast(x), func_name = func_name)
}

#' @export
rmd_has_shortcode.rmd_markdown = function(x, func_name = NULL) {
  # x is a list of rmd_markdown_line objects
  any(purrr::map_lgl(x, rmd_has_shortcode, func_name = func_name))
}

#' @export
rmd_has_shortcode.rmd_markdown_line = function(x, func_name = NULL) {
  # Check if any element in the markdown line contains shortcodes
  # x is a list of character strings, inline code, or shortcode objects
  any(purrr::map_lgl(x, rmd_has_shortcode, func_name = func_name))
}

#' @export
rmd_has_shortcode.character = function(x, func_name = NULL) {
  # Search for shortcode patterns in text content using flatten=TRUE to get direct list
  shortcodes = rmd_extract_shortcodes(x, flatten = TRUE)
  
  if (length(shortcodes) == 0) {
    return(FALSE)
  }
  
  if (is.null(func_name)) {
    return(TRUE)
  }
  
  # Check if any shortcode matches the function name pattern
  shortcode_funcs = purrr::map_chr(shortcodes, "func")
  regex = utils::glob2rx(func_name)
  matching = purrr::map(regex, grepl, x = shortcode_funcs) |>
    purrr::reduce(`|`)
  
  any(matching)
}

#' @export
rmd_has_shortcode.rmd_chunk = function(x, func_name = NULL) {
  # Check code content for shortcodes
  code_text = paste(x$code, collapse = "\n")
  rmd_has_shortcode(code_text, func_name = func_name)
}

#' @export
rmd_has_shortcode.rmd_yaml = function(x, func_name = NULL) {
  # Check YAML values for shortcodes (shortcodes can be in quoted values)
  yaml_values = unlist(x, recursive = TRUE)
  if (length(yaml_values) == 0) {
    return(FALSE)
  }
  
  # Check each YAML value for shortcodes
  any(purrr::map_lgl(yaml_values, rmd_has_shortcode, func_name = func_name))
}

#' @export
rmd_has_shortcode.rmd_shortcode = function(x, func_name = NULL) {
  # If the node itself is a shortcode, check if it matches
  if (is.null(func_name)) {
    return(TRUE)
  }
  
  regex = utils::glob2rx(func_name)
  matching = purrr::map_lgl(regex, grepl, x = x$func)
  any(matching)
}

#' @export
rmd_has_shortcode.default = function(x, func_name = NULL) {
  # Default case - most AST nodes don't contain shortcodes
  FALSE
}


#' @exportS3Method
print.rmd_shortcode = function(object, ...) {
  # Build the shortcode representation
  func_name = cli::col_blue(cli::style_bold(object$func))
  
  if (length(object$args) == 0) {
    args_text = ""
  } else {
    args_colored = cli::col_green(object$args)
    args_text = paste0(" ", paste(args_colored, collapse = " "))
  }
  
  # Check if start/length attributes exist
  has_position = !is.null(attr(object, "start")) || !is.null(attr(object, "length"))
  
  if (has_position) {
    start_val = attr(object, "start") %||% "NA"
    length_val = attr(object, "length") %||% "NA"
    position_text = cli::col_grey(paste0("[", start_val, ",", length_val, "]"))
  } else {
    position_text = ""
  }
  
  # Output the formatted shortcode
  cli::cat_line(" rmd_shortcode", position_text, " {{< ", func_name, args_text, " >}}")
  
  invisible(object)
}

#' @exportS3Method
str.rmd_shortcode = function(x, ...) {
  print.rmd_shortcode(x, ...)
}

#' @rdname shortcode_utils
#' @param flatten Return a flat list shortcodes if `TRUE`
#' @export
rmd_extract_shortcodes = function(x, flatten = FALSE) {
  UseMethod("rmd_extract_shortcodes")
}

#' @export
rmd_extract_shortcodes.numeric = function(x, flatten = FALSE) {
  list()
}

#' @export
rmd_extract_shortcodes.character = function(x, flatten = FALSE) {
  res = purrr::map(x, check_string_shortcodes_parser) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    res |> setNames(names(x))
  }
}

#' @export
rmd_extract_shortcodes.default = function(x, flatten = FALSE) {
  res = purrr::map(x, rmd_extract_shortcodes, flatten = flatten)
  
  if (flatten) {
    res |> purrr::flatten()
  } else {
    nm = names(x)
    if (is.null(nm) && (!inherits(x, "list") || inherits(x, "rmd_ast"))) {
      nm = purrr::map_chr(x, class) 
    }
    res |> setNames(nm)
  }
}