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
#' * `has_heading()` - selects heading nodes with titles matching the given glob pattern(s).
#' * `has_option()` - selects nodes that have the given option(s) set.
#' * `has_shortcode()` - selects nodes containing shortcodes matching the given function name(s).
#' * `by_fdiv()` - selects fenced div sections where all provided patterns match the div attributes.
#'
#' @return All helper functions return an integer vector of selected indexes.
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
#' rmd_select(rmd, by_fdiv("note"))
#' rmd_select(rmd, by_fdiv(".warning", "important"))
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
#' a section named `Sec 2` that is in turn contained within a section named `Sec 1`
#' (or a section contained within a section named `Sec 1`, and so on).
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
  secs = rmd_node_sections(x, drop_na = TRUE)

  regex = utils::glob2rx(sec_ref)
  matching = purrr::map_lgl(secs, subset_match, regex = regex)

  if (any(matching) & keep_parents) {
    parents = (parent_match(secs, regex) & types == "rmd_heading")
    matching = matching | parents
  }
  #
  which(matching)
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
        rmd_get_options(x, opt) %>%
          purrr::map_lgl(~!is.null(.x[[opt]]))
      } else {
        rmd_get_options(x, name) %>%
          purrr::map_lgl(~identical(.x[[name]], as.character(opt)))
      }
    }
  ) %>%
    purrr::reduce(`|`) %>%
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

  x = tidyselect::peek_data(fn = "has_inline_code") |>
    rmd_ast()

  contains_inline_code = rmd_has_inline_code(x, engine)
  
  which(contains_inline_code)
}

#' @rdname rmd_select_helpers
#'
#' @param ... Character vector patterns to match against fenced div attributes.
#' All provided patterns must match at least one attribute in the div's attr property.
#' @param regexp Logical, use regular expressions for pattern matching instead of glob patterns.
#' Default: FALSE (uses glob patterns).
#'
#' @export
by_fdiv = function(..., regexp = FALSE) {
  # Capture arguments before combining them
  dots = list(...)
  
  # Input validation - check each argument is length 1 character
  for (i in seq_along(dots)) {
    arg = dots[[i]]
    if (!is.character(arg)) {
      cli::cli_abort("All patterns must be character vectors, pattern {i} is {.cls {class(arg)}}")
    }
    if (length(arg) != 1) {
      cli::cli_abort("All patterns must be length 1 character vectors, pattern {i} has length {length(arg)}")
    }
    if (is.na(arg)) {
      cli::cli_abort("All patterns must be non-missing, pattern {i} is NA")
    }
  }
  
  if (length(dots) < 1) {
    cli::cli_abort("At least one pattern must be provided")
  }
  
  checkmate::assert_logical(regexp, len = 1)
  
  # Now combine the validated arguments
  patterns = c(...)
  
  x = tidyselect::peek_data(fn = "by_fdiv") |>
    rmd_ast()
  
  fdiv_find_matching_ranges(x, patterns, regexp)
}

#' Find matching fenced div ranges
#' @param ast rmd_ast object
#' @param patterns Character vector of patterns to match
#' @param regexp Logical, use regexp instead of glob
#' @return Integer vector of matching node indices
#' @noRd
fdiv_find_matching_ranges = function(ast, patterns, regexp) {
  nodes = ast@nodes
  if (length(nodes) == 0) return(integer(0))
  
  # Find all fenced div open nodes and their positions
  is_fdiv_open = purrr::map_lgl(nodes, ~ S7::S7_inherits(.x, rmd_fenced_div_open))
  fdiv_open_positions = which(is_fdiv_open)
  
  if (length(fdiv_open_positions) == 0) return(integer(0))
  
  # Check which open nodes match all patterns
  matching_positions = c()
  
  for (pos in fdiv_open_positions) {
    node = nodes[[pos]]
    attrs = node@attr
    
    # Check if all patterns match at least one attribute
    if (fdiv_all_patterns_match(attrs, patterns, regexp)) {
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

#' Check if all patterns match at least one attribute
#' @param attrs Character vector of attributes
#' @param patterns Character vector of patterns
#' @param regexp Logical, use regexp instead of glob
#' @return Logical, TRUE if all patterns match
#' @noRd
fdiv_all_patterns_match = function(attrs, patterns, regexp) {
  if (length(attrs) == 0) return(FALSE)
  
  # Convert patterns to regex
  if (regexp) {
    regex_patterns = patterns
  } else {
    regex_patterns = utils::glob2rx(patterns)
  }
  
  # Check that every pattern matches at least one attribute
  purrr::every(regex_patterns, function(pattern) {
    any(grepl(pattern, attrs))
  })
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
