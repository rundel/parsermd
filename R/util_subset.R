

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

match_sections = function(secs, regex) {
  checkmate::check_character(regex, min.len = 1, any.missing = FALSE)

  if (!is.list(secs))
    secs = list(secs)

  purrr::map_lgl(secs, is_section_match, regex = regex)
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

type_subset = function(types, ref) {
  checkmate::check_character(ref, min.len = 1, any.missing = FALSE)
  checkmate::check_character(types, min.len = 1, any.missing = FALSE)

  types %in% ref
}


#' @export
comb_subset = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL, combine = NULL) {
  checkmate::check_class(ast, "rmd_ast")
  checkmate::check_function(combine, null.ok = TRUE)

  if (!is.list(sec_refs))
    sec_refs = list(sec_refs)

  if (is.null(type_refs)) # so the map2 below works correctly
    type_refs = list(NULL)

  if (is.null(name_refs)) # so the map2 below works correctly
    name_refs = list(NULL)

  secs = rmd_node_sections(ast)
  names = rmd_node_name(ast)
  types = rmd_node_type(ast)

  subset = purrr::pmap(
    list(sec_refs, type_refs, name_refs),
    function(sec_ref, type_ref, name_ref) {
      subset = TRUE
      if (!is.null(sec_ref))
        subset = subset & sec_subset(secs, sec_ref)

      if (!is.null(type_ref))
        subset = subset & sec_subset(types, type_ref)

      if (!is.null(name_ref))
        subset = subset & name_subset(names, name_ref)

      subset
    }
  )

  if (!is.null(combine))
    subset = purrr::reduce(subset, combine)

  subset
}





