#' @export
rmd_check_template = function(rmd, template) {
  UseMethod("rmd_check_template")
}

#' @export
rmd_check_template.default = function(rmd, template) {
  stop("Unable to check an Rmd template for an object with class: ", class(rmd))
}

#' @export
rmd_check_template.character = function(rmd, template) {
  rmd = as_tibble(parse_rmd(rmd))
  rmd_check_template( rmd = rmd, template = template )
}

#' @export
rmd_check_template.rmd_ast = function(rmd, template) {
  rmd_check_template( rmd = as_tibble(rmd), template = template )
}



#' @export
rmd_check_template.rmd_tibble = function(rmd, template, check_headings = FALSE) {
  inc_content = ("content" %in% names(template))

  if (!check_headings) {
    template = dplyr::filter(template, type != "rmd_heading")
  }

  rmd_tbl = rmd_template(rmd, inc_content = inc_content)

  missing_nodes = check_missing(rmd_tbl, template)
  unmodified_nodes = check_unmodified(rmd_tbl, template)

  if (nrow(missing_nodes) == 0 & nrow(unmodified_nodes) == 0){
    cli::cli_alert_success("Rmd document matches the provided template.")
    return(invisible(TRUE))
  }

  cli_theme = list(ul = list(`padding-left` = 2))

  if (nrow(missing_nodes) != 0) {
    cli::cli_alert_danger("The following required elements were missing in the document:")

    cli::cli_div(theme = cli_theme)
    cli::cli_ul()

    purrr::pwalk(
      collapse_sections(missing_nodes),
      li_missing
    )

    cli::cli_end()
    cli::cli_end()
  }

  if (nrow(unmodified_nodes) != 0) {
    if (nrow(missing_nodes) != 0) # Space if we have missing
      cli::cat_line()

    cli::cli_alert_danger("The following document elements were unmodified from the template:")

    cli::cli_div(theme = cli_theme)
    cli::cli_ul()

    purrr::pwalk(
      collapse_sections(unmodified_nodes),
      li_unmodified
    )

    cli::cli_end()
    cli::cli_end()
  }

  return(invisible(FALSE))

}

check_missing = function(rmd_tbl, template) {
  # Drop the content column
  template$content = NULL

  suppressMessages(
    dplyr::anti_join(template, rmd_tbl)
  )
}

check_unmodified = function(rmd_tbl, template) {
  if (!"content" %in% names(rmd_tbl) | !"content" %in% names(template))
    return(tibble::tibble())

  # We only care about the content of these node types, others are NA anyway
  template = dplyr::filter(template, type %in% c("rmd_chunk", "rmd_markdown"))

  suppressMessages(
    dplyr::semi_join(template, rmd_tbl)
  )
}




li_missing = function(secs, type, label = NA) {
  sec = cli::style_italic( paste(
    cli::col_silver(
      paste0('"', secs, '"')
    ),
    collapse = " > "
  ) )

  text = if (type == "rmd_yaml" | type == "rmd_yaml_list") {
    "{.val YAML} is missing"
  } else if (type == "rmd_heading") {
    "Section {sec} is missing"
  } else if (type == "rmd_markdown") {
    "Section {sec} is missing required {.val markdown text}"
  } else if (type == "rmd_chunk") {
    if (!is.na(label) & label != "") {
      "Section {sec} is missing a required {.val code chunk} named {.val {label}}"
    } else {
      "Section {sec} is missing a required {.val code chunk}"
    }
  } else {
    stop("Unexpected (unsupported) type.")
  }
  cli::cli_li(text)
}

li_unmodified = function(secs, type, label = NA, content = NA) {
  sec = cli::style_italic( paste(
    cli::col_silver(
      paste0('"', secs, '"')
    ),
    collapse = " > "
  ) )

  text = if (type == "rmd_markdown") {
    "Section {sec} has {.val markdown text} which has not been modified."
  } else if (type == "rmd_chunk") {
    if (!is.na(label) & label != "") {
      "Section {sec} has a {.val code chunk} named {.val {label}} which has not been modified."
    } else {
      "Section {sec} has {.val code chunk} which has not been modified."
    }
  }
  cli::cli_li(text)
}


