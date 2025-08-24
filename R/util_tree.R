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

are_children_by_depth = function(i, j, depths) {
  checkmate::assert_numeric(depths, lower=0, any.missing = FALSE)
  checkmate::assert_numeric(i, len=1, lower=1, upper=length(depths))
  checkmate::assert_numeric(j, len=1, lower=i, upper=length(depths))

  if (i == j) {
    return(TRUE)
  }

  all(depths[seq(i+1, j)] > depths[i])
}

find_children_by_depth = function(i, depths) {
  checkmate::assert_numeric(depths, lower=0, any.missing = FALSE)
  checkmate::assert_numeric(i, len=1, lower=1, upper=length(depths))

  if (i == length(depths)) {
    # Last node has no children
    return(i)
  }

  # Find where depth stops increasing after i, step back to get last child
  last_child = which(!(depths > depths[i]) & seq_along(depths) > i) - 1

  if (length(last_child) == 0) {
    # This can happen if all the remaining nodes are children
    if (depths[i] < depths[i+1]) {
      seq(i, length(depths))
    } else { # or if there are no children
      i
    }
  } else {
    seq(i, min(last_child))
  }
}

find_parents_by_depth = function(i, end=1, depths) {
  checkmate::assert_numeric(depths, lower=0, any.missing = FALSE)
  checkmate::assert_numeric(i, len=1, lower=1, upper=length(depths))
  checkmate::assert_numeric(end, len=1, lower=1, upper=i)

  if (i == end) {
    # First node has no parents
    return(i)
  }

  cur_depth = depths[i]
  parents = c()
  for (j in seq(i-1, end)) {
    if (depths[j] < cur_depth) {
      parents = c(j, parents)
      cur_depth = depths[j]
    }
  }

  parents
}
