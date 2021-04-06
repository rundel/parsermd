#' @title Subset the nodes of an rmd object
#' @description
#' `r lifecycle::badge('deprecated')`
#' Subset an rmd object based on sections, node types, or names.
#'
#' @param x rmd object, e.g. `rmd_ast` or `rmd_tibble`.
#' @param sec_refs Section references, TODO - add details.
#' @param type_refs Node type references, TODO - add details.
#' @param name_refs Name references, TODO - add details.
#' @param exclude Should the matching nodes be excluded.
#' @param keep_yaml Should the document yaml be kept.
#' @param keep_setup Should the document setup chunk be kept.
#' @param ... Unused, for extensibility.
#'
#' @export
rmd_subset = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, exclude = FALSE, keep_yaml = TRUE, keep_setup = FALSE, ...) {
  lifecycle::deprecate_soft("0.0.2", "rmd_subset()", "rmd_select()")
  UseMethod("rmd_subset")
}

#' @export
rmd_subset.default = function(x, ...) {
  stop("Unable to subset an object with class: ", class(x))
}

#' @export
rmd_subset.rmd_ast = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, exclude = FALSE, keep_yaml = TRUE, keep_setup = FALSE, ...) {
  subset = comb_subset(x, sec_refs, type_refs, name_refs, combine = `|`, inc_parents = !exclude)

  if (exclude)
    subset = !subset

  if (keep_setup) {
    labels = rmd_node_label(x)
    subset = subset | (labels == "setup" & !is.na(labels))
  }

  if (keep_yaml) {
    subset = subset | (rmd_node_type(x) %in% c("rmd_yaml", "rmd_yaml_list"))
  }

  x = x[subset]
  class(x) = c("rmd_ast", "list")

  x
}

#' @export
rmd_subset.rmd_tibble = function(x, sec_refs = NULL, type_refs = NULL, name_refs = NULL, exclude = FALSE, keep_yaml = TRUE, keep_setup = FALSE, ...) {
  sec_cols = names(x)[grepl("^sec_h", names(x))]
  bad_cols = sec_cols[!sec_cols %in% paste0("sec_h", 1:6)]

  if (length(bad_cols) != 0)
      stop("The following columns must be renamed: ", bad_cols, call. = FALSE)

  subset = comb_subset(x$ast, sec_refs, type_refs, name_refs, combine = `|`, inc_parents = !exclude)

  if (exclude)
    subset = !subset

  if (keep_setup) {
    labels = rmd_node_label(x$ast)
    subset = subset | (labels == "setup" & !is.na(labels))
  }

  if (keep_yaml) {
    subset = subset | (rmd_node_type(x$ast) %in% c("rmd_yaml", "rmd_yaml_list"))
  }

  x = x[subset,]

  x = dplyr::bind_cols(
    dplyr::bind_rows(rmd_node_sections(x$ast)),  # add new sec_h* columns
    dplyr::select(x, -dplyr::starts_with("sec_h")) # drop old sec_h* columns
  )
  class(x) = c("rmd_tibble", class(x))

  x
}


