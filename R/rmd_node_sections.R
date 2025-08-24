#' @title Find the sections for each rmd object node
#'
#' @description
#' Uses the section headings of an rmd object to identify the hierarchical
#' structure of the document.
#'
#' @return A list of section names for each node.
#'
#' @param x An rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param levels Limit which section heading levels to return.
#' @param drop_na Should `NA` sections be dropped.
#'
#' @export
rmd_node_sections = function(x, levels = 1:6, drop_na = FALSE) {
  if (inherits(x, "rmd_tibble"))
    x = as_ast(x)

  checkmate::assert_class(x, "rmd_ast")
  checkmate::assert_integer(levels, lower = 1, upper = 6, sorted = TRUE,
                            min.len = 1, max.len = 6, unique = TRUE)

  sections = list()
  labels = rep(NA_character_, 6)
  names(labels) = paste0("sec_h", 1:6)

  min_level = 6
  max_level = 1

  # Pre-process fenced div pairs to ensure they get consistent section assignment
  fdiv_pairs = find_fenced_div_pairs(x@nodes)
  
  # Create a set of positions that are inside fenced divs
  positions_inside_fdivs = create_fdiv_inside_positions(fdiv_pairs)
  
  for(j in seq_along(x@nodes)) {
    node = x@nodes[[j]]
    if (inherits(node, "rmd_heading")) {
      # Only update section hierarchy for headings NOT inside fenced divs
      if (!j %in% positions_inside_fdivs) {
        labels[node@level:6] = NA_character_
        labels[node@level] = node@name

        max_level = max(max_level, node@level)
        min_level = min(min_level, node@level)
      }
    }

    sections[[length(sections)+1]] = labels
  }
  
  # Post-process to fix fenced div pair section assignments
  sections = fix_fenced_div_sections(sections, x@nodes, fdiv_pairs)

  # Handle the case where there are no headings
  if (min_level == max(levels) & max_level == min(levels))
    min_level = max_level = 0

  levels = levels[levels %in% (min_level:max_level)]

  sections = purrr::map(sections, ~ .x[levels])

  if (drop_na)
    sections = purrr::map(sections, ~ .x[!is.na(.x)])

  sections
}

#' Create set of positions inside fenced divs
#' @param fdiv_pairs Numeric vector of fenced div pairs from find_fenced_div_pairs()
#' @return Set of position indices that are inside fenced divs
#' @noRd
create_fdiv_inside_positions = function(fdiv_pairs) {
  positions = integer(0)
  
  # fdiv_pairs is a numeric vector where index is open position, value is close position
  open_positions = which(!is.na(fdiv_pairs))
  
  for (open_pos in open_positions) {
    close_pos = fdiv_pairs[open_pos]
    # Include all positions between open and close (exclusive of open/close themselves)
    if (close_pos > open_pos + 1) {
      inside_positions = (open_pos + 1):(close_pos - 1)
      positions = c(positions, inside_positions)
    }
  }
  
  unique(positions)
}

#' Find fenced div open/close pairs
#' @param x List of rmd nodes or rmd_ast object
#' @return Numeric vector of positions, index is the open position value is the close position
#' @noRd
find_fenced_div_pairs = function(x) {
  if (S7::S7_inherits(x, rmd_ast)) {
    x = x@nodes
  }

  if (length(x) == 0) return(list())
  
  pairs = rep(NA, length(x))  # To store pairs of positions
  stack = integer(0)  # Stack to track open positions
  
  for (i in seq_along(x)) {
    node = x[[i]]
    
    if (S7::S7_inherits(node, rmd_fenced_div_open)) {
      stack = c(stack, i)  # Push open position onto stack
    } else if (S7::S7_inherits(node, rmd_fenced_div_close)) {
      if (length(stack) > 0) {
        # Pop the most recent open position
        open_pos = stack[length(stack)]
        stack = stack[-length(stack)]
        
        # Record the pair
        pairs[open_pos] = i
      }
    }
  }
  
  pairs
}

#' Fix section assignments for fenced div pairs
#' @param sections List of section assignments (one per node)
#' @param nodes List of rmd nodes
#' @param fdiv_pairs Numeric vector of fenced div pairs from find_fenced_div_pairs()
#' @return Modified sections list with balanced fenced div assignments
#' @noRd
fix_fenced_div_sections = function(sections, nodes, fdiv_pairs) {
  if (length(fdiv_pairs) == 0) return(sections)
  
  # fdiv_pairs is a numeric vector where index is open position, value is close position
  open_positions = which(!is.na(fdiv_pairs))
  
  for (open_pos in open_positions) {
    close_pos = fdiv_pairs[open_pos]
    
    # Find the dominant section among the wrapped content
    # (excluding the open/close tags themselves)
    if (close_pos > open_pos + 1) {
      # There is content between open and close
      content_indices = (open_pos + 1):(close_pos - 1)
      content_sections = sections[content_indices]
      
      # Find the most common section assignment among content nodes
      # This handles cases where content spans multiple sections
      section_counts = table(sapply(content_sections, function(s) {
        # Convert section list to string for counting
        paste(s[!is.na(s)], collapse = " > ")
      }))
      
      if (length(section_counts) > 0) {
        dominant_section_str = names(section_counts)[which.max(section_counts)]
        
        # Find a content node with this section assignment to copy from
        for (i in content_indices) {
          current_section_str = paste(sections[[i]][!is.na(sections[[i]])], collapse = " > ")
          if (current_section_str == dominant_section_str) {
            # Assign this section to both open and close
            sections[[open_pos]] = sections[[i]]
            sections[[close_pos]] = sections[[i]]
            break
          }
        }
      }
    } else {
      # No content between open and close (empty fenced div)
      # Assign the close tag's current section to the open tag
      sections[[open_pos]] = sections[[close_pos]]
    }
  }
  
  sections
}
