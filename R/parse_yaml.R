parse_yaml = function(text) {
  if(length(text) == 0) {
    yaml = list()
  } else {
    yaml = yaml::yaml.load(
      string = paste(text, collapse="\n"),
      handlers = list(expr = function(x) parse(text=x))
    )
  }

  if (!is.list(yaml))
    yaml = as.list(yaml)

  yaml
}

expression_verbatim = function(x) {
  res = as.character(x)
  attr(res,"tag") = "!expr"

  res
}

yaml_text = function(list) {
  strsplit( yaml::as.yaml(
    list,
    handlers = list(
      expression = expression_verbatim,
      logical = yaml::verbatim_logical
    )
  ), split = "\n")[[1]]
}

