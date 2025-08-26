#' @name rmd_select_helpers
#' @rdname rmd_select_helpers
#'
#' @title Rmd selection helper functions
#'
#' @description These functions are used in conjunction with [rmd_select()] to
#' select nodes from an Rmd ast.
#'
#' * `by_section()` - uses section selectors to select nodes.
#' * `has_type()` - selects all nodes that have the given type(s).
#' * `has_label()` - selects nodes with labels matching the given glob.
#' * `has_heading()` - selects heading nodes (only) with titles matching the given glob pattern(s).
#' * `has_option()` - selects nodes that have the given option(s) set.
#' * `has_shortcode()` - selects nodes containing shortcodes matching the given function name(s).
#' * `by_fenced_div()` - selects fenced div sections matching specified id, class, and/or attributes.
#'
#' @return All helper functions return an integer vector of selected indexes.
#'
#' @seealso [rmd_select()] for the main selection function that uses these helpers.
#'
#' @examples
#'
#' rmd = parse_rmd(system.file("examples/hw01.Rmd", package="parsermd"))
#'
#' rmd_select(rmd, has_type("rmd_chunk"))
#'
#' rmd_select(rmd, has_label("*dino"))
#'
#' rmd_select(rmd, has_heading("Exercise *"))
#'
#' rmd_select(rmd, has_option("message"))
#' rmd_select(rmd, has_option(message = FALSE))
#' rmd_select(rmd, has_option(message = TRUE))
#'
#' rmd_select(rmd, has_shortcode())
#' rmd_select(rmd, has_shortcode("video"))
#'
#' fdiv = parse_rmd(system.file("examples/fenced-divs.qmd", package="parsermd"))
#'
#' rmd_select(fdiv, by_fenced_div())  # Select all fenced div pairs
#' rmd_select(fdiv, by_fenced_div(class = "note"))
#' rmd_select(fdiv, by_fenced_div(id = "special-section"))
#' rmd_select(fdiv, by_fenced_div(class = c("warning", "important")))
#' rmd_select(fdiv, by_fenced_div(attr = "icon"))
#'
#'
NULL

#' @rdname rmd_select_helpers
#'
#' @param types Vector of character type names, e.g. `rmd_chunk`, `rmd_heading`, etc.
#'
#' @export
has_type = function(types) {
  checkmate::assert_character(types, any.missing = FALSE)

  x = tidyselect::peek_data(fn = "has_type") |>
    rmd_ast()

  which(rmd_node_type(x) %in% types)
}

