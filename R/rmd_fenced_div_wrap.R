#' @name rmd_fenced_div_wrap
#' @rdname rmd_fenced_div_wrap
#'
#' @title Wrap selected nodes with fenced divs
#'
#' @description This function wraps selected nodes in an `rmd_ast` with fenced div
#' opening and closing tags. The selection is implemented using the same approach 
#' as [rmd_select()] which enables a variety of useful syntax for selecting nodes.
#' 
#' The function checks if the selected indices form a single continuous range. If this
#' is not the case then an error will be thrown. If wrapping multiple discontinous ranges
#' of nodes is desired then the `allow_multiple` can be set to `TRUE`.
#'
#' @param x Rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param ... One or more unquoted expressions separated by commas for node selection.
#'   Uses the same syntax as [rmd_select()].
#' @param open An `rmd_fenced_div_open` node that defines the opening fenced div.
#'   Defaults to `rmd_fenced_div_open()`.
#' @param allow_multiple Logical. If `FALSE` (default), throws an error when 
#'   selected indices are discontinuous. If `TRUE`, allows wrapping multiple 
#'   discontinuous ranges separately.
#'
#' @return Returns the modified Rmd object with selected nodes wrapped in the fenced div(s).
#'
#' @examples
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package = "parsermd"))
#'
#' rmd_fenced_div_wrap(rmd, "plot-dino":"cor-dino")
#'
#' rmd_fenced_div_wrap(rmd, has_type("rmd_chunk"), allow_multiple=TRUE)
#' 
#' rmd_fenced_div_wrap(
#'   rmd, has_type("rmd_chunk"),
#'   open = rmd_fenced_div_open(classes = ".note"),
#'   allow_multiple = TRUE
#' )
#'
#' @export
#'
rmd_fenced_div_wrap = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  UseMethod("rmd_fenced_div_wrap")
}

#' @exportS3Method
rmd_fenced_div_wrap.default = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  classes = paste(class(x), collapse = ", ")
  cli::cli_abort("This function does not support class: {classes}")
}


# Helper function to detect continuous ranges in a vector of indices
detect_continuous_ranges = function(x) {
  if (length(x) == 0) return(list())
  
  x = sort(x)
  id = cumsum(c(1, diff(x)) > 1)
  ranges = tapply(x, id, c)
  
  # Convert to same format as original: list of c(start, end) vectors
  unname(lapply(ranges, function(r) c(min(r), max(r))))
}


# Helper function to check if indices form a single continuous range
is_continuous_range = function(indices) {
  if (length(indices) <= 1) return(TRUE)
  
  indices = sort(unique(indices))
  expected = seq(from = min(indices), to = max(indices), by = 1)
  length(indices) == length(expected) && all(indices == expected)
}

# Helper function to format error message for discontinuous ranges
format_range_error = function(ranges, indices, action = "wrap multiple ranges separately") {
  range_descriptions = purrr::map_chr(ranges, function(r) {
    if (r[1] == r[2]) {
      as.character(r[1])
    } else {
      paste0(r[1], "-", r[2])
    }
  })
  
  cli::format_inline(
    "Selected indices are discontinuous: [{paste(indices, collapse = ', ')}]. ",
    "Found {cli::no(length(ranges))} separate range{?s}: {paste(range_descriptions, collapse = ', ')}. ",
    "Either modify your selection to be continuous or use {.code allow_multiple = TRUE} ",
    "to {action}."
  )
}

# Helper function to insert nodes at specific positions
insert_nodes_at_positions = function(nodes, insertions) {
  # insertions should be a list of lists: list(position = pos, nodes = list_of_nodes)
  # Sort by position in descending order to avoid index shifting
  insertions = insertions[order(sapply(insertions, function(x) x$position), decreasing = TRUE)]
  
  for (insertion in insertions) {
    pos = insertion$position
    new_nodes = insertion$nodes
    
    if (pos == 0) {
      # Insert at beginning
      nodes = c(new_nodes, nodes)
    } else if (pos >= length(nodes)) {
      # Insert at end
      nodes = c(nodes, new_nodes)
    } else {
      # Insert in middle
      nodes = c(nodes[1:pos], new_nodes, nodes[(pos + 1):length(nodes)])
    }
  }
  
  nodes
}


#' @exportS3Method
rmd_fenced_div_wrap.rmd_ast = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  checkmate::assert_class(x, "rmd_ast")
  if (!S7::S7_inherits(open, rmd_fenced_div_open)) {
    cli::cli_abort("{.arg open} must be an {.cls rmd_fenced_div_open} object")
  }
  checkmate::assert_logical(allow_multiple, len = 1, any.missing = FALSE)
  
  # Capture selection arguments without evaluation
  dots = rlang::enquos(...)
  
  # Get selected indices using the same logic as rmd_select
  if (length(dots) > 0) {
    nodes = stats::setNames(x@nodes, rmd_node_label(x))
    loc = tidyselect::eval_select(rlang::expr(c(!!!dots)), nodes)
    loc = sort(unique(loc))
  } else {
    loc = integer(0)
  }
  
  # Early return if no selection
  if (length(loc) == 0) {
    return(x)
  }
  
  # Detect ranges
  ranges = detect_continuous_ranges(loc)
  
  # Check if we need to handle discontinuous ranges
  if (length(ranges) > 1 && !allow_multiple) {
    cli::cli_abort(format_range_error(ranges, loc))
  }
  
  # Prepare insertions - process ranges in reverse order to avoid index shifting issues
  insertions = list()
  
  # Process ranges in reverse order to avoid index shifting
  for (i in rev(seq_along(ranges))) {
    range = ranges[[i]]
    start_pos = range[1]
    end_pos = range[2]
    
    # Create closing div that matches the opening div structure
    close = rmd_fenced_div_close()
    
    # Insert closing div after end_pos first (since we're going in reverse order)
    insertions = append(insertions, list(list(
      position = end_pos,
      nodes = list(close)
    )))
    
    # Insert opening div before start_pos
    insertions = append(insertions, list(list(
      position = start_pos - 1,
      nodes = list(open)
    )))
  }
  
  # Apply insertions (they're already in the right order for processing)
  x@nodes = insert_nodes_at_positions(x@nodes, insertions)
  
  x
}

#' @exportS3Method
rmd_fenced_div_wrap.rmd_tibble = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0) {
    cli::cli_abort("The following columns must be renamed: {bad_cols}")
  }

  x_ast = as_ast(x)
  x_ast = rmd_fenced_div_wrap(x_ast, ..., open = open, allow_multiple = allow_multiple)

  # Recalculate section hierarchy
  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(x_ast)),  # add new sec_h* columns
    dplyr::select(x, -dplyr::starts_with("sec_h")) # drop old sec_h* columns
  )
  class(x) = c("rmd_tibble", class(x))

  x
}

#' @exportS3Method
rmd_fenced_div_wrap.rmd_collection = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  x$ast = purrr::map(x$ast, rmd_fenced_div_wrap, ..., open = open, allow_multiple = allow_multiple)
  x
}

#' @exportS3Method
rmd_fenced_div_wrap.qmd_collection = function(x, ..., open = rmd_fenced_div_open(), allow_multiple = FALSE) {
  rmd_fenced_div_wrap.rmd_collection(x, ..., open = open, allow_multiple = allow_multiple)
}