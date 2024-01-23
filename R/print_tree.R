## Based in part on https://github.com/r-lib/fs/tree/master/R

pc = function(...) {
  paste(..., collapse="", sep="")
}

tree_node = function(x) {
  UseMethod("tree_node")
}

tree_node.default = function(x) {
  stop("Unsupported class:", paste(class(x), collapse=", "))
}

tree_node.rmd_yaml = function(x) {
  list(
    text = "YAML",
    label = paste0("[", length(x)," lines]")
  )
}

tree_node.rmd_yaml_list = function(x) {
  tree_node.rmd_yaml(unlist(x))
}

tree_node.rmd_heading = function(x) {
  list(
    text = "Heading",
    label = paste0("[h", x$level, "] - ",  cli::style_bold(x$name))
  )
}

tree_node.rmd_chunk = function(x) {
  name = if (x$name != "") cli::style_bold(x$name)
         else cli::style_italic("<unnamed>")

  opt = if (length(x$options) == 1) "1 opt, "
        else if (length(x$options) != 0) paste0(length(x$options), " opts, ")
        else ""

  list(
    text = "Chunk",
    label = paste0("[", x$engine, ", ", opt, length(x$code), " lines] - ", name)
  )
}

tree_node.rmd_raw_chunk = function(x) {
  list(
    text = "Raw Attr Chunk",
    label = paste0("[", x$format, ", ", length(x$code), " lines]")
  )
}

tree_node.rmd_markdown = function(x) {
  list(
    text = "Markdown",
    label = paste0("[", length(x), " lines]")
  )
}

tree_node.rmd_fenced_div_open = function(x) {
  list(
    text = "Open Fenced div",
    label = paste0("[", paste(x, collapse=", "), "]")
  )
}

tree_node.rmd_fenced_div_close = function(x) {
  list(
    text = "Close Fenced div",
    label = ""
  )
}

tree_node.rmd_shortcode = function(x) {
  list(
    text = "Shortcode",
    label = paste0(
      "[",
      cli::style_bold(x$func),
      paste0(" ", x$args, collapse="") ,
      "]"
    )
  )
}

is_heading = function(x) {
  inherits(x, "rmd_heading")
}

scale_levels = function(x) {
  levels = as.character(sort(unique(x)))

  lookup = seq_along(levels)
  names(lookup) = levels

  res = lookup[as.character(x)]
  names(res) = NULL

  res - 1
}

get_nesting_levels = function(ast) {
  levels = 0
  node_levels = integer()
  fdiv_depth = 0


  for(node in ast) {
    if (is_heading(node)) {
      levels = levels[levels < node$level]
    }

    if (inherits(node, "rmd_fenced_div_close")) {
      fdiv_depth = fdiv_depth - 1
    }

    node_levels = append(node_levels, max(levels) + fdiv_depth)

    if (is_heading(node)) {
      levels = append(levels, node$level)
    }

    if (inherits(node, "rmd_fenced_div_open")) {
      fdiv_depth = fdiv_depth + 1
    }
  }

  scale_levels(node_levels)
}

has_sibling = function(level, remaining) {
    next_cur_level    = min(which(level == remaining), Inf) # next occurrence of the same heading level
    next_higher_level = min(which(level >  remaining), Inf) # next occurrence of a higher level heading

    next_cur_level < next_higher_level
}

#' @exportS3Method
print.rmd_ast = function(x, use_headings = TRUE, ...) {
  print_tree(x, use_headings)
}


print_tree = function(ast, use_headings = TRUE) {
  ch = box_chars()

  indent_width = 4

  empty_space = "    "
  child_space = pc(ch$v, "   ")
  mid_leaf = pc(ch$j, ch$h, ch$h, " ")
  end_leaf = pc(ch$l, ch$h, ch$h, " ")

  if (use_headings)
    nesting_levels = get_nesting_levels(ast)
  else
    nesting_levels = rep(0, length(ast))

  prev_level = 0
  indent = ""
  prev_sibs = FALSE

  for(j in seq_along(ast)) {
    cur_node = ast[[j]]
    next_node = ast[j+1][[1]]

    details = tree_node(cur_node)

    sibs = has_sibling(nesting_levels[j], nesting_levels[-(1:j)])


    if (!sibs)
      prefix = end_leaf
    else
      prefix = mid_leaf

    if (nesting_levels[j] > prev_level) {
      if (prev_sibs)
        indent = paste0(indent, child_space)
      else
        indent = paste0(indent, empty_space)
    } else if (nesting_levels[j] < prev_level) {
      indent = substr(indent, 1, indent_width*nesting_levels[j])
    }

    cli::cat_line(
      indent,
      prefix,
      details$text, " ", cli::col_grey(details$label)
    )

    prev_level = nesting_levels[j]
    prev_sibs = sibs
  }

}

# These are derived from https://github.com/r-lib/cli/blob/e9acc82b0d20fa5c64dd529400b622c0338374ed/R/tree.R#L111
box_chars = function() {
  if (is_utf8_output()) {
    list(
      "h" = "\u2500",
      "v" = "\u2502",
      "l" = "\u2514",
      "j" = "\u251C"
    )
  } else {
    list(
      "h" = "-",                        # horizontal
      "v" = "|",                        # vertical
      "l" = "\\",
      "j" = "+"
    )
  }
}



is_latex_output = function() {
  if (!("knitr" %in% loadedNamespaces())) return(FALSE)
  get("is_latex_output", asNamespace("knitr"))()
}

is_utf8_output = function() {
  opt = getOption("cli.unicode", NULL)
  if (!is.null(opt)) {
    isTRUE(opt)
  } else {
    l10n_info()$`UTF-8` && !is_latex_output()
  }
}