#' @rdname rmd_select_helpers
#'
#' @param sec_ref character vector, a section reference selector. See details below
#' for further details on how these are constructed.
#' @param keep_parents Logical, retain the parent headings of selected sections.
#' Default: `TRUE`
#'
#' @details
#' ## Section reference selectors
#'
#' Section reference selectors are a simplified version of CSS selectors that
#' are designed to enable the selection nodes in a way that respects the implied
#' hierarchy of a document's section headings.
#'
#' They consist of a character vector of heading names where each subsequent value
#' is assumed to be nested within the preceding value. For example, the section
#' selector `c("Sec 1", "Sec 2")` would select all nodes that are contained within
#' a heading named `Sec 2` that is in turn contained within a heading named `Sec 1`
#' (or a heading contained within a heading named `Sec 1`, and so on).
#'
#' The individual section names can be specified using wildcards (aka globbing
#' patterns), which may match one or more sections within the document, e.g.
#'  `c("Sec 1", "Sec *")`. See [utils::glob2rx()] or
#'  [wikipedia](https://en.wikipedia.org/wiki/Glob_(programming))
#'  for more details on the syntax for these patterns.
#'
#' @export
by_section = function(sec_ref, keep_parents = TRUE) {
  checkmate::assert_character(sec_ref, any.missing = FALSE, min.len = 1)
  checkmate::assert_logical(keep_parents, any.missing = FALSE, len = 1)

  x = tidyselect::peek_data(fn = "by_section") |>
    rmd_ast()

  types = rmd_node_type(x)
  depths = rmd_node_depth(x)
  fdiv_pairs = find_fenced_div_pairs(x@nodes)
  
  heading_positions = which(types == "rmd_heading")
  if (length(heading_positions) == 0) return(integer(0))
  
  heading_names = purrr::map_chr(x@nodes, "name", .default=NA_character_)
  
  regex = utils::glob2rx(sec_ref)
  heading_matches = purrr::map(regex, ~which(grepl(.x, heading_names))) |>
    expand.grid() |>
    purrr::pmap(~c(...)) |>
    purrr::keep(~all(diff(.x) >= 0)) # Remove cases where not increasing

  if (length(sec_ref) > 1) {
    heading_matches = purrr::keep(
      heading_matches,
      function(pos) {
        # Check if each pair includes only children
        all(purrr::map2_lgl(
          pos[-length(pos)], pos[-1],
          ~ are_children_by_depth(.x, .y, depths)
        ))
      }
    )
  }
  
  purrr::map(
    heading_matches,
    function(pos) {
      children = find_children_by_depth(pos[length(pos)], depths) 
    
      if (keep_parents) {
        parents = find_parents_by_depth(pos[length(pos)], end=1, depths=depths) 
        
        # Parents captures open fdivs but not the closes, so add those in too
        open_fdivs = parents[parents %in% which(types == "rmd_fenced_div_open")]
        c(parents, fdiv_pairs[open_fdivs], children)
      } else {
        children
      }
    }
  ) |>
    unlist() |>
    unique() |>
    sort()
}


#' @rdname rmd_select_helpers
#'
#' @param label character vector, glob patterns for matching chunk labels.
#'
#' @export
has_label = function(label) {
  checkmate::assert_character(label, any.missing = FALSE, min.len = 1)

  x = tidyselect::peek_data(fn = "has_label") |>
    rmd_ast()

  node_labs = rmd_node_label(x)
  regex = utils::glob2rx(label)
  matching = purrr::map(regex, grepl, x = node_labs) %>%
    purrr::reduce(`|`)

  which(matching)
}

#' @rdname rmd_select_helpers
#'
#' @param heading character vector, glob patterns for matching heading titles.
#'
#' @export
has_heading = function(heading) {
  checkmate::assert_character(heading, any.missing = FALSE, min.len = 1)

  x = tidyselect::peek_data(fn = "has_heading") |>
    rmd_ast()

  # Only consider heading nodes
  is_heading = rmd_node_type(x) == "rmd_heading"
  heading_names = rmd_node_attr(x, "name")
  
  # Convert to character vector, replacing NULL with empty string
  heading_titles = purrr::map_chr(heading_names, function(name) {
    if (is.null(name)) "" else as.character(name)
  })
  
  regex = utils::glob2rx(heading)
  matching = purrr::map(regex, grepl, x = heading_titles) |>
    purrr::reduce(`|`)
  
  # Only return headings that match
  which(is_heading & matching)
}

#' @rdname rmd_select_helpers
#'
#' @param code character vector, regex patterns for matching chunk code line(s)
#'
#' @export
has_code = function(code) {
  checkmate::assert_character(code, any.missing = FALSE, min.len = 1)

  x = tidyselect::peek_data(fn = "has_code") |>
    rmd_ast()

  node_code = rmd_node_code(x)
  matching = purrr::map(code, grepl, x = node_code) %>%
    purrr::reduce(`|`)

  which(matching)
}



