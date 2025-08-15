#' Span detection and extraction utilities
#'
#' @description Functions for detecting and extracting spans from AST nodes
#' after the initial parsing phase.
#'
#' @param x An AST node, list of nodes, or character vector
#' 
#' @return 
#' - `rmd_has_span()`: logical vector indicating which nodes contain spans
#' - `rmd_extract_spans()`: list of span objects found in the content
#'
#' @name span_utils
NULL

#' @rdname span_utils
#' @export
rmd_has_span = function(x) {
  UseMethod("rmd_has_span")
}

#' @export
rmd_has_span.rmd_ast = function(x) {
  purrr::map_lgl(x@nodes, rmd_has_span)
}

#' @export
rmd_has_span.character = function(x) {
  if (length(x) == 1) {
    # Single character string
    spans = rmd_extract_spans(x, flatten = TRUE)
    return(length(spans) > 0)
  } else {
    # Vector of character strings - map over each element
    return(purrr::map_lgl(x, ~{
      spans = rmd_extract_spans(.x, flatten = TRUE)
      length(spans) > 0
    }))
  }
}

#' @export
rmd_has_span.default = function(x) {
  # Search for span patterns in text content using flatten=TRUE to get direct list
  spans = rmd_extract_spans(x, flatten = TRUE)
  length(spans) > 0
}

#' @exportS3Method
print.rmd_span = function(x, ...) {
  # Build the span representation
  text = cli::col_cyan(cli::style_bold(x@text))
  
  # Format attributes
  attrs = character()
  if (length(x@id) > 0) {
    attrs = c(attrs, cli::col_blue(x@id))
  }
  if (length(x@classes) > 0) {
    attrs = c(attrs, cli::col_green(x@classes))
  }
  if (length(x@attr) > 0) {
    attr_pairs = paste0(names(x@attr), "=", x@attr)
    attrs = c(attrs, cli::col_yellow(attr_pairs))
  }
  
  if (length(attrs) > 0) {
    attrs_text = paste0("{", paste(attrs, collapse = " "), "}")
  } else {
    attrs_text = ""
  }
  
  # Output the formatted span
  cli::cat_line(" rmd_span [", text, "]", attrs_text)
  
  invisible(x)
}

#' @exportS3Method
str.rmd_span = function(object, ...) {
  print.rmd_span(object, ...)
}

#' @rdname span_utils
#' @param flatten Return a flat list of spans if `TRUE`
#' @export
rmd_extract_spans = function(x, flatten = FALSE) {
  UseMethod("rmd_extract_spans")
}

#' @export
rmd_extract_spans.numeric = function(x, flatten = FALSE) {
  list()
}

#' @export
rmd_extract_spans.character = function(x, flatten = FALSE) {
  res = purrr::map(x, parse_spans_cpp) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    res |> stats::setNames(names(x))
  }
}

#' @export
rmd_extract_spans.default = function(x, flatten = FALSE) {
  # Check if this is an S7 object that should use the S7_object method
  if (S7::S7_inherits(x, S7::S7_object)) {
    return(rmd_extract_spans.S7_object(x, flatten = flatten))
  }
  
  # For non-S7 objects that can be mapped over (like lists, vectors)
  if (is.list(x) || is.vector(x)) {
    res = purrr::map(x, rmd_extract_spans, flatten = flatten)
    
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

#' @export
rmd_extract_spans.S7_object = function(x, flatten = FALSE) {
  props = S7::prop_names(x)
  
  # Only process properties that are likely to contain spans
  # This avoids recursion through complex nested structures
  content_props = c("yaml", "lines", "code", "name", "text", "attr", "args")
  props_to_check = intersect(props, content_props)

  res = purrr::map(props_to_check, ~{
    prop_value = S7::prop(x, .x)
    # Process the property value, but only if it's character or simple list
    if (is.character(prop_value) || (is.list(prop_value) && .x == "yaml")) {
      rmd_extract_spans(prop_value, flatten = flatten)
    } else {
      if (flatten) list() else list(list())
    }
  }) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    stats::setNames(res, props_to_check)
  }
}