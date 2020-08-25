#' @importFrom tibble as_tibble
#' @export
tibble::as_tibble

#' @export
as.data.frame.rmd_ast = function(ast, include_yaml = TRUE) {
  as_tibble.rmd_ast(ast, include_yaml)
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

  cur_level = 0
  has_node = FALSE
  i=1
  for(j in seq_along(ast)) {
    x = ast[[j]]
    if (inherits(x, "rmd_heading")) {

      if (cur_level >= x$level & !has_node) {
        # Handle the case of previous section has no markdown or chunks

        section[[i]] = sections
        type[i] = "rmd_empty"
        data[i] = list(NULL)

        i = i+1
      }

      stopifnot(x$level %in% 1:6)

      sections[x$level:6] = NA_character_
      sections[x$level] = x$name

      max_sec_level = max(max_sec_level, x$level)
      min_sec_level = min(min_sec_level, x$level)

      cur_level = x$level
      has_node = FALSE
      next
    }

    section[[i]] = sections
    type[i] = class(x)
    data[[i]] = x

    i = i+1
    has_node=TRUE
  }

  if (!has_node) {
    # Handle the case of final section has no markdown or chunks
    section[[i]] = sections
    type[i] = "rmd_empty"
    data[i] = list(NULL)

    i = i+1
  }

  section = lapply(section, function(s) s[min_sec_level:max_sec_level])

  res = tidyr::unnest_wider(
    tibble::as_tibble(
      list(section=section, type=type, data=data)
    ),
    section
  )

  #class(res$data) = "rmd_ast_col"
  class(res) = c("rmd_tibble", class(res))

  res
}


#' @importFrom pillar type_sum
#' @export
#'
pillar::type_sum

#' @export
type_sum.rmd_chunk = function(x) {
  paste(
    cli::style_bold("chunk"),
    cli::style_italic('"', x$name, '"')
  )
}

#' @export
type_sum.rmd_yaml = function(x) {
  paste(
    cli::style_bold("yaml"),
  )
}

#' @export
type_sum.rmd_yaml_list = function(x) {
  paste(
    cli::style_bold("yaml")
  )
}

#' @export
type_sum.rmd_markdown = function(x) {
  cli::style_bold("markdown")
}