#' @rdname rmd_select_helpers
#'
#' @param ... Either option names represented by a scalar string or a named argument with the form
#' `opt = value` where `opt` is the option name and `value` is the value to be checked. For example
#' `eval = TRUE` would check for the option `eval` being set to `TRUE`.
#'
#' @export
has_option = function(...) {
  opts = c(...)

  if (is.null(names(opts))) # missing names will be ""
      names(opts) = rep("", length(opts))

  x = tidyselect::peek_data(fn = "has_option") |>
    rmd_ast()

  purrr::map2(
    opts, names(opts),
    function(opt, name) {
      if (name == "") {
        # Normalize option name for lookup (replace - with .)
        normalized_opt = normalize_option_names(opt)
        rmd_get_options(x, normalized_opt, yaml_style = FALSE) |>
          purrr::map_lgl(~!is.null(.x[[normalized_opt]]))
      } else {
        # Normalize option name for comparison (replace - with .)
        normalized_name = normalize_option_names(name)
        rmd_get_options(x, normalized_name, yaml_style = FALSE) |>
          purrr::map_lgl(~identical(.x[[normalized_name]], opt))
      }
    }
  ) |>
    purrr::reduce(`|`) |>
    which()
}

#' @rdname rmd_select_helpers
#'
#' @param func_name character vector, optional glob patterns for matching shortcode function names.
#' If NULL (default), matches any shortcode.
#'
#' @export
has_shortcode = function(func_name = NULL) {
  checkmate::assert_character(func_name, any.missing = FALSE, min.len = 1, null.ok = TRUE)
  
  if (!is.null(func_name) && any(func_name == "")) {
    cli::cli_abort("Function names cannot be empty strings")
  }

  x = tidyselect::peek_data(fn = "has_shortcode") |>
    rmd_ast()

  contains_shortcode = rmd_has_shortcode(x, func_name)
  
  which(contains_shortcode)
}

#' @rdname rmd_select_helpers
#'
#' @param engine character vector, optional glob patterns for matching inline code engine names.
#' If NULL (default), matches any inline code.
#'
#' @export
has_inline_code = function(engine = NULL) {
  checkmate::assert_character(engine, any.missing = FALSE, min.len = 1, null.ok = TRUE)
  
  if (!is.null(engine) && any(engine == "")) {
    cli::cli_abort("Engine names cannot be empty strings")
  }

  x = tidyselect::peek_data(fn = "has_inline_code") |>
    rmd_ast()

  contains_inline_code = rmd_has_inline_code(x, engine)
  
  which(contains_inline_code)
}

#' @rdname rmd_select_helpers
#'
#' @param id Character, optional ID to match (with or without # prefix)
#' @param class Character vector, optional class names to match (with `.` prefix). 
#' All specified classes must be present in the fenced div (subset matching).
#' @param attr Either a character vector of attribute names to check for existence,
#' or a named list/vector where names are attribute names and values must match exactly.
#'
#' @export
by_fenced_div = function(id = NULL, class = NULL, attr = NULL) {
  # Input validation
  checkmate::assert_character(id, len = 1, null.ok = TRUE)
  checkmate::assert_character(class, min.len = 1, null.ok = TRUE)
  
  # Process ID - add # prefix if missing and warn
  if (!is.null(id)) {
    if (!startsWith(id, "#")) {
      cli::cli_warn("ID {.val {id}} should start with '#' prefix, adding it automatically")
      id = paste0("#", id)
    }
  }
  
  # Process classes - add . prefix if missing and warn
  if (!is.null(class)) {
    missing_prefix = !startsWith(class, ".")
    if (any(missing_prefix)) {
      missing_classes = class[missing_prefix]
      cli::cli_warn("Classes {.val {missing_classes}} should start with '.' prefix, adding it automatically")
      class[missing_prefix] = paste0(".", class[missing_prefix])
    }
  }
  
  # Process attr - validate structure
  if (!is.null(attr)) {
    if (is.list(attr)) {
      # Convert list to named character vector
      attr = unlist(attr)
    }
    if (!is.character(attr)) {
      cli::cli_abort("{.arg attr} must be a character vector or list")
    }
  }
  
  x = tidyselect::peek_data(fn = "by_fenced_div") |>
    rmd_ast()
  
  fdiv_find_matching_ranges(x, id, class, attr)
}

