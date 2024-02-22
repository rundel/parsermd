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
#' * `has_option()` - selects nodes that have the given option(s) set.
#'
#' @return All helper functions return an integer vector of selected indexes.
#'
#' @examples
#'
#' rmd = parse_rmd(system.file("hw01.Rmd", package="parsermd"))
#'
#' rmd_select(rmd, has_type("rmd_chunk"))
#'
#' rmd_select(rmd, has_label("*dino"))
#'
#' rmd_select(rmd, has_option("message"))
#' rmd_select(rmd, has_option(message = FALSE))
#' rmd_select(rmd, has_option(message = TRUE))
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

  x = tidyselect::peek_data(fn = "has_type")

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

  x = tidyselect::peek_data(fn = "by_section")

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

  x = tidyselect::peek_data(fn = "has_label")

  node_labs = rmd_node_label(x)
  regex = utils::glob2rx(label)
  matching = purrr::map(regex, grepl, x = node_labs) %>%
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

  x = tidyselect::peek_data(fn = "has_option")

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
