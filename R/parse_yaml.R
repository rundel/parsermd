as_rmd_yaml = function(yaml) {
  if(length(yaml) == 0) {
    yaml = list()
  } else {
    yaml = yaml::yaml.load(
      string = paste(yaml, collapse="\n"),
      handlers = list(expr = function(x) parse(text=x))
    )
  }

  if (!is.list(yaml))
    yaml = as.list(yaml)

  class(yaml) = "rmd_yaml"

  yaml
}

expression_verbatim = function(x) {
  res = as.character(x)
  attr(res,"tag") = "!expr"

  res
}

as_yaml_text = function(list) {
  strsplit( yaml::as.yaml(
    list,
    handlers = list(
      expression = expression_verbatim,
      logical = yaml::verbatim_logical
    )
  ), split = "\n")[[1]]
}


parse_yaml = function(x) {
  UseMethod("parse_yaml")
}

#' @exportS3Method
parse_yaml.default = function(x) {
  x
}

#' @exportS3Method
parse_yaml.character = function(x) {
  as_rmd_yaml(x)
}

#' @exportS3Method
parse_yaml.rmd_yaml_text = function(x) {
  as_rmd_yaml(x)
}

#' @exportS3Method
parse_yaml.rmd_chunk = function(x) {
  x[["yaml_options"]] = as_rmd_yaml(x[["yaml_options"]])
  x
}

#' @exportS3Method
parse_yaml.rmd_ast = function(x) {
  structure(
    lapply(x, parse_yaml),
    class = c("rmd_ast", "list")
  )
}


