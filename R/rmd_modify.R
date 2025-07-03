#' @name rmd_modify
#' @rdname rmd_modify
#'
#' @title Modify nodes of an Rmd ast
#'
#' @description This function applies a function to selected nodes of an `rmd_ast` or `rmd_tibble`.
#' The selection is implemented using the same approach as [rmd_select()] which enables
#' a variety of useful syntax for selecting nodes from the ast.
#' 
#' The function `.f` must return a valid rmd node object (e.g., `rmd_chunk`, `rmd_heading`, etc.).
#' The results are validated to ensure they maintain the proper structure and class.
#'
#' @param x Rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param .f A function to apply to the selected nodes. Must return a valid rmd node object.
#' @param ... Selection arguments (unnamed) and function arguments (named). 
#'   Unnamed arguments are used for node selection using tidyselect syntax.
#'   Named arguments are passed to the function `.f`.
#'
#' @return Returns the modified Rmd object (either `rmd_ast` or `rmd_tibble` depending on input).
#'   Only the selected nodes are modified by applying `.f`, while unselected nodes remain unchanged.
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
#'
#' # Modify specific chunks by label
#' f = function(node) { # Add a comment to the chunk
#'   node@code = c("# Modified chunk", node@code)
#'   node
#' }
#' rmd_modify(rmd, .f = f, "plot-dino") |>
#'   rmd_select("plot-dino") |>
#'   as_document() |>
#'   cat(sep="\n")
#'
#' # Modify all chunks with named arguments passed to function
#' f = function(node, prefix = "## ") {
#'   node@code = paste0(prefix, node@code)
#'   node
#' }
#' rmd_modify(rmd, f, has_type("rmd_chunk"), prefix = "# ") |>
#'  rmd_select(has_type("rmd_chunk")) |>
#'  as_document() |>
#'  cat(sep="\n")
#' 
#' @export
#'
rmd_modify = function(x, .f, ...) {
  UseMethod("rmd_modify")
}

#' @exportS3Method
rmd_modify.default = function(x, .f, ...) {
  stop("Unsupported type")
}


selection_locs = function(x, selection_quos) {
  checkmate::assert_class(x, "rmd_ast")
  
  if (length(selection_quos) == 0) {
    # If no selection arguments, select all nodes
    seq_along(x@nodes)
  } else {
    # Use tidyselect for node selection
    nodes = setNames(x@nodes, rmd_node_label(x))
    loc = tidyselect::eval_select(rlang::expr(c(!!!selection_quos)), nodes)
    sort(loc) # maintain original order
  }
}


#' @exportS3Method
rmd_modify.rmd_ast = function(x, .f, ...) {
  checkmate::assert_function(.f)
  
  # Capture arguments without evaluation to separate selection from function args
  dots = rlang::enquos(...)
  dot_names = rlang::names2(dots)
  
  # Split dots into unnamed (selection) and named (function args)  
  selection_quos = dots[dot_names == ""]
  function_quos = dots[dot_names != ""]
  
  # Evaluate function arguments
  function_args = purrr::map(function_quos, rlang::eval_tidy)
  
  loc = selection_locs(x, selection_quos)
  
  # Apply function to selected nodes with named arguments
  modified_nodes = purrr::map(x@nodes[loc], ~do.call(.f, c(list(.x), function_args)))
  
  # Validate that all results are valid rmd nodes
  purrr::iwalk(modified_nodes, function(node, i) {
    if (!S7::S7_inherits(node, rmd_node)) {
      stop("Function must return a valid rmd node object at position ", loc[i], call. = FALSE)
    }
    # S7 validation is automatic when the object is created
  })
  
  x@nodes[loc] = modified_nodes
  
  x
}

#' @exportS3Method
rmd_modify.rmd_tibble = function(x, .f, ...) {
  checkmate::assert_function(.f)
  
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0)
    stop("The following columns must be renamed: ", bad_cols, call. = FALSE)

  x$ast = rmd_modify(x$ast, .f, ...)

  # Recalculate section hierarchy
  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(x$ast)),  # add new sec_h* columns
    dplyr::select(x, -dplyr::starts_with("sec_h")) # drop old sec_h* columns
  )
  class(x) = c("rmd_tibble", class(x))

  x
}

#' @exportS3Method
rmd_modify.rmd_collection = function(x, .f, ...) {
  x$ast = purrr::map(x$ast, rmd_modify, .f = .f, ...)
  x
}

#' @exportS3Method
rmd_modify.qmd_collection = function(x, .f, ...) {
  rmd_modify.rmd_collection(x, .f = .f, ...)
}