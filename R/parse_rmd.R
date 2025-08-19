#' @title Parse an R Markdown or Quarto document
#'
#' @name parse_rmd
#'
#' @description
#' Documents are parsed into an `rmd_ast` object.
#'
#' @param rmd Either the path to an `Rmd` file or a character vector containing the contents
#' of a R Markdown document.
#'
#' @return Returns a `rmd_ast` object.
#'
#' @examples
#' parse_rmd(system.file("examples/hw01.Rmd", package="parsermd"))
#'
#' @export
parse_rmd = function(rmd) {
  checkmate::assert_character(rmd, min.len = 1, any.missing = FALSE)

  if (length(rmd) > 1) {               # If multiple lines in a char vec assume
    rmd = paste0(rmd, "\n", collapse = "")  #   it has been read in already
  } else if (!grepl("\n", rmd) && file.exists(rmd)) { # If no newlines and not empty then assume it is a path or url
    rmd = readr::read_file(rmd)
  }

  # Make sure file ends with trailing newline
  if (!grepl("\n$", rmd))
    rmd = paste0(rmd, "\n")

  ast = parse_rmd_cpp(rmd)
  ast = fix_unnamed_chunks(ast)
  ast = collapse_markdown_nodes(ast)
  ast
}


#' @name parse_rmd
#'
#' @param qmd Either the path to an `qmd` file or a character vector containing the contents
#' of a Quarto document.
#'
#' @export
parse_qmd = function(qmd) {
  checkmate::assert_character(qmd, min.len = 1, any.missing = FALSE)

  parse_rmd(rmd=qmd)
}

fix_unnamed_chunks = function(ast) {
  unk_i = 1
  for(j in seq_along(ast@nodes)) {
    if (inherits(ast@nodes[[j]], "rmd_chunk") && ast@nodes[[j]]@label == "" && rmd_node_label(ast@nodes[[j]]) == "") {
      ast@nodes[[j]]@label = paste0("unnamed-chunk-", unk_i)
      unk_i = unk_i + 1
    }
  }

  ast
}

collapse_markdown_nodes = function(ast) {
  new_nodes = list()
  
  for (node in ast@nodes) {
    if (inherits(node, "rmd_markdown") && 
        length(new_nodes) > 0 && 
        inherits(new_nodes[[length(new_nodes)]], "rmd_markdown")) {
      
      last_node = new_nodes[[length(new_nodes)]]
      new_nodes[[length(new_nodes)]] = rmd_markdown(lines = c(last_node@lines, "", node@lines))
    } else {
      new_nodes[[length(new_nodes) + 1]] = node
    }
  }
  
  ast@nodes = new_nodes
  ast
}
