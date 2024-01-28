#' @title Parse an R Markdown document
#' @description
#' Documents are parse into an `rmd_ast` object.
#'
#' @param rmd Either the path to an `Rmd` file or a character vector containing the contents
#' of a R Markdown document.
#' @param allow_incomplete Allow incomplete parsing of the document.
#' @param parse_yaml Use the [yaml][yaml::read_yaml()] package to parse the document's yaml.
#'
#' @return Returns a `rmd_ast` object.
#'
#' @examples
#' parse_rmd(system.file("hw01.Rmd", package="parsermd"))
#'
#' @export
parse_rmd = function(rmd, allow_incomplete = FALSE, parse_yaml = TRUE) {
  checkmate::assert_character(rmd, min.len = 1, any.missing = FALSE)

  if (length(rmd) > 1) {               # If multiple lines in a char vec assume
    rmd = paste0(rmd, "\n", collapse = "")  #   it has been read in already
  } else if (!grepl("\n", rmd)) {      # If no newlines then assume it is a path or url
    rmd = readr::read_file(rmd)
  }

  # Make sure file ends with trailing newline
  if (!grepl("\n$", rmd))
    rmd = paste0(rmd, "\n")

  ast = parse_rmd_cpp(rmd, allow_incomplete)

  if (parse_yaml) {
    ast = parse_yaml(ast)
  }

  ast = fix_unnamed_chunks(ast)
  ast
}

fix_unnamed_chunks = function(ast) {
  unk_i = 1
  for(j in seq_along(ast)) {
    if (inherits(ast[[j]], "rmd_chunk") && ast[[j]][["name"]] == "") {
      ast[[j]][["name"]] = paste0("unnamed-chunk-", unk_i)
      unk_i = unk_i + 1
    }
  }

  ast
}


as_rmd_yaml_list = function(yaml) {
  if(length(yaml) == 0) {
    yaml = list()
  } else {
    yaml = yaml::yaml.load(
      string = paste(yaml, collapse="\n"),
      handlers = list(expr = function(x) parse(text=x))
    )
  }

  class(yaml) = "rmd_yaml_list"

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
  as_rmd_yaml_list(x)
}

#' @exportS3Method
parse_yaml.rmd_yaml = function(x) {
  as_rmd_yaml_list(x)
}

#' @exportS3Method
parse_yaml.rmd_chunk = function(x) {
  x[["yaml_options"]] = as_rmd_yaml_list(x[["yaml_options"]])
  x
}

#' @exportS3Method
parse_yaml.rmd_ast = function(x) {
  structure(
    lapply(x, parse_yaml),
    class = c("rmd_ast", "list")
  )
}


