#' @name rmd_node_utilities
#' @title rmd node utility functions
#'
#' @description Functions for extracting information for Rmd nodes.
#'
#' @returns
#'
#' * `rmd_node_label()` - returns a character vector of node labels,
#' nodes without labels return `NA`.
#'
#' * `rmd_node_label<-()` - assigns new labels to chunk nodes. For the setter, returns the modified object.
#'
#' * `rmd_node_type()` - returns a character vector of node types.
#'
#' * `rmd_node_length()` - returns an integer vector of node lengths (i.e. lines of code, lines of text, etc.),
#' nodes without a length return `NA`.
#'
#' * `rmd_node_content()` - returns a character vector of node textual content, nodes without content return `NA`.
#'
#' * `rmd_node_attr()` - returns the value of a given node attribute (S7 property), returns `NULL` if the attribute does not exist.
#'
#' * `rmd_node_engine()` - returns a character vector of chunk engines,
#' `NA` for all other node types.
#'
#' * `rmd_node_options()` - returns a list of chunk node options (named list), `NULL` for all other node types.
#'
#' * `rmd_node_options<-()` - assigns new options to chunk nodes by merging with existing options. Takes a named list of options. For the setter, returns the modified object.
#'
#' * `rmd_node_attr<-()` - assigns new attribute values to nodes. For the setter, returns the modified object.
#'
#' * `rmd_node_code()` - returns a list of chunk node code (character vector),
#' `NULL` for all other node types.
#'
#' * `rmd_node_set_label()` - pipeable version of `rmd_node_label<-()` for setting node labels.
#'
#' * `rmd_node_set_options()` - pipeable version of `rmd_node_options<-()` for setting chunk options.
#'
#' * `rmd_node_set_attr()` - pipeable version of `rmd_node_attr<-()` for setting node attributes.
#'
#' * `rmd_node_content<-()` - assigns new content to nodes. For the setter, returns the modified object.
#'
#' * `rmd_node_set_content()` - pipeable version of `rmd_node_content<-()` for setting node content.
#'
#' @param x An rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param attr Attribute name to extract or set.
#' @param value The new value to assign (for assignment functions).
#' @param ... For `rmd_node_set_options()`, named arguments that will be converted to a list of options to assign.
#'
#' @examples
#'
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package="parsermd"))
#'
#' rmd_node_label(rmd)
#' rmd_node_type(rmd)
#' rmd_node_content(rmd)
#' rmd_node_attr(rmd, "level")
#' rmd_node_engine(rmd)
#' rmd_node_options(rmd)
#' rmd_node_code(rmd)
#'
#' chunk = rmd_chunk("r", "example", code = "1 + 1")
#' rmd_node_label(chunk)
#' rmd_node_label(chunk) = "new_name"
#' rmd_node_label(chunk)
#'
#' rmd_node_options(chunk) = list(eval = FALSE, echo = TRUE)
#' rmd_node_options(chunk)
#'
#' rmd_node_attr(chunk, "engine") = "python"
#' rmd_node_attr(chunk, "engine")
#'
#' rmd_node_content(chunk) = c("x = 2", "y = 3")
#' rmd_node_content(chunk)
#'
#' chunk = rmd_chunk("r", "example", code = "1 + 1") |>
#'   rmd_node_set_label("new_label") |>
#'   rmd_node_set_options(eval = FALSE, echo = TRUE) |>
#'   rmd_node_set_content(c("a = 1", "b = 2"))
#'
#' rmd_node_label(chunk)
#' rmd_node_options(chunk)
#' rmd_node_content(chunk)
#'
#' chunk = rmd_chunk("r", "example", code = "x = 1") |>
#'   rmd_node_set_attr("engine", "python")
#'
#' rmd_node_engine(chunk)
#'
NULL

#' @rdname rmd_node_utilities
#' @export
rmd_node_label = function(x) {
  UseMethod("rmd_node_label")
}

#' @exportS3Method
rmd_node_label.rmd_ast = function(x) {
  purrr::map_chr(x@nodes, rmd_node_label)
}

#' @exportS3Method
rmd_node_label.rmd_tibble = function(x) {
  rmd_node_label(as_ast(x))
}

#' @exportS3Method
rmd_node_label.default = function(x) {
  NA_character_
}

