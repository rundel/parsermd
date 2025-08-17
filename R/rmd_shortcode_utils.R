#' Shortcode detection and extraction utilities
#'
#' @description Functions for detecting and extracting shortcodes from AST nodes
#' after the initial parsing phase.
#'
#' @param x An AST node, list of nodes, or character vector
#' @param func_name character vector, optional glob patterns for matching shortcode function names.
#' If NULL (default), matches any shortcode.
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
  purrr::map_lgl(x@nodes, rmd_has_shortcode, func_name = func_name)
}

#' @export
rmd_has_shortcode.default = function(x, func_name = NULL) {
  # Search for shortcode patterns in text content using flatten=TRUE to get direct list
  shortcodes = rmd_extract_shortcodes(x, flatten = TRUE)

  if (length(shortcodes) == 0) {
    return(FALSE)
  }
  
  if (is.null(func_name)) {
    return(TRUE)
  }
  
  shortcode_funcs = purrr::map_chr(shortcodes, "func")
  any(purrr::map_lgl(utils::glob2rx(func_name), ~any( grepl(.x, shortcode_funcs) )))
}


#' @exportS3Method
print.rmd_shortcode = function(x, ...) {
  # Build the shortcode representation
  func_name = cli::col_blue(cli::style_bold(x@func))
  
  if (length(x@args) == 0) {
    args_text = ""
  } else {
    args_colored = cli::col_green(x@args)
    args_text = paste0(" ", paste(args_colored, collapse = " "))
  }
  
  # Check if start/length attributes exist
  has_position = !is.null(attr(x, "start")) || !is.null(attr(x, "length"))
  
  if (has_position) {
    start_val = attr(x, "start") %||% "NA"
    length_val = attr(x, "length") %||% "NA"
    position_text = cli::col_grey(paste0("[", start_val, ",", length_val, "]"))
  } else {
    position_text = ""
  }
  
  # Output the formatted shortcode
  cli::cat_line(" rmd_shortcode", position_text, " {{< ", func_name, args_text, " >}}")
  
  invisible(x)
}

#' @exportS3Method
str.rmd_shortcode = function(object, ...) {
  print.rmd_shortcode(object, ...)
}

#' @rdname shortcode_utils
#' @param flatten Return a flat list shortcodes if `TRUE`
#' @export
rmd_extract_shortcodes = function(x, flatten = FALSE) {
  UseMethod("rmd_extract_shortcodes")
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_ast = function(x, flatten = FALSE) {
  res = purrr::map(x@nodes, rmd_extract_shortcodes, flatten = flatten)
  
  if (flatten) {
    res |> purrr::flatten()
  } else {
    res
  }
}

#' @export
rmd_extract_shortcodes.numeric = function(x, flatten = FALSE) {
  list()
}

#' @export
rmd_extract_shortcodes.character = function(x, flatten = FALSE) {
  res = purrr::map(x, parse_shortcodes_cpp) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    res |> stats::setNames(names(x))
  }
}

#' @export
rmd_extract_shortcodes.default = function(x, flatten = FALSE) {
  # For lists and vectors that can be mapped over
  if (is.list(x) || is.vector(x)) {
    res = purrr::map(x, rmd_extract_shortcodes, flatten = flatten)
    
    if (flatten) {
      res |> purrr::flatten()
    } else {
      nm = names(x)
      if (is.null(nm) && is.list(x)) {
        nm = purrr::map_chr(x, class) 
      }
      res |> stats::setNames(nm)
    }
  } else {
    # For other types, return empty list
    if (flatten) {
      list()
    } else {
      list(list())
    }
  }
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_yaml = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@yaml, flatten = flatten)
  if (flatten) res else list(yaml = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_markdown = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@lines, flatten = flatten)
  if (flatten) res else list(lines = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_chunk = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@code, flatten = flatten)
  if (flatten) res else list(code = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_raw_chunk = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@code, flatten = flatten)
  if (flatten) res else list(code = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_code_block = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@code, flatten = flatten)
  if (flatten) res else list(code = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_code_block_literal = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@code, flatten = flatten)
  if (flatten) res else list(code = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_heading = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@name, flatten = flatten)
  if (flatten) res else list(name = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_span = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@text, flatten = flatten)
  if (flatten) res else list(text = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_shortcode = function(x, flatten = FALSE) {
  res = rmd_extract_shortcodes(x@args, flatten = flatten)
  if (flatten) res else list(args = res)
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_inline_code = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_fenced_div_open = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_shortcodes.rmd_fenced_div_close = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}
