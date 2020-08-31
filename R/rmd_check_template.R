#' @export
rmd_check_template = function(obj, template) {
  UseMethod("rmd_check_template")
}

#' @export
rmd_check_templatedefault = function(rmd, template) {
  stop("Unable to check an Rmd template for an object with class: ", class(rmd))
}


#' @export
rmd_check_template.rmd_ast = function(rmd, template) {
  rmd_check_template( as_tibble(rmd), template )
}


#' @export
rmd_check_template.rmd_tibble = function(rmd, template, check_headings = FALSE) {
  inc_content = ("content" %in% names(template))

  if (!check_headings) {
    template = dplyr::filter(template, type != "rmd_heading")
  }

  obj = rmd_template(rmd, inc_content = inc_content)

  if (inc_content) {
    obj_content = obj$content
    tmpl_content = template$content

    obj$content = NULL
    template$content = NULL
  }

  res = suppressMessages(
    dplyr::anti_join(template, obj)
  )

  if (nrow(res) != 0) {
    cli::cli_alert_danger("Missing the following expected elements in the document:")

    cli::cli_div(theme = list(ul = list(`padding-left` = 2)))
    cli::cli_ul()
    purrr::pwalk(
      collapse_sections(res),
      print_missing,
    )
    cli::cli_end()
    cli::cli_end()

    FALSE
  } else {
    cli::cli_alert_success("Rmd document matches the provided template.")

    TRUE
  }
}


print_missing = function(secs, type, label = NA, indent = "  ") {
  sec = cli::style_italic( paste(
    cli::col_silver(secs),
    collapse = " > "
  ) )

  text = if (type == "rmd_yaml" | type == "rmd_yaml_list") {
    "{.val YAML} is missing"
  } else if (type == "rmd_heading") {
    "{.val Section} {sec} is missing"
  } else if (type == "rmd_markdown") {
    "{.val Markdown text} in section {sec} is missing"
  } else if (type == "rmd_chunk") {
    if (!is.na(label) & label != "") {
      "{.val Code chunk} named {.val {label}} in section {sec} is missing"
    } else {
      "{.val Code chunk} in section {sec} is missing"
    }
  }
  cli::cli_li(text)
}


