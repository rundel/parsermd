#' @importFrom tibble as_tibble
#' @export
tibble::as_tibble

# #' @exportS3Method
# as.data.frame.rmd_ast = function(x, ..., include_yaml = TRUE) {
#   as_tibble.rmd_ast(x, include_yaml) %>%
#     as.data.frame()
# }

#' @exportS3Method
as_tibble.rmd_ast = function(x, include_yaml = TRUE, ...) {

  if (!include_yaml & inherits(x[[1]], "rmd_yaml"))
    x = x[-1]

  df = tibble::as_tibble( list(
    sections = rmd_node_sections(x, drop_na = FALSE),
    type = rmd_node_type(x),
    label = rmd_node_label(x),
    ast = x
  ) )

  df = tidyr::unnest_wider(df, tidyselect::all_of("sections"))
  class(df) = c("rmd_tibble", class(df))

  df
}


#' @importFrom pillar type_sum
pillar::type_sum

#' @export
type_sum.rmd_chunk = function(x) {
  paste(
    cli::style_bold("chunk"),
    #cli::style_italic('"', x$name, '"')
    paste0("[", x$engine, "]")
  )
}

#' @export
type_sum.rmd_raw_chunk = function(x) {
  paste(
    cli::style_bold("raw attr chunk"),
    paste0("[", x$format, "]")
  )
}

#' @export
type_sum.rmd_yaml = function(x) {
  paste(
    cli::style_bold("yaml"),
  )
}

#' @export
type_sum.rmd_heading = function(x) {
  paste(
    cli::style_bold("heading"),
    paste0("[h", x$level, "]")
  )
}

#' @export
type_sum.rmd_yaml_list = function(x) {
  cli::style_bold("yaml")
}

#' @export
type_sum.rmd_markdown = function(x) {
  cli::style_bold("markdown")
}

#' @export
type_sum.rmd_code_block = function(x) {
  cli::style_bold("code block")
}

#' @export
type_sum.rmd_fenced_div_open = function(x) {
  cli::style_bold("fenched div [open]")
}

#' @export
type_sum.rmd_fenced_div_close = function(x) {
  cli::style_bold("fenched div [close]")
}
