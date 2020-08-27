#' @export
rmd_subset = function(obj, ...) {
  UseMethod("rmd_subset")
}

#' @export
rmd_subset.default = function(obj, ...) {
  stop("Unable to subset an object with class: ", class(obj))
}

#' @export
rmd_subset.rmd_ast = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL, exclude = FALSE) {
  subset = comb_subset(ast, sec_refs, type_refs, name_refs, combine = `|`)

  if (exclude)
    subset = !subset

  do.call(create_ast, ast[subset])
}

#' @export
rmd_subset.rmd_tibble = function(df, sec_refs = NULL, type_refs = NULL, name_refs = NULL, exclude = FALSE) {
  subset = comb_subset(df$ast, sec_refs, type_refs, name_refs, combine = `|`)

  if (exclude)
    subset = !subset

  df[subset, ]
}


