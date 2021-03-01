#' @name rmd_node
#' @title rmd node utility functions
#'
#' @description
#'
#' `rmd_node_label()` - returns a node(s) labels.
#'
#' `rmd_node_type()` - returns node(s) type / class.
#'
#' `rmd_node_length()` - returns node(s) length (i.e. lines of code, lines of text, etc.)
#'
#' `rmd_node_content()` - returns node(s) text content.
#'
#' `rmd_node_attr()` - returns node(s) attribute value.
#'
#' `rmd_node_engine()` - returns chunk(s) engine, `NA` for all other node types.
#'
#' `rmd_node_options()` - returns chunk(s) options, `NA` for all other node types.
#'
#' `rmd_node_code()` - returns chunk(s) code, `NA` for all other node types.
#'
#' @param x An rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param attr Attribute name to extract.
#' @param ... Unused, for extensibility.
#'
NULL

#' @rdname rmd_node
#' @export
rmd_node_label = function(x, ...) {
  UseMethod("rmd_node_label")
}

#' @exportS3Method
rmd_node_label.rmd_ast = function(x, ...) {
  purrr::map_chr(x, rmd_node_label)
}

#' @exportS3Method
rmd_node_label.rmd_tibble = function(x, ...) {
  rmd_node_label(as_ast(x))
}

#' @exportS3Method
rmd_node_label.default = function(x, ...) {
  NA_character_
}

#' @exportS3Method
rmd_node_label.rmd_chunk = function(x, ...) {
  name = x[["name"]]

  if (name == "" & !is.null(x[["options"]][["label"]]))
    name = x[["options"]][["label"]]

  if (is.null(name))
    name = NA_character_

  name
}



#' @rdname rmd_node
#' @export
rmd_node_type = function(x, ...) {
  UseMethod("rmd_node_type")
}

#' @exportS3Method
rmd_node_type.rmd_ast = function(x, ...) {
  purrr::map_chr(x, rmd_node_type)
}

#' @exportS3Method
rmd_node_type.rmd_tibble = function(x, ...) {
  rmd_node_type(as_ast(x))
}

#' @exportS3Method
rmd_node_type.default = function(x, ...) {
  class(x)
}


#' @rdname rmd_node
#' @export
rmd_node_length = function(x, ...) {
  UseMethod("rmd_node_length")
}

#' @exportS3Method
rmd_node_length.rmd_ast = function(x, ...) {
  purrr::map_int(x, rmd_node_length)
}

#' @exportS3Method
rmd_node_length.rmd_tibble = function(x, ...) {
  rmd_node_length(as_ast(x))
}

#' @exportS3Method
rmd_node_length.rmd_chunk = function(x, ...) {
  length(x$code)
}

#' @exportS3Method
rmd_node_length.rmd_raw_chunk = function(x, ...) {
  length(x$code)
}

#' @exportS3Method
rmd_node_length.rmd_markdown = function(x, ...) {
  length(x)
}

#' @exportS3Method
rmd_node_length.rmd_yaml = function(x, ...) {
  length(x)
}

#' @exportS3Method
rmd_node_length.rmd_yaml_list = function(x, ...) {
  length(x)
}

#' @exportS3Method
rmd_node_length.default = function(x, ...) {
  NA_integer_
}




#' @rdname rmd_node
#' @export
rmd_node_content = function(x, ...) {
  UseMethod("rmd_node_content")
}

#' @exportS3Method
rmd_node_content.default = function(x, ...) {
  NA_character_
}

#' @exportS3Method
rmd_node_content.rmd_ast = function(x, ...) {
  purrr::map_chr(x, rmd_node_content)
}

#' @exportS3Method
rmd_node_content.rmd_tibble = function(x, ...) {
  rmd_node_content(as_ast(x))
}

#' @exportS3Method
rmd_node_content.rmd_chunk = function(x, ...) {
  paste(x$code, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_raw_chunk = function(x, ...) {
  paste(x$code, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_markdown = function(x, ...) {
  paste(x, collapse="\n")
}








#' @rdname rmd_node
#' @export
rmd_node_attr = function(x, attr, ...) {
  UseMethod("rmd_node_attr")
}

#' @exportS3Method
rmd_node_attr.default = function(x, attr, ...) {
  checkmate::assert_character(x, len = 1)

  if (is.list(x))
    x[[attr]]
  else
    NULL
}

#' @exportS3Method
rmd_node_attr.rmd_ast = function(x, attr, ...) {
  purrr::map(x, rmd_node_attr, attr = attr)
}

#' @exportS3Method
rmd_node_attr.rmd_tibble = function(x, attr, ...) {
  rmd_node_attr(as_ast(x))
}



#' @rdname rmd_node
#' @export
rmd_node_engine = function(x, ...) {
  rmd_node_attr(x, "engine")
}

#' @rdname rmd_node
#' @export
rmd_node_options = function(x, ...) {
  rmd_node_attr(x, "options")
}

#' @rdname rmd_node
#' @export
rmd_node_code = function(x, ...) {
  rmd_node_attr(x, "code")
}



