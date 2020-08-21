is_section_match = function(secs, regex) {
  if (length(secs) != length(regex))
    return(FALSE)

  all(purrr::map2_lgl(regex, secs, grepl))
}

match_sections = function(secs, regex) {
  checkmate::check_character(regex, min.len = 1, all.missing = FALSE)

  if (!is.list(secs))
    secs = list(secs)

  purrr::map_lgl(secs, is_section_match, regex = regex)
}


#' @export
get_chunk = function(obj, chunk_ref) {
  UseMethod("get_chunk")
}

#' @export
get_chunk.default = function(obj, chunk_ref) {
  stop("Unable to get chunks in an object with class: ", class(obj))
}

#' @export
get_chunk.rmd_ast = function(obj, chunk_ref) {
  as_ast(get_chunk(as_tibble(obj), chunk_ref))
}

#' @export
get_chunk.rmd_tibble = function(df, chunk_ref) {
  checkmate::check_character(chunk_ref, min.len=1, any.missing = FALSE)

  chunk_regex = utils::glob2rx(chunk_ref)

  df = dplyr::filter(df, type == "rmd_chunk")
  chunk_names =  purrr::map_chr(df$data, get_name)

  n = length(chunk_ref)
  if (n == 1) { # Directly referencing chunk
    dplyr::filter(df, grepl(chunk_regex, chunk_names))
  } else {
    # Last element is assumed to be the chunk regex, everything else is a section regex
    section_regex = chunk_regex[-n]
    chunk_regex = chunk_regex[n]

    secs = collapse_sections(df)

    dplyr::filter(df, match_sections(secs, section_regex), grepl(chunk_regex, chunk_names))
  }
}


