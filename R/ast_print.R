trim_blank_lines = function(x) {
  x = paste(x, collapse = "\n")
  x = trimws(x)
  strsplit(x, "\n")[[1]]
}

#' @export
print.rmd_ast = function(ast, as_tree = TRUE) {

  if (as_tree) {
    print(as_tree(ast))
  } else {
    for(i in seq_along(ast)) {
      if (class(ast[[i]]) == "character")
        cat(ast[[i]], sep="\n")
      else
        print(ast[[i]])
    }
  }
}

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

print.rmd_heading = function(h) {

  cli::cli_rule("{.strong Heading} [h{h$level}] - {.emph {h$name}}")

}

print.rmd_yaml = function(yaml) {
  cli::boxx(cli::col_silver(yaml), padding=0)
}



as_tree = function(obj, ...) {
  UseMethod("as_tree")
}

as_tree.default = function(obj, ...) {
  stop("Unsupports type:", class(obj))
}

as_tree.rmd_ast = function(ast, root = "Rmd AST") {

  tree = list()
  tree[[root]] = character()

  sections = root
  level = 0

  for(j in seq_along(ast)) {
    x = ast[[j]]

    if (inherits(x, "rmd_yaml")) {
      text = "YAML"
      label = paste0("[", length(x)," lines]")
    } else if (inherits(x, "rmd_heading")) {
      text = paste("Heading")
      label = paste0("[h", x$level, "] - ",  cli::style_bold(x$name))

      sub = level < x$level
      level = level[sub]
      sections = sections[sub]
    } else if (inherits(x, "rmd_chunk")) {
      text = paste("Chunk")
      name = if (x$name != "") cli::style_bold(x$name)
      else cli::style_italic("<unnamed>")
      opt = if (length(x$options) == 1) "1 opt, "
      else if (length(x$options) != 0) paste0(length(x$options), " opts, ")
      else ""
      label = paste0("[", x$engine, ", ", opt, length(x$code), " lines] - ", name)
    } else if (inherits(x, "character")) {
      text = "Markdown"
      label = paste0("[", length(x), " lines]")
    } else {
      stop("Unexpected type in AST")
    }

    cur_sec = sections[length(sections)]
    node = paste(text, cli::col_grey(label))
    tree[[cur_sec]] = append(tree[[cur_sec]], node)
    tree[[node]] = character()

    if (inherits(x, "rmd_heading")) {
      sections = append(sections, node)
      level = append(level, x$level)
    }
  }

  d = data.frame(name = names(tree), children = I(unname(tree)))

  cli::tree(d)
}

