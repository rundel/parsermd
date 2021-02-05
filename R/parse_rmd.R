#' @title Parse an RMarkdown document
#' @description
#' Documents are parse into an `rmd_ast` object.
#'
#' @param rmd Either the path to an `Rmd` file or a character vector containing the contents
#' of a RMarkdown document.
#' @param allow_incomplete Allow incomplete parsing of the document.
#' @param parse_yaml Use the [yaml] package to parse the document's yaml.
#'
#' @examples
#' parse_rmd(system.file("hw01.Rmd", package="parsermd"))
#'
#' @export
parse_rmd = function(rmd, allow_incomplete = FALSE, parse_yaml = TRUE) {
  checkmate::assert_character(rmd, min.len = 1, any.missing = FALSE)

  if (length(rmd) > 1) {               # If multiple lines in a char vec assume
    rmd = paste(rmd, collapse = "\n")  #   it has been read in already
  } else if (!grepl("\n", rmd)) {      # If no newlines then assume it is a path or url
    rmd = readr::read_file(rmd)
  }

  # Make sure file ends with trailing newline
  if (!grepl("\n$", rmd))
    rmd = paste0(rmd, "\n")

  ast = parse_rmd_cpp(rmd, allow_incomplete)

  if (parse_yaml && inherits(ast[[1]], "rmd_yaml")) {
    ast[[1]] = parse_yaml(ast[[1]])
  }

  ast
}


parse_yaml = function(yaml) {
  checkmate::check_class(yaml, "rmd_yaml")

  if(length(yaml) == 0)
    yaml = list()
  else
    yaml = yaml::read_yaml(text = paste(yaml, collapse="\n"))

  class(yaml) = "rmd_yaml_list"

  yaml
}
