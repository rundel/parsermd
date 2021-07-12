collapse_sections = function(rmd_tbl, drop_na = TRUE) {
  checkmate::check_class(rmd_tbl, "rmd_tibble")

  rmd_tbl$secs = purrr::pmap(
    dplyr::select(rmd_tbl, dplyr::starts_with("sec_h")),
    function(...) as.character(list(...))
  )

  if (drop_na)
    rmd_tbl$secs = purrr::map(rmd_tbl$secs, ~ .x[!is.na(.x)])

  rmd_tbl = dplyr::select(rmd_tbl, -dplyr::starts_with("sec_h"))

  dplyr::relocate(rmd_tbl, .data[["secs"]])
}
