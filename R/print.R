trim_blank_lines = function(x) {
  x = paste(x, collapse = "\n")
  x = trimws(x)
  strsplit(x, "\n")[[1]]
}

#' @export
print.rmd_ast = function(ast, as_tree = TRUE, use_headings = TRUE) {
  if (as_tree) {
    print(as_tree(ast, use_headings = use_headings))
  } else {
    for(i in seq_along(ast)) {
      print(ast[[i]])
    }
  }
}

#' @export
print.rmd_markdown = function(md) {
  cli::cli_rule("{.strong Markdown}")
  cat(md, sep="\n")
}

#' @export
print.rmd_chunk = function(chunk) {
  txt = "{.strong Chunk} [engine: {.val {chunk$engine}}"
  if (chunk$name != "")
    txt = paste(txt, "name: {.val {chunk$name}}")

  if (length(chunk$options) != 0) {
    opts = paste(names(chunk$options), chunk$options, sep=" = ")
    txt = paste(txt, "options: {.code {opts}}")
  }
  txt = paste0(txt, "]")

  cli::cli_rule(left = txt)
  print(cli::boxx(chunk$code, padding = 0))
}

#' @export
print.rmd_heading = function(h) {
  cli::cli_rule("{.strong Heading} [h{h$level}] - {.emph {h$name}}")
}

#' @export
print.rmd_yaml = function(yaml) {
  cli::cli_rule("{.strong YAML}")
  print(cli::boxx(cli::col_silver(yaml), padding=0))
}


