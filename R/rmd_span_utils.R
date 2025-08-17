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
  # For lists and vectors that can be mapped over
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

#' @exportS3Method
rmd_extract_spans.rmd_ast = function(x, flatten = FALSE) {
  res = purrr::map(x@nodes, rmd_extract_spans, flatten = flatten)
  
  if (flatten) {
    res |> purrr::flatten()
  } else {
    res
  }
}

#' @exportS3Method
rmd_extract_spans.rmd_markdown = function(x, flatten = FALSE) {
  res = rmd_extract_spans(x@lines, flatten = flatten)
  if (flatten) res else list(lines = res)
}

#' @exportS3Method
rmd_extract_spans.rmd_heading = function(x, flatten = FALSE) {
  res = rmd_extract_spans(x@name, flatten = flatten)
  if (flatten) res else list(name = res)
}

#' @exportS3Method
rmd_extract_spans.rmd_span = function(x, flatten = FALSE) {
  res = rmd_extract_spans(x@text, flatten = flatten)
  if (flatten) res else list(text = res)
}

#' @exportS3Method
rmd_extract_spans.rmd_yaml = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_chunk = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_raw_chunk = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_code_block = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_code_block_literal = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_shortcode = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_inline_code = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_fenced_div_open = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}

#' @exportS3Method
rmd_extract_spans.rmd_fenced_div_close = function(x, flatten = FALSE) {
  if (flatten) list() else list()
}