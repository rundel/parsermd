trim_blank_lines = function(x) {
  x = paste(x, collapse = "\n")
  x = trimws(x)
  strsplit(x, "\n")[[1]]
}

#' @export
print.rmd_ast = function(ast) {
  for(i in seq_along(ast)) {
    print(ast[[i]])
  }
}

print.rmd_chunk = function(chunk) {
  cli::cli_h1("Chunk")

  txt = "{.strong Engine}: {.val {chunk$engine}}"
  if (chunk$name != "")
    txt = paste(txt, "{.strong Name}: {.val {chunk$name}}")

  if (length(chunk$options) != 0) {
    opts = paste(names(chunk$options), chunk$options, sep=" = ")
    txt = paste(txt, "{.strong Options}: {.code {opts}}")
  }

  cli::cli_text(txt)

  #cli::cli_text("{.strong Code}:")
  print(cli::boxx(chunk$code, padding = 0))
}

print.rmd_md = function(md) {
  cli::cli_h1("Markdown Text")
  #for(line in md) {
  #  cli::cli_text(
  #    line
  #  )
  #}
  md = trim_blank_lines(md)
  md = strwrap(md)

  if (length(md) == 0)
    md = ""

  print(cli::boxx(md, padding = 0))
}

print.rmd_yaml = function(yaml) {
  cli::cli_h1("Front Matter")
  for(line in yaml) {
    cli::cli_text(
      cli::col_silver(line)
    )
  }
}
