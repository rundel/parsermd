#' @name rmd_select
#' @rdname rmd_select
#'
#' @title Select nodes of an Rmd ast
#'
#' @description This function is implemented using [tidyselect::eval_select()] which enables
#' a variety of useful syntax for selecting nodes from the ast.
#'
#' Additionally, a number of `parsermd` helpers are available:
#' [by_section()], [has_type()], [has_label()], and [has_option()].
#'
#' @param x Rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param ... One or more unquoted expressions separated by commas. Chunk labels can be used
#' as if they were positions in the data frame, so expressions like x:y can be used to
#' select a range of nodes.
#' @param keep_yaml Logical, whether to automatically include YAML nodes in the selection.
#' If `TRUE` (default), equivalent to including `has_type("rmd_yaml")` in the selection.
#'
#' @return Returns a subset Rmd object (either `rmd_ast` or `rmd_tibble` depending on input).
#'
#' @seealso [rmd_select_helpers] for helper functions to use with `rmd_select()`, including [by_section()], [has_type()], [has_label()], and [has_option()].
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
#'
#' rmd_select(rmd, "plot-dino", "cor-dino")
#' rmd_select(rmd, "plot-dino":"cor-dino")
#' rmd_select(rmd, `plot-dino`:`cor-dino`)
#'
#' rmd_select(rmd, has_type("rmd_chunk"))
#'
#' rmd_select(rmd, by_section(c("Exercise *", "Solution")))
#'
#' @export
#'
rmd_select = function(x, ..., keep_yaml = TRUE) {
  UseMethod("rmd_select")
}

#' @exportS3Method
rmd_select.default = function(x, ..., keep_yaml = TRUE) {
  stop("Unsupported type")
}


rmd_select_impl = function(x, ..., keep_yaml = TRUE) {
  checkmate::assert_class(x, "rmd_ast")
  checkmate::assert_logical(keep_yaml, len = 1, any.missing = FALSE)

  nodes = stats::setNames(x@nodes, rmd_node_label(x))
  
  # Check if we have any selection expressions
  dots = rlang::enquos(...)
  if (length(dots) > 0) {
    loc = tidyselect::eval_select(rlang::expr(c(...)), nodes)
  } else {
    loc = integer(0)
  }
  
  # Add YAML nodes if keep_yaml is TRUE
  if (keep_yaml) {
    yaml_indices = which(rmd_node_type(x) == "rmd_yaml")
    loc = c(loc, yaml_indices)
  }

  sort(unique(loc)) # maintain original order and remove duplicates
}

#' @exportS3Method
rmd_select.rmd_tibble = function(x, ..., keep_yaml = TRUE) {
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0)
    stop("The following columns must be renamed: ", bad_cols, call. = FALSE)

  x_ast = as_ast(x)
  loc = rmd_select_impl(x_ast, ..., keep_yaml = keep_yaml)

  x = x[loc,]

  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(as_ast(x))),  # add new sec_h* columns
    dplyr::select(x, -dplyr::starts_with("sec_h")) # drop old sec_h* columns
  )
  class(x) = c("rmd_tibble", class(x))

  x
}

#' @exportS3Method
rmd_select.rmd_ast = function(x, ..., keep_yaml = TRUE) {
  loc = rmd_select_impl(x, ..., keep_yaml = keep_yaml)
  x@nodes = x@nodes[loc]

  x
}

#' @exportS3Method
rmd_select.rmd_collection = function(x, ..., keep_yaml = TRUE) {
  x$ast = purrr::map(x$ast, rmd_select, ..., keep_yaml = keep_yaml)
  x
}

#' @exportS3Method
rmd_select.qmd_collection = function(x, ..., keep_yaml = TRUE) {
  rmd_select.rmd_collection(x, ..., keep_yaml = keep_yaml)
}
