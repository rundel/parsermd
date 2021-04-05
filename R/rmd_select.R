#' @name rmd_select
#' @rdname rmd_select
#'
#' @title Select nodes of the Rmd ast
#'
#' @description
#'
#' @examples
#'
#' @export
#'
rmd_select = function(x, ...) {
  UseMethod("rmd_select")
}

#' @exportS3Method
rmd_select.default = function(x, ...) {
  stop("Unsupported type")
}


rmd_select_impl = function(x, ...) {
  checkmate::assert_class(x, "rmd_ast")

  names(x) = rmd_node_label(x)
  loc = tidyselect::eval_select(rlang::expr(c(...)), x)

  loc
}

#' @exportS3Method
rmd_select.rmd_tibble = function(x, ...) {
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0)
    stop("The following columns must be renamed: ", bad_cols, call. = FALSE)


  loc = rmd_select_impl(x$ast, ...)

  x = x[loc,]

  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(x$ast)),  # add new sec_h* columns
    dplyr::select(x, -dplyr::starts_with("sec_h")) # drop old sec_h* columns
  )
  class(x) = c("rmd_tibble", class(x))

  x
}

#' @exportS3Method
rmd_select.rmd_ast = function(x, ...) {
  loc = rmd_select_impl(x$ast, ...)
  x[loc]
}

#' @export
has_type = function(...) {
  allowed_types = c(...)
  checkmate::assert_character(allowed_types, any.missing = FALSE)

  x = tidyselect::peek_data(fn = "has_type")

  which(rmd_node_type(x) %in% allowed_types)
}

#has_label = function(...) {
#  allowed_labels = c(...)
#  checkmate::assert_character(allowed_labels, any.missing = FALSE)
#
#  x = tidyselect::peek_data(fn = "has_label")
#
#  which(rmd_node_label(x) %in% allowed_labels)
#}

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

  which(matching)
}
