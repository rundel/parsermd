#' Stuff
#'
#' @name parsermd-package
#' @aliases parsermd
#' @docType package
#' @title Stuff
#' @author Colin Rundel \email{rundel@gmail.com}
#' @keywords package
NULL

## usethis namespace: start
#' @useDynLib parsermd, .registration = TRUE
#' @importFrom Rcpp sourceCpp
## usethis namespace: end
NULL

#' @importFrom rlang .data
NULL

#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

`%||%` = function (x, y) {
  if (is.null(x)) y
  else            x
}
