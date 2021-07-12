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

  for(j in seq_along(x)) {
    node = x[[j]]
    if (inherits(node, "rmd_heading")) {
      labels[node$level:6] = NA_character_
      labels[node$level] = node$name

      max_level = max(max_level, node$level)
      min_level = min(min_level, node$level)
    }

    sections[[length(sections)+1]] = labels
  }

  # Handle the case where there are no headings
  if (min_level == max(levels) & max_level == min(levels))
    min_level = max_level = 0

  levels = levels[levels %in% (min_level:max_level)]

  sections = purrr::map(sections, ~ .x[levels])

  if (drop_na)
    sections = purrr::map(sections, ~ .x[!is.na(.x)])

  sections
}
