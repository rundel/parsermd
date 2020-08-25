#' @export
get_name = function(obj) {
  UseMethod("get_name")
}

#' @export
get_name.list = function(l) {
  purrr::map_chr(l, get_name)
}

#' @export
get_name.default = function(obj) {
  NA_character_
}

#' @export
get_name.rmd_chunk = function(obj) {
  name = obj[["name"]]

  if (name == "" & !is.null(obj[["options"]][["label"]]))
    name = obj[["options"]][["label"]]

  if (is.null(name))
    name = NA_character_

  name
}

collapse_sections = function(df, drop_na = TRUE) {
  df = dplyr::select(df, dplyr::starts_with("sec"))

  cols = grepl("sec_h[1-6]", names(df))
  if (!all(cols))
    stop("Unexpected column(s): ", names(df)[!cols], call. = FALSE)

  stopifnot(all())

  secs = purrr::pmap(df, function(...) as.character(list(...)))

  if (drop_na)
    secs = purrr::map(secs, ~ .x[!is.na(.x)])

  secs
}

is_section_match = function(secs, regex) {
  if (length(secs) > length(regex)) {
    # Handle the case where we want to select a parent section
    secs = secs[seq_along(regex)]
  } else if (length(secs) < length(regex)) {
    return(FALSE)
  }

  all(purrr::map2_lgl(regex, secs, grepl))
}

match_sections = function(secs, regex) {
  checkmate::check_character(regex, min.len = 1, any.missing = FALSE)

  if (!is.list(secs))
    secs = list(secs)

  purrr::map_lgl(secs, is_section_match, regex = regex)
}

#' @export
name_subset = function(names, ref) {
  checkmate::check_character(names, min.len = 1, any.missing = FALSE)
  checkmate::check_character(ref, len = 1, any.missing = FALSE)

  grepl(utils::glob2rx(ref), names)
}

#' @export
sec_subset = function(secs, ref) {
  checkmate::check_character(ref, len = 1, any.missing = FALSE)
  checkmate::check_list(secs, types = "character", min.len = 1)

  purrr::map_lgl(secs, is_section_match, regex = utils::glob2rx(ref))
}

#' @export
comb_subset = function(df, sec_refs = NULL, name_refs = NULL) {

  if (!is.list(sec_refs))
    sec_refs = list(sec_refs)

  checkmate::check_list(sec_refs, types = "character", min.len = 1, null.ok = TRUE, any.missing = FALSE)
  checkmate::check_character(name_refs, min.len = 1, any.missing = FALSE,  null.ok = TRUE)

  if (is.null(name_refs)) # so the map2 below works correctly
    name_refs = list(NULL)

  secs = collapse_sections(df)
  names = get_name(df$data)

  purrr::map2(
    sec_refs, name_refs,
    function(sec_ref, name_ref) {
      subset = TRUE
      if (!is.null(sec_ref))
        subset = subset & sec_subset(secs, sec_ref)

      if (!is.null(name_ref))
        subset = subset & name_subset(names, name_ref)

      subset
    }
  )
}





