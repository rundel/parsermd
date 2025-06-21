#' Shortcode detection and extraction utilities
#'
#' @description Functions for detecting and extracting shortcodes from AST nodes
#' after the initial parsing phase.
#'
#' @param x An AST node or list of nodes
#' @param func_name Optional character vector of function names to match (supports glob patterns)
#'
#' @return 
#' - `rmd_has_shortcode()`: logical vector indicating which nodes contain shortcodes
#' - `rmd_get_shortcodes()`: list of shortcode objects found in the text
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
  # Search for shortcode patterns in text content
  shortcodes = rmd_extract_shortcodes(x)
  
  if (length(shortcodes) == 0) {
    return(FALSE)
  }
  
  if (is.null(func_name)) {
    return(TRUE)
  }
  
  # Check if any shortcode matches the function name pattern
  shortcode_funcs = purrr::map_chr(shortcodes, "func")
  regex = utils::glob2rx(func_name)
  matching = purrr::map(regex, grepl, x = shortcode_funcs) %>%
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
  # YAML blocks cannot contain shortcodes
  FALSE
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

#' @rdname shortcode_utils
#' @export
rmd_extract_shortcodes = function(text) {
  if (length(text) == 0 || all(is.na(text))) {
    return(list())
  }
  
  # Combine all text into a single string
  full_text = paste(text, collapse = "\n")
  
  # Use the C++ parser instead of regex approach
  shortcodes = check_string_shortcodes_parser(full_text)
  
  return(shortcodes)
}

