#' @title Parse an R Markdown or Quarto document
#'
#' @name parse_rmd
#'
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
#' parse_rmd(system.file("examples/hw01.Rmd", package="parsermd"))
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


#' @name parse_rmd
#'
#' @param qmd Either the path to an `qmd` file or a character vector containing the contents
#' of a Quarto document.
#'
#' @export
parse_qmd = function(qmd, allow_incomplete = FALSE, parse_yaml = TRUE) {
  checkmate::assert_character(qmd, min.len = 1, any.missing = FALSE)

  parse_rmd(rmd=qmd, allow_incomplete=allow_incomplete, parse_yaml=parse_yaml)
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
