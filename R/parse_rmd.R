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

