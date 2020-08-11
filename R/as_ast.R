#' @export
as_ast = function(obj, ...) {
  UseMethod("as_ast")
}

#' @export
as_ast.default = function(obj, ...) {
  stop("Unsupports type:", class(obj))
}

#' @export
as_ast.tbl_df = function(df) {
  as_ast.data.frame(df)
}

#' @export
as_ast.data.frame = function(df) {

  checkmate::assert_names(
    names(df),
    subset.of = c(paste0("sec_h", 1:6), c("type","data")),
    must.include = c("type","data")
  )


  df = dplyr::select(df, -type)
  df = dplyr::mutate(
    df,
    data = lapply(data, list), # We need this since we'll be concating lists together later
    order = seq_len(dplyr::n())
  )

  for(i in 6:1) {
    sec = paste0("sec_h", i)
    if (!sec %in% names(df))
      next

    # Group elements under the same heading
    df = dplyr::group_by(df, dplyr::across(dplyr::starts_with("sec")))
    df = dplyr::summarize(
      df,
      data = list(do.call(c, data)),
      #  c(list(), data) # Make sure it is a list
      #),
      order = min(order),
      .groups = "drop"
    )
    df = dplyr::arrange(df, order)

    # Insert heading at the top of the elements and drop column

    df = dplyr::mutate(
      df,
      data = purrr::map2(
        .data[[sec]], .data[["data"]],
        function(name, data) {
          if (is.na(name)) {
            data
          } else {
            c(list(create_heading(name = name, level = i)), data)
          }
        }
      )
    )
    df = dplyr::select(df, -dplyr::any_of(sec))
  }

  structure(
    do.call(c, df$data),
    class = "rmd_ast"
  )
}
