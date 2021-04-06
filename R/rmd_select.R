#' @name rmd_select
#' @rdname rmd_select
#'
#' @title Select nodes of an Rmd ast
#'
#' @description This function is implemented using [tidyselect::eval_select()] which enables
#' a variety of useful syntax for selecting nodes from the ast.
#'
#' Additionally, a number of additional `parsermd` specific selection helpers are available:
#' [has_type()], [by_section()],
#'
#' @param x Rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param ... One or more unquoted expressions separated by commas. Chunk labels can be used
#' as if they were positions in the data frame, so expressions like x:y can be used to
#' select a range of nodes.
#'
#' @examples
#' rmd = parse_rmd(system.file("hw01.Rmd", package = "parsermd"))
#'
#' rmd_select(rmd, "plot-dino", "cor-dino")
#' rmd_select(rmd, `plot-dino`:`cor-dino`)
#'
#' rmd_select(rmd, has_type("rmd_chunk"))
#'
#' rmd_select(rmd, by_section(c("Exercise *", "Solution")))
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
  loc = rmd_select_impl(x, ...)
  x[loc]
}
