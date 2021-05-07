#' @name rmd_source
#' @rdname rmd_source
#'
#' @title Source the code chunks of an Rmd document
#'
#' @description This is the equivalent of the [source()] function for Rmd files or
#' their resulting asts.
#'
#' @param x An Rmd document (e.g. `rmd_ast`, `rmd_tibble`, Rmd file path, etc.)
#' @param local `TRUE`, `FALSE` or an environment, determining where the parsed
#'   expressions are evaluated. `FALSE` (the default) corresponds to the user's
#'   workspace (the global environment) and `TRUE` to the environment from which
#'   source is called.
#' @param ... Additional arguments passed to [`source`].
#' @param label_comment Attach chunk labels as comment before each code block.
#' @param use_eval Use the `eval` chunk option to determine if code is included.
#'
#' @return Returns the result of [source()] for any R code chunks.
#'
#' @examples
#'
#' rmd_source(system.file("minimal.Rmd", package = "parsermd"), echo=TRUE)
#'
#' @export
#'
rmd_source = function(x, local = FALSE, ..., label_comment = TRUE, use_eval = TRUE) {
  UseMethod("rmd_source")
}

#' @exportS3Method
rmd_source.default = function(x, local, ..., label_comment, use_eval) {
  stop("Unsupported type")
}

#' @exportS3Method
rmd_source.character = function(x, local = FALSE, ..., label_comment = TRUE, use_eval = TRUE) {
  rmd_source(
    parse_rmd(x),
    local = local,
    ...,
    label_comment = label_comment,
    use_eval = use_eval
  )
}

#' @exportS3Method
rmd_source.rmd_tibble = function(x, local = FALSE, ..., label_comment = TRUE, use_eval = TRUE) {
  rmd_source(
    as_ast(x),
    local = local,
    ...,
    label_comment = label_comment,
    use_eval = use_eval
  )
}

#' @exportS3Method
rmd_source.rmd_ast = function(x, local = FALSE, ..., label_comment = TRUE, use_eval = TRUE) {

  if (isTRUE(local))
    local = parent.frame(n = 1) # needed because of S3

  opts = list(...)
  if (!is.null(opts$file))
    stop("`file` argument cannot be used.")

  x = rmd_select(x, has_type("rmd_chunk"))

  label = rmd_node_label(x)
  engine = rmd_node_engine(x)

  other = engine != "r"
  if (any(other)) {
      problem = paste(label[other], " (", engine[other]  ,")",
                      sep="", collapse = ", ")
      warning("Following chunks do not use R and are being excluded: ", problem,
              call. = FALSE)

      x = x[!other]
  }

  # TODO - make this more robust, grab defaults from knitr?
  eval = rmd_get_options(x, "eval", defaults = list("eval" = TRUE)) %>%
    unlist() %>%
    as.logical()

  # Subset for just the `eval=TRUE` chunks
  if (use_eval)
    x = x[eval]

  label = rmd_node_label(x)
  code = rmd_node_code(x) %>%
    purrr::map_chr(paste, collapse="\n")

  if (label_comment)
    code = paste(
      paste0("## ---- ", label, " ------------------------------"),
      code,
      sep = "\n\n"
    )

  code = paste0(
    paste(code, collapse = "\n\n\n"),
    "\n\n" # Trailing whitespace
  )

  source(local = local, exprs = parse(text = code), ...)
}