#' Find matching fenced div ranges
#' @param ast rmd_ast object
#' @param id Character, ID to match (with # prefix)
#' @param class Character vector, classes to match (with . prefix)
#' @param attr Character vector of attributes (named for value matching, unnamed for existence)
#' @return Integer vector of matching node indices
#' @noRd
fdiv_find_matching_ranges = function(ast, id, class, attr) {
  nodes = ast@nodes
  if (length(nodes) == 0) return(integer(0))
  
  # Find all fenced div open nodes and their positions
  is_fdiv_open = purrr::map_lgl(nodes, ~ S7::S7_inherits(.x, rmd_fenced_div_open))
  fdiv_open_positions = which(is_fdiv_open)
  
  if (length(fdiv_open_positions) == 0) return(integer(0))
  
  # Check which open nodes match all criteria
  matching_positions = c()
  
  for (pos in fdiv_open_positions) {
    node = nodes[[pos]]
    
    # Check if this node matches all criteria
    if (fdiv_node_matches(node, id, class, attr)) {
      # Find the corresponding close position for this open
      close_pos = fdiv_find_matching_close(nodes, pos)
      if (!is.na(close_pos)) {
        # Include all nodes from open to close (inclusive)
        matching_positions = c(matching_positions, pos:close_pos)
      }
    }
  }
  
  # Return unique sorted positions
  sort(unique(matching_positions))
}

#' Check if a fenced div node matches the specified criteria
#' @param node rmd_fenced_div_open node
#' @param id Character, ID to match (with # prefix, or NULL)
#' @param class Character vector, classes to match (with . prefix, or NULL)
#' @param attr Character vector of attributes (or NULL)
#' @return Logical, TRUE if node matches all criteria
#' @noRd
fdiv_node_matches = function(node, id, class, attr) {
  # Check ID match
  if (!is.null(id)) {
    if (length(node@id) == 0 || node@id != id) {
      return(FALSE)
    }
  }
  
  # Check classes match (subset matching - all specified classes must be present)
  if (!is.null(class)) {
    if (length(node@classes) == 0) {
      return(FALSE)
    }
    # Check if all specified classes are present in the node's classes
    if (!all(class %in% node@classes)) {
      return(FALSE)
    }
  }
  
  # Check attributes match
  if (!is.null(attr)) {
    if (is.null(names(attr)) || all(names(attr) == "")) {
      # Unnamed attributes - check for existence
      if (length(node@attr) == 0) {
        return(FALSE)
      }
      # Check if all specified attribute names exist
      if (!all(attr %in% names(node@attr))) {
        return(FALSE)
      }
    } else {
      # Named attributes - check for exact value matches
      node_attr_names = names(node@attr)
      for (i in seq_along(attr)) {
        attr_name = names(attr)[i]
        attr_value = attr[i]
        
        if (attr_name == "") {
          # Unnamed - check for existence
          if (!attr_value %in% node_attr_names) {
            return(FALSE)
          }
        } else {
          # Named - check for exact match
          if (!(attr_name %in% node_attr_names) || 
              node@attr[[attr_name]] != attr_value) {
            return(FALSE)
          }
        }
      }
    }
  }
  
  TRUE
}

#' Find the matching close position for an open fenced div
#' @param nodes List of rmd nodes
#' @param open_pos Integer position of the open node
#' @return Integer position of matching close, or NA if not found
#' @noRd
fdiv_find_matching_close = function(nodes, open_pos) {
  balance = 1  # We start with 1 because we're at an open
  
  for (i in (open_pos + 1):length(nodes)) {
    node = nodes[[i]]
    
    if (S7::S7_inherits(node, rmd_fenced_div_open)) {
      balance = balance + 1
    } else if (S7::S7_inherits(node, rmd_fenced_div_close)) {
      balance = balance - 1
      
      # Found our matching close
      if (balance == 0) {
        return(i)
      }
    }
  }
  
  # No matching close found
  NA_integer_
}
