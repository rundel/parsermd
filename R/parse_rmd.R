#' @export
parse_rmd = function(rmd, allow_incomplete = FALSE, parse_yaml = TRUE) {
  checkmate::assert_character(rmd, len = 1, any.missing = FALSE)

  if (file.exists(rmd))
    rmd = readr::read_file(rmd)

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
