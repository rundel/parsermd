#' @export
parse_rmd = function(rmd) {
  checkmate::assert_character(rmd, len = 1, any.missing = FALSE)

  if (file.exists(rmd))
    rmd = readr::read_file(rmd)

  parse_rmd_cpp(rmd)
}

