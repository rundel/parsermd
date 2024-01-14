#' @keywords internal
"_PACKAGE"


## usethis namespace: start
#' @useDynLib parsermd, .registration = TRUE
#' @importFrom Rcpp sourceCpp
#' @importFrom rlang .data
#' @importFrom magrittr %>%
## usethis namespace: end
NULL


#' @export
magrittr::`%>%`

`%||%` = function (x, y) {
  if (is.null(x)) y
  else            x
}
