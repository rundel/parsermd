#' @name rmd_insert
#' @rdname rmd_insert
#'
#' @title Insert nodes at specified locations
#'
#' @description This function inserts nodes into an `rmd_ast` at specified locations
#' relative to selected nodes. The selection is implemented using the same approach 
#' as [rmd_select()] which enables a variety of useful syntax for selecting nodes.
#' 
#' The function checks if the selected indices form continuous ranges and can either
#' insert before or after that range. `allow_multiple` parameter can be used to allow 
#' insertion based on multiple discontinuous ranges. 
#' 
#'
#' @param x Rmd object, e.g. `rmd_ast` or `rmd_tibble`, to insert the nodes.
#' @param ... One or more unquoted expressions separated by commas for node selection.
#'   Uses the same syntax as [rmd_select()].
#' @param nodes Nodes to insert. Can be a single rmd node object, a list of rmd node 
#'   objects, or an `rmd_ast` object.
#' @param location Character. Either "before" or "after" to specify where to insert 
#'   relative to the selected nodes. "before" inserts before the first node of each 
#'   selected range, "after" inserts after the last node of each selected range.
#' @param allow_multiple Logical. If `FALSE` (default), throws an error when 
#'   selected indices are discontinuous. If `TRUE`, allows inserting at multiple 
#'   discontinuous locations.
#'
#' @return Returns the modified Rmd object with nodes inserted at the specified locations.
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
#'
#' new_nodes = list(
#'   rmd_markdown(lines = "This is a comment"),
#'   rmd_chunk(engine = "r", code = "# New code")
#' )
#' rmd_insert(rmd, "plot-dino", nodes = new_nodes, location = "after")
#' 
#' new_heading = rmd_heading(name = "Analysis", level = 2L)
#' rmd_insert(rmd, has_type("rmd_chunk"), nodes = new_heading, 
#'            location = "before", allow_multiple = TRUE)
#'
#' rmd_insert(rmd, c(1, 3, 5), 
#'   nodes = rmd_markdown(lines = "Separator"), 
#'   location = "after", 
#'   allow_multiple = TRUE)
#'
#' @export
#'
rmd_insert = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  UseMethod("rmd_insert")
}

#' @exportS3Method
rmd_insert.default = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  classes = paste(class(x), collapse = ", ")
  cli::cli_abort("This function does not support class: {classes}")
}


# Helper function to normalize nodes input to a list of rmd_node objects
normalize_nodes = function(nodes) {
  # Handle different types of nodes input
  if (S7::S7_inherits(nodes, rmd_ast)) {
    # Extract nodes from rmd_ast object
    nodes_list = nodes@nodes
  } else if (S7::S7_inherits(nodes, rmd_node)) {
    # Single node object
    nodes_list = list(nodes)
  } else if (is.list(nodes)) {
    # List of nodes - validate each one
    nodes_list = nodes
  } else {
    cli::cli_abort("{.arg nodes} must be an {.cls rmd_node} object, a list of {.cls rmd_node} objects, or an {.cls rmd_ast} object")
  }
  
  # Validate that all items are rmd_node objects
  for (i in seq_along(nodes_list)) {
    if (!S7::S7_inherits(nodes_list[[i]], rmd_node)) {
      cli::cli_abort("All nodes must inherit from {.cls rmd_node}. Item {i} has class {.cls {class(nodes_list[[i]])}}")
    }
  }
  
  nodes_list
}



#' @exportS3Method
rmd_insert.rmd_ast = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  checkmate::assert_class(x, "rmd_ast")
  checkmate::assert_logical(allow_multiple, len = 1, any.missing = FALSE)
  
  location = match.arg(location)
  nodes = normalize_nodes(nodes)
  
  
  dots = rlang::enquos(...)
  
  # Get selected indices using the same logic as rmd_select
  if (length(dots) > 0) {
    nodes_map = stats::setNames(x@nodes, rmd_node_label(x))
    loc = tidyselect::eval_select(rlang::expr(c(!!!dots)), nodes_map)
    loc = sort(unique(loc))
  } else {
    loc = integer(0)
  }
  
  if (length(loc) == 0) {
    return(x)
  }
  
  ranges = detect_continuous_ranges(loc)
  if (length(ranges) > 1 && !allow_multiple) {
    cli::cli_abort(format_range_error(ranges, loc, "insert at multiple locations"))
  }
  

  insertions = list()
  for (i in rev(seq_along(ranges))) {
    range = ranges[[i]]
    start_pos = range[1]
    end_pos = range[2]
    
    if (location == "before") {
      insertion_pos = start_pos - 1
    } else { 
      insertion_pos = end_pos
    }
    
    insertions = append(insertions, list(list(
      position = insertion_pos,
      nodes = nodes
    )))
  }
  
  x@nodes = insert_nodes_at_positions(x@nodes, insertions)
  x
}

#' @exportS3Method
rmd_insert.rmd_tibble = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0) {
    cli::cli_abort("The following columns must be renamed: {bad_cols}")
  }

  x_ast = as_ast(x)
  x_ast = rmd_insert(x_ast, ..., nodes = nodes, location = location, allow_multiple = allow_multiple)

  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(x_ast)),
    dplyr::select(x, -dplyr::starts_with("sec_h"))
  )
  class(x) = c("rmd_tibble", class(x))

  x
}

#' @exportS3Method
rmd_insert.rmd_collection = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  x$ast = purrr::map(x$ast, rmd_insert, ..., nodes = nodes, location = location, allow_multiple = allow_multiple)
  x
}

#' @exportS3Method
rmd_insert.qmd_collection = function(x, ..., nodes, location = c("before", "after"), allow_multiple = FALSE) {
  rmd_insert.rmd_collection(x, ..., nodes = nodes, location = location, allow_multiple = allow_multiple)
}