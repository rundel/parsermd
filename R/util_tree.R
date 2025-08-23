find_fdiv_close = function(x, start=0) {
  count = 1
  for (i in seq(start, length(x))) {
    if (S7::S7_inherits(x[[i]], rmd_fenced_div_close)) {
      count = count - 1
      if (count == 0) {
        return(i)
      }
    } else if (S7::S7_inherits(x[[i]], rmd_fenced_div_open)) {
      count = count + 1
    }
  }
}


find_depth = function(x, start_depth = 0) {

  cur_depth = start_depth
  heading_depths = rep(NA, 6)

  node_depth = rep(NA, length(x))

  i = 1
  while (i <= length(x)) {
    if (S7::S7_inherits(x[[i]], rmd_heading)) {
      level = x[[i]]@level

      #browser()
      if (!is.na(heading_depths[level])) {
        # If we have already seen this level, use the stored depth
        cur_depth = heading_depths[level]
      } else if (all(is.na(heading_depths[seq_len(level)]))) {
        # If we haven't seen any headings use start_depth
        cur_depth = start_depth
      } else {
        # If we have seen levels above, use the max of those + 1
        cur_depth = max(heading_depths[seq_len(level)], na.rm=TRUE) + 1  
      }

      heading_depths[-seq_len(level)] = NA  # Reset deeper levels
      heading_depths[level] = cur_depth
      node_depth[i] = cur_depth
      
      cur_depth = cur_depth + 1

      i = i + 1
    } else if (S7::S7_inherits(x[[i]], rmd_fenced_div_open)) {
      stopifnot(i < length(x))
      j = find_fdiv_close(x, i+1)
      
      if (i+1 == j) {
        res = integer()
      } else {
      res = find_depth(x[(i+1):(j-1)], start_depth = cur_depth+1)
      }
      node_depth[i:j] = c(cur_depth, res, cur_depth)
      
      i = j + 1
    } else {
      node_depth[i] = cur_depth
      i = i + 1
    }    
  }

  node_depth
}

#' Calculate nesting depth for each node in an R Markdown AST
#'
#' @param x An rmd_ast object
#' @return An integer vector of nesting depths (0-indexed) for each node
#' @export
rmd_node_depth = function(x) {
  if (!inherits(x, "rmd_ast")) {
    cli::cli_abort("Input must be an object of class {.cls rmd_ast}, got {.cls {class(x)}}.")
  }
  
  find_depth(x@nodes)
}

