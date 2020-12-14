arg_var_name = function(x, default = "Untitled") {
  if (is.symbol(x))
    deparse(x)
  else
    default
}

#' @name render
#' @rdname render

#' @title Render `parsermd` objects using [rmarkdown::render()]
#'
#' Object contents are converted to a character vector and written to a
#' temporary directory before rendering.
#'
#' Note that this function has the potential to overwrite existing output
#' files (e.g. `.html`, `.pdf`, etc).
#'
#' @param obj Object to render, e.g. a `rmd_ast`, `rmd_tibble`, `character` vector, etc.
#' @param name Name of the output file, if not given it will be infered from the
#' name of `obj`.
#' @param ... Any additional arguments to be passed to [rmarkdown::render()]
#'
#' @export
render = function(obj, name = NULL, ...) {
  if (is.null(name))
    render(obj, arg_var_name(substitute(obj)), ...)
  else
    UseMethod("render")
}

#' @exportS3Method
render.default = function(obj, name, ...) {
  stop("This function does not support class:", class(obj))
}

#' @exportS3Method
render.character = function(txt, name, ...) {
  # Check if txt is a path
  if (length(txt) == 1 && !grepl("\n", txt) && file.exists(txt)) {
    # If no name replace with input name
    if (name == "Untitled")
      name = gsub("\\..*$", "", basename(txt))

    txt = readLines(txt)
  }

  txt = paste(txt, collapse = "\n")

  if (!grepl("\\.[Rr]md$", name))
    name = paste0(name, ".Rmd")

  dir = withr::local_tempdir(pattern = "parsermd")
  path = file.path(dir, name)

  readr::write_file(txt, path)

  args = list(...)
  args[["input"]] = path
  if (is.null(args[["output_dir"]]))
    args[["output_dir"]] = path.expand("./")

  do.call(rmarkdown::render, args)
}

#' @exportS3Method
render.rmd_tibble = function(tbl, name, ...) {
  render.character(as_document(tbl), name, ...)
}

render.rmd_ast = function(ast, name, ...) {
  render.character(as_document(ast), name, ...)
}
