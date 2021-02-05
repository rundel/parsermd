arg_var_name = function(x, default = "Untitled") {
  if (is.symbol(x))
    deparse(x)
  else
    default
}

#' @name render
#' @rdname render

#' @title Render `parsermd` objects using [rmarkdown::render()]
#' @description
#' Object contents are converted to a character vector and written to a
#' temporary directory before rendering.
#'
#' Note that this function has the potential to overwrite existing output
#' files (e.g. `.html`, `.pdf`, etc).
#'
#' @param x Object to render, e.g. a `rmd_ast`, `rmd_tibble`, `character` vector, etc.
#' @param name Name of the output file, if not given it will be inferred from the
#' name of `x`.
#' @param ... Any additional arguments to be passed to [rmarkdown::render()]
#'
#' @export
render = function(x, name = NULL, ...) {
  if (is.null(name))
    render(x, arg_var_name(substitute(x)), ...)
  else
    UseMethod("render")
}

#' @exportS3Method
render.default = function(x, name, ...) {
  classes = paste(class(x), collapse = ", ")
  stop("This function does not support class: ", classes)
}

#' @exportS3Method
render.character = function(x, name, ...) {
  # Check if x is a path
  if (length(x) == 1 && !grepl("\n", x) && file.exists(x)) {
    # If no name replace with input name
    if (name == "Untitled")
      name = gsub("\\..*$", "", basename(x))

    x = readLines(x)
  }

  x = paste(x, collapse = "\n")

  if (name == ".") # can occur due to pipe usage
    name = "Untitled"

  if (!grepl("\\.[Rr]md$", name))
    name = paste0(name, ".Rmd")

  dir = withr::local_tempdir(pattern = "parsermd")
  path = file.path(dir, name)

  readr::write_file(x, path)

  args = list(...)
  args[["input"]] = path
  if (is.null(args[["output_dir"]]))
    args[["output_dir"]] = path.expand("./")

  do.call(rmarkdown::render, args)
}

#' @exportS3Method
render.rmd_tibble = function(x, name, ...) {
  render.character(as_document(x), name, ...)
}

#' @exportS3Method
render.rmd_ast = function(x, name, ...) {
  render.character(as_document(x), name, ...)
}
