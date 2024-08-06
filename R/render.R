arg_var_name = function(x, default = "Untitled") {
  if (is.symbol(x))
    deparse(x)
  else
    default
}

#' @name render
#' @rdname render

#' @title Render `parsermd` objects
#' @description
#' Object contents are converted to a character vector and written to a
#' temporary directory before rendering via [quarto::quarto_render()] or [rmarkdown::render()].
#'
#' Note that this function has the potential to overwrite existing output
#' files (e.g. `.html`, `.pdf`, etc).
#'
#' @param x Object to render, e.g. a `rmd_ast`, `rmd_tibble`, `character` vector, etc.
#' @param name Name of the output file, if not given it will be inferred from the
#' name of `x`.
#' @param ... Any additional arguments to be passed to [quarto::quarto_render()] or [rmarkdown::render()]
#' @param engine The rendering engine to use, either "quarto" or "rmarkdown".
#'
#' @return Returns the results of the render function.
#'
#' @export
render = function(x, name = NULL, ..., engine = c("quarto", "rmarkdown")) {
  if (is.null(name))
    render(x, arg_var_name(substitute(x)), ..., engine = engine)
  else
    UseMethod("render")
}

#' @exportS3Method
render.default = function(x, name, ..., engine = c("quarto", "rmarkdown")) {
  classes = paste(class(x), collapse = ", ")
  stop("This function does not support class: ", classes)
}

#' @exportS3Method
render.character = function(x, name, ..., engine = c("quarto", "rmarkdown")) {
  engine = match.arg(engine)

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

  if (engine == "rmarkdown") {
    if (!grepl("\\.[Rr]md$", name))
      name = paste0(name, ".Rmd")

    dir = withr::local_tempdir(pattern = "parsermd")
    path = file.path(dir, name)

    readr::write_file(x, path)

    args = list(...)
    args[["input"]] = path

    if (is.null(args[["output_dir"]]))
      args[["output_dir"]] = path.expand("./")

    invisible(do.call(rmarkdown::render, args))
  } else {
    if (!grepl("\\.qmd$", name))
      name = paste0(name, ".qmd")

    dir = getwd()
    path = file.path(dir, name)

    if (file.exists(path)) {
      stop("File already exists: ", name, call. = FALSE)
    }

    readr::write_file(x, path)

    args = list(...)
    args[["input"]] = path

    res = do.call(quarto::quarto_render, args)

    unlink(path)

    invisible(res)
  }
}

#' @exportS3Method
render.rmd_tibble = function(x, name, ..., engine = c("quarto", "rmarkdown")) {
  render.character(as_document(x), name, ..., engine=engine)
}

#' @exportS3Method
render.rmd_ast = function(x, name, ..., engine = c("quarto", "rmarkdown")) {
  render.character(as_document(x), name, ..., engine=engine)
}

#' @exportS3Method
render.qmd_collection = function(x, name, ..., engine = "quarto") {
  render(as_ast(x), name, ..., engine=engine)
}

#' @exportS3Method
render.rmd_collection = function(x, name, ..., engine = "rmarkdown") {
  render(as_ast(x), name, ..., engine=engine)
}
