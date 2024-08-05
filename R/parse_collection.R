abs_to_rel_path = function(f, dir) {
  substr(f, nchar(dir)+2, nchar(f))
}

parse_collection = function(dir = "./", pattern, all = FALSE, recurse = TRUE, regex = FALSE, parse_func, class) {
  dir = fs::path_real(dir)

  f = fs::dir_ls(path = dir, all = all, recurse = recurse, type = "file")
  f = abs_to_rel_path(f, dir)

  if (!regex)
    pat = utils::glob2rx(pattern)

  f = fs::path_filter(f, regexp = paste(pat, collapse = "|"), invert = FALSE)

  class = c(class, class(tibble::tibble()))

  df = tibble::tibble(
    name = as.character(f),
    path = fs::path(dir, f),
    ast = purrr::map(path, parse_func)
  ) %>%
    magrittr::set_class(class)
}

#' @title Parse a collection of R Markdown or Quarto document
#'
#' @name parse_collection
#'
#' @description
#' Recursively searches a directory for R Markdown or Quarto documents and parses them into a collection of
#' `rmd_ast` objects
#'
#' @param dir Directory to search
#' @param pattern Pattern to match files, defaults to glob syntax
#' @param all Search includes hidden files
#' @param recurse Search recusively within `dir`
#' @param regex Treat `pattern` as a regular expression syntax for `pattern`
#'
#' @return Returns a `tibble` object with columns for document `name`, `path`, and `ast`.
#'
#' @examples
#' parse_rmd_collection(system.file("examples/", package="parsermd"))
#'
#' @export
parse_qmd_collection = function(dir = "./", pattern = "*.qmd", all = FALSE, recurse = TRUE, regex = FALSE) {
  parse_collection(
    dir = dir, pattern = pattern, all = all, recurse = recurse, regex = regex,
    parse_func = parse_qmd, class = "qmd_collection"
  )
}

#' @name parse_collection
#'
#' @export
parse_rmd_collection = function(dir = "./", pattern = "*.Rmd", all = FALSE, recurse = TRUE, regex = FALSE) {
  parse_collection(
    dir = dir, pattern = pattern, all = all, recurse = recurse, regex = regex,
    parse_func = parse_qmd, class = "rmd_collection"
  )
}


#' @export
type_sum.rmd_collection = function(x) {
  paste(
    cli::style_bold("rmd_coll")
  )
}

#' @export
type_sum.qmd_collection = function(x) {
  paste(
    cli::style_bold("qmd_coll")
  )
}
