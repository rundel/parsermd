#' @export
parse_rmd = function(rmd) {
  checkmate::assert_character(rmd, len = 1, any.missing = FALSE)

  if (file.exists(rmd))
    rmd = readr::read_file(rmd)

  parse_rmd_cpp(rmd)
}

#' @export
as_tibble.rmd_ast = function(ast, include_yaml = TRUE) {

  if (!include_yaml & inherits(ast[[1]], "rmd_yaml"))
    ast = ast[-1]

  sections = rep(NA_character_, 6)
  names(sections) = paste0("sec_h", 1:6)

  min_sec_level = 6
  max_sec_level = 1


  section = list()
  type = character()
  data = list()

  i=1
  for(j in seq_along(ast)) {
    x = ast[[j]]
    if (inherits(x, "rmd_heading")) {
      sections[x$level] = x$name

      if (x$level > max_sec_level) max_sec_level = x$level
      if (x$level < min_sec_level) min_sec_level = x$level

      next
    }

    section[[i]] = sections
    type[i] = class(x)
    data[[i]] = x

    i = i+1
  }

  section = lapply(section, function(s) s[min_sec_level:max_sec_level])

  tidyr::unnest_wider(
    tibble::as_tibble(
      list(section=section, type=type, data=data)
    ),
    section
  )
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