#' @exportS3Method
rmd_node_label.rmd_chunk = function(x) {
  name = x@name

  if (name == "") {
    if (!is.null(x@options[["label"]]))
      name = x@options[["label"]]
  }

  if (is.null(name))
    name = NA_character_

  name
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_label<-` = function(x, value) {
  UseMethod("rmd_node_label<-")
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_label<-.default` = function(x, value) {
  cli::cli_abort(
    "Setting labels is not supported for objects of type {.cls {class(x)}}."
  )
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_label<-.rmd_chunk` = function(x, value) {
  checkmate::assert_string(value, na.ok = FALSE)
  x@name = value
  x
}



#' @rdname rmd_node_utilities
#' @export
rmd_node_type = function(x) {
  UseMethod("rmd_node_type")
}

#' @exportS3Method
rmd_node_type.rmd_ast = function(x) {
  purrr::map_chr(x@nodes, rmd_node_type)
}

#' @exportS3Method
rmd_node_type.rmd_tibble = function(x) {
  rmd_node_type(as_ast(x))
}

#' @exportS3Method
rmd_node_type.default = function(x) {
  class(x)[1]
}


#' @rdname rmd_node_utilities
#' @export
rmd_node_length = function(x) {
  UseMethod("rmd_node_length")
}

#' @exportS3Method
rmd_node_length.rmd_ast = function(x) {
  purrr::map_int(x@nodes, rmd_node_length)
}

#' @exportS3Method
rmd_node_length.rmd_tibble = function(x) {
  rmd_node_length(as_ast(x))
}

#' @exportS3Method
rmd_node_length.rmd_chunk = function(x) {
  length(x@code)
}

#' @exportS3Method
rmd_node_length.rmd_raw_chunk = function(x) {
  length(x@code)
}

#' @exportS3Method
rmd_node_length.rmd_markdown = function(x) {
  length(x@lines)
}

#' @exportS3Method
rmd_node_length.rmd_yaml = function(x) {
  length(x@yaml)
}

#' @exportS3Method
rmd_node_length.default = function(x) {
  NA_integer_
}




#' @rdname rmd_node_utilities
#' @export
rmd_node_content = function(x) {
  UseMethod("rmd_node_content")
}

#' @exportS3Method
rmd_node_content.default = function(x) {
  NA_character_
}

#' @exportS3Method
rmd_node_content.rmd_ast = function(x) {
  purrr::map_chr(x@nodes, rmd_node_content)
}

#' @exportS3Method
rmd_node_content.rmd_tibble = function(x) {
  rmd_node_content(as_ast(x))
}

#' @exportS3Method
rmd_node_content.rmd_chunk = function(x) {
  paste(x@code, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_raw_chunk = function(x) {
  paste(x@code, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_markdown = function(x) {
  paste(x@lines, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_code_block = function(x) {
  paste(x@code, collapse="\n")
}

#' @exportS3Method
rmd_node_content.rmd_code_block_literal = function(x) {
  paste(x@code, collapse="\n")
}








#' @rdname rmd_node_utilities
#' @export
rmd_node_attr = function(x, attr) {
  checkmate::assert_character(attr, len = 1)
  UseMethod("rmd_node_attr")
}

#' @exportS3Method
rmd_node_attr.default = function(x, attr) {
  NULL
}

#' @exportS3Method
rmd_node_attr.rmd_node = function(x, attr) {
  tryCatch(
    S7::prop(x, attr),
    error = function(e) NULL
  )
}

#' @exportS3Method
rmd_node_attr.rmd_ast = function(x, attr) {
  purrr::map(x@nodes, rmd_node_attr, attr = attr)
}

#' @exportS3Method
rmd_node_attr.rmd_tibble = function(x, attr) {
  rmd_node_attr(as_ast(x))
}



#' @rdname rmd_node_utilities
#' @export
rmd_node_engine = function(x) {
  purrr::map_chr(
    rmd_node_attr(x, "engine"), 1,
    .default = NA_character_
  )
}

#' @rdname rmd_node_utilities
#' @export
rmd_node_options = function(x) {
  rmd_node_attr(x, "options")
}

#' @rdname rmd_node_utilities
#' @export
rmd_node_code = function(x) {
  rmd_node_attr(x, "code")
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_options<-` = function(x, value) {
  UseMethod("rmd_node_options<-")
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_options<-.default` = function(x, value) {
  cli::cli_abort(
    "Setting options is only supported for objects of type {.cls rmd_chunk} this object has class {.cls {class(x)}}."
  )
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_options<-.rmd_chunk` = function(x, value) {
  checkmate::assert_list(value, names = "named")
  
  names(value) = normalize_option_names(names(value))

  # Merge new options with existing options
  x@options = utils::modifyList(x@options, value)
  x
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_attr<-` = function(x, attr, value) {
  UseMethod("rmd_node_attr<-")
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_attr<-.default` = function(x, attr, value) {
  cli::cli_abort(
    "Setting attributes is not supported for objects of type {.cls {class(x)}}."
  )
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_attr<-.rmd_node` = function(x, attr, value) {
  # Validation and existance handled by S7
  S7::prop(x, attr) = value
  x
}


#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-` = function(x, value) {
  UseMethod("rmd_node_content<-")
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.default` = function(x, value) {
  cli::cli_abort(
    "Setting content is not supported for objects of type {.cls {class(x)}}."
  )
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.rmd_chunk` = function(x, value) {
  checkmate::assert_character(value)
  x@code = value
  x
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.rmd_raw_chunk` = function(x, value) {
  checkmate::assert_character(value)
  x@code = value
  x
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.rmd_markdown` = function(x, value) {
  checkmate::assert_character(value)
  x@lines = value
  x
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.rmd_code_block` = function(x, value) {
  checkmate::assert_character(value)
  x@code = value
  x
}

#' @rdname rmd_node_utilities
#' @export
`rmd_node_content<-.rmd_code_block_literal` = function(x, value) {
  checkmate::assert_character(value)
  x@code = value
  x
}


#' @rdname rmd_node_utilities
#' @export
rmd_node_set_label = function(x, value) {
  `rmd_node_label<-`(x, value)
}

#' @rdname rmd_node_utilities
#' @export
rmd_node_set_options = function(x, ...) {
  `rmd_node_options<-`(x, list(...))
}

#' @rdname rmd_node_utilities
#' @export
rmd_node_set_content = function(x, value) {
  `rmd_node_content<-`(x, value)
}

#' @rdname rmd_node_utilities
#' @export
rmd_node_set_attr = function(x, attr, value) {
  `rmd_node_attr<-`(x, attr, value)
}


