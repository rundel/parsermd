# These are early proof of concept implementations and are likely to change

collapse_sections = function(df, drop_na = TRUE) {
  df = dplyr::select(df, dplyr::starts_with("sec"))

  secs = purrr::pmap(
    df,
    function(...)
      as.character(list(...))
  )

  if (drop_na)
    secs = purrr::map(secs, ~ .x[!is.na(.x)])

  secs
}

get_name = function(obj) {
  UseMethod("get_name")
}

#' @export
get_name.default = function(obj) {
  NA_character_
}

#' @export
get_name.rmd_chunk = function(obj) {
  name = obj[["name"]]

  if (is.null(name))
    name = obj[["options"]][["label"]]

  if (is.null(name))
    name = NA_character_

  name
}



gen_chunk_sec_df = function(df) {
  df = dplyr::filter(df, type == "rmd_chunk")

  tibble::tibble(
    chunk = purrr::map_chr(df$data, get_name),
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
has_chunk = function(obj, chunk_ref) {
  UseMethod("has_chunk")
}

#' @export
has_chunk.default = function(obj, chunk_ref) {
  stop("Unable to check for chunks in an object with class: ", class(obj))
}

#' @export
has_chunk.rmd_ast = function(obj, chunk_ref) {
  has_chunk(as_tibble(obj), chunk_ref)
}

#' @export
has_chunk.rmd_tibble = function(df, chunk_ref) {
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

