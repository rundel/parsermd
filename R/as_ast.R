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
as_ast.rmd_collection = function(x, ...) {
  purrr::map2(
    x[["name"]], x[["ast"]],
    function(name, ast) {
      c(
        list(create_heading(name, 1)),
        rmd_select(ast, !has_type(c("rmd_yaml_list", "rmd_yaml"))) %>%
          fix_heading_level(name)
      ) %>%
        magrittr::set_class("rmd_ast")
    }
  ) %>%
    unlist(recursive = FALSE) %>%
    magrittr::set_class("rmd_ast")
}

#' @exportS3Method
as_ast.qmd_collection = function(x, ...) {
  as_ast.rmd_collection(x, ...)
}


