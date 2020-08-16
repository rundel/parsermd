# These are early proof of concept implementations, they will
# likely eventually live in the checklist package


#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`



collapse_sections = function(df, drop_na = TRUE) {
  df = select(df, dplyr::starts_with("sec"))

  secs = purrr::pmap(
    df,
    function(...)
      as.character(list(...))
  )

  if (drop_na)
    secs = purrr::map(secs, ~ .x[!is.na(.x)])

  secs
}

gen_chunk_sec_df = function(df) {
  df = dplyr::filter(df, type == "rmd_chunk")

  tibble::tibble(
    chunk = purrr::map_chr(df$data, "name", .default=NA),
    sec = collapse_sections(df)
  )
}


list_equal = function(elem, list) {
  purrr::map_lgl(list, ~ identical(.x, elem))
}

# chunk_ref options
# scalar - does a chunk with that name exist
# vector - last entry is chunk name, others are heading names
# list - collection of the former options



#' @export
has_chunk = function(df, chunk_ref) {
  chunk_sec_df = gen_chunk_sec_df(df)

  if (!is.list(chunk_ref))
    chunk_ref = list(chunk_ref)

  purrr::map_lgl(
    chunk_ref,
    function(chunk_ref) {
      checkmate::check_character(chunk_ref, any.missing = FALSE,min.len=1)

      n = length(chunk_ref)
      if (n == 1) { # Directly referencing chunk
        chunk_ref %in% chunk_sec_df$chunk
      } else {
        chunk = chunk_ref[n]
        sections = chunk_ref[-n]

        any(
          (chunk == chunk_sec_df$chunk) &
          (list_equal(sections, chunk_sec_df$sec))
        )
      }
    }
  )
}

