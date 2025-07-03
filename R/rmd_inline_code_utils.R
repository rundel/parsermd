#' Inline code detection and extraction utilities
#'
#' @description Functions for detecting and extracting inline code chunks from AST nodes
#' after the initial parsing phase.
#'
#' @param x An AST node, list of nodes, or character vector
#' @param engine character vector, optional glob patterns for matching inline code engine names.
#' If NULL (default), matches any inline code.
#' 
#' @return 
#' - `rmd_has_inline_code()`: logical vector indicating which nodes contain inline code
#' - `rmd_extract_inline_code()`: list of inline code objects found in the content
#'
#' @name inline_code_utils
NULL

#' @rdname inline_code_utils
#' @export
rmd_has_inline_code = function(x, engine = NULL) {
  UseMethod("rmd_has_inline_code")
}

#' @export
rmd_has_inline_code.rmd_ast = function(x, engine = NULL) {
  purrr::map_lgl(x@nodes, rmd_has_inline_code, engine = engine)
}

#' @export
rmd_has_inline_code.default = function(x, engine = NULL) {
  # Search for inline code patterns in text content using flatten=TRUE to get direct list
  inline_code = rmd_extract_inline_code(x, flatten = TRUE)

  if (length(inline_code) == 0) {
    return(FALSE)
  }
  
  if (is.null(engine)) {
    return(TRUE)
  }
  
  inline_code_engines = purrr::map_chr(inline_code, "engine")
  any(purrr::map_lgl(utils::glob2rx(engine), ~any( grepl(.x, inline_code_engines) )))
}


#' @exportS3Method
print.rmd_inline_code = function(x, ...) {
  # Build the inline code representation
  engine_name = x@engine
  if (x@braced) {
    engine_name = paste0("{", engine_name, "}")
  }
  engine_name = cli::col_blue(cli::style_bold(engine_name))
  code_text = cli::col_green(x@code)
  
  # Check if start/length attributes exist
  has_position = !is.null(attr(x, "start")) || !is.null(attr(x, "length"))
  
  if (has_position) {
    start_val = attr(x, "start") %||% "NA"
    length_val = attr(x, "length") %||% "NA"
    position_text = cli::col_grey(paste0("[", start_val, ",", length_val, "]"))
  } else {
    position_text = ""
  }
  
  # Output the formatted inline code
  cli::cat_line(" rmd_inline_code", position_text, " `", engine_name, " ", code_text, "`")
  
  invisible(x)
}

#' @exportS3Method
str.rmd_inline_code = function(object, ...) {
  print.rmd_inline_code(object, ...)
}

#' @rdname inline_code_utils
#' @param flatten Return a flat list inline codes if `TRUE`
#' @export
rmd_extract_inline_code = function(x, flatten = FALSE) {
  UseMethod("rmd_extract_inline_code")
}

#' @export
rmd_extract_inline_code.numeric = function(x, flatten = FALSE) {
  list()
}

#' @export
rmd_extract_inline_code.character = function(x, flatten = FALSE) {
  res = purrr::map(x, parse_inline_code_cpp) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    res |> stats::setNames(names(x))
  }
}

#' @export
rmd_extract_inline_code.default = function(x, flatten = FALSE) {
  res = purrr::map(x, rmd_extract_inline_code, flatten = flatten)
  
  if (flatten) {
    res |> purrr::flatten()
  } else {
    nm = names(x)
    if (is.null(nm) && (!inherits(x, "list") || inherits(x, "rmd_ast"))) {
      nm = purrr::map_chr(x, class) 
    }
    res |> stats::setNames(nm)
  }
}

#' @export
rmd_extract_inline_code.rmd_chunk = function(x, flatten = FALSE) {
  props = S7::prop_names(x)

  res = purrr::map(props, ~list()) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    setNames(res, props)
  }
}

#' @export
rmd_extract_inline_code.S7_object = function(x, flatten = FALSE) {
  props = S7::prop_names(x)

  res = purrr::map(props, ~rmd_extract_inline_code(S7::prop(x, .x), flatten = flatten)) 
  
  if (flatten) {
    res |> purrr::flatten() 
  } else {
    setNames(res, props)
  }
}
