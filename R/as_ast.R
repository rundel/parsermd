#' @title Convert an object into an `rmd_ast`.
#'
#' @description
#' Currently only supports conversion of `rmd_tibble` objects back to `rmd_ast`.
#'
#' @param x Object to convert
#' @param ... Unused, for extensibility.
#'
#' @examples
#' parse_rmd(system.file("examples/hw01.Rmd", package="parsermd")) %>%
#'   as_tibble() %>%
#'   as_ast()
#'
#' @return Returns an `rmd_ast` object.
#'
#' @export
as_ast = function(x, ...) {
  UseMethod("as_ast")
}

#' @exportS3Method
as_ast.default = function(x, ...) {
  stop("Unsupported class: ", paste0(class(x), collapse = ", "))
}

#' @exportS3Method
as_ast.rmd_tibble = function(x, ...) {
  x[["ast"]]
}

fix_heading_level = function(ast, name) {
  levels = unlist(rmd_node_attr(ast, "level")) %||% 2 # default to 2 if no heading
  min_level = min(levels)
  max_level = max(levels)

  if (min_level == 1 && max_level == 6) {
    cli::cli_warn(
      c("{.file {name}} uses heading levels 1 and 6, unable to offset headings when combining ASTs.")
    )
  } else if (min_level == 1 && max_level < 6) {
    ast = purrr::map(
      ast,
      function(node) {
        if (inherits(node, "rmd_heading")) {
          node[["level"]] = node[["level"]] +1
        }
        node
      }
    ) %>%
      magrittr::set_class("rmd_ast")
  }
  ast
}

#' @exportS3Method
as_ast.rmd_collection = function(
    x, ..., strip_yaml = TRUE, filename_headings = TRUE,
    adjust_headings = TRUE, front_matter = NULL, collapse = NULL
) {

  if (strip_yaml)
    x = rmd_select(x, !has_type(c("rmd_yaml_list", "rmd_yaml")))

  if (adjust_headings) {
    x[["ast"]] = purrr::map2(
      x[["ast"]], x[["name"]],
      fix_heading_level
    )
  }

  if (filename_headings) {
    x[["ast"]] = purrr::map2(
      x[["ast"]], x[["name"]],
      function(ast, name) {
        c(list(rmd_heading(name, 1)), ast) %>%
          magrittr::set_class("rmd_ast")
      }
    )
  }

  if (!is.null(collapse)) {
    x[["ast"]] = c(
      x[["ast"]][1],
      purrr::map(
        x[["ast"]][-1], function(ast) c(list(collapse), ast)
      )
    )
  }

  ast = unlist(x[["ast"]], recursive = FALSE)
  if (!is.null(front_matter))
    ast = c(list(front_matter), ast)

  magrittr::set_class(ast, "rmd_ast")
}

#' @exportS3Method
as_ast.qmd_collection = function(
    x, ..., strip_yaml = TRUE, filename_headings = TRUE,
    adjust_headings = TRUE, front_matter = NULL, collapse = NULL
) {
  as_ast.rmd_collection(
    x, ..., strip_yaml = strip_yaml, filename_headings = filename_headings,
    adjust_headings = adjust_headings, front_matter = front_matter, collapse = collapse
  )
}


