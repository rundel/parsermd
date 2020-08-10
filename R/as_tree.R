as_tree = function(obj, ...) {
  UseMethod("as_tree")
}

as_tree.default = function(obj, ...) {
  stop("Unsupports type:", class(obj))
}

as_tree.rmd_ast = function(ast, root = "Rmd AST", use_headings = TRUE) {

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
    } else if (inherits(x, "rmd_markdown")) {
      text = "Markdown"
      label = paste0("[", length(x), " lines]")
    } else {
      stop("Unexpected type in AST")
    }

    cur_sec = sections[length(sections)]
    node = paste(text, cli::col_grey(label))
    tree[[cur_sec]] = append(tree[[cur_sec]], node)
    tree[[node]] = character()

    if (inherits(x, "rmd_heading") & use_headings) {
      sections = append(sections, node)
      level = append(level, x$level)
    }
  }

  d = data.frame(name = names(tree), children = I(unname(tree)))

  cli::tree(d)
}

