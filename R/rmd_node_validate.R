throw_validation_errors = function(errors, type) {
  cli::cli_abort(c(
    "{.cls {type}} validation failed:",
    rlang::set_names(errors, rep("x", length(errors)))
  ), call = NULL)
}

validate_basic_structure = function(x, required_fields, type) {
  # Check basic structure first
  list_check = checkmate::check_list(x)
  if (!isTRUE(list_check)) {
    throw_validation_errors(list_check, type)
  }
  
  # Check required fields
  missing_fields = setdiff(required_fields, names(x))
  if (length(missing_fields) != 0 ) {
    throw_validation_errors(
      cli::format_inline("Object is missing required field{?s}: {.field {missing_fields}}"),
      type
    )
  }
}

validate_checks = function(checks, type) {
  errors = checks[checks != "TRUE"]
  if (length(errors) != 0) {
    # Format errors with field names
    formatted_errors = purrr::map2_chr(
      names(errors), errors,
      ~ cli::format_inline("Field {.field {.x}} - {.y}")
    )
    throw_validation_errors(formatted_errors, type)
  }
}

#' Validate rmd node objects
#'
#' @description S3 generic function to validate that an object is a properly structured
#' rmd node with the correct class and required fields.
#'
#' @param x Object to validate
#'
#' @return TRUE if validation passes, otherwise throws an error with all issues
#' 
#' @export
#' 
rmd_node_validate = function(x) {
  UseMethod("rmd_node_validate")
}

#' @exportS3Method
rmd_node_validate.default = function(x) {
  valid_classes = c(
    "rmd_ast", "rmd_yaml", "rmd_heading", "rmd_chunk", "rmd_raw_chunk", 
    "rmd_markdown", "rmd_code_block", "rmd_fenced_div_open", 
    "rmd_fenced_div_close", "rmd_inline_code", "rmd_shortcode"
  )
  
  cli::cli_abort(c(
    "Node is not a valid rmd node (class: {.cls {class(x)}})."
   #"i" = "Valid rmd node classes are: {.val {valid_classes}}."
  ), call = NULL)
}

#' @exportS3Method
rmd_node_validate.rmd_ast = function(x) {
  required_fields = c()
  validate_basic_structure(x, required_fields, "rmd_ast")
  
  # Use purrr::safely to validate each node
  safe_validate = purrr::safely(rmd_node_validate)
  results = purrr::imap(x, ~ safe_validate(.x))
  
  # Extract errors from failed validations and format them properly
  error_objects = purrr::map(results, "error") |> purrr::compact()
  
  if (length(error_objects) > 0) {
    # Format each error with proper indentation
    formatted_errors = purrr::imap(error_objects, ~ {
      msg = conditionMessage(.x)
      lines = strsplit(msg, "\n")[[1]]
      
      #browser()
      # Add element prefix to first line
      first_line = paste0("Node [[", .y, "]]: ", lines[1])
      
      # Indent subsequent lines if they exist
      if (length(lines) > 1) {
        remaining_lines = paste0("\t", lines[-1])
        c(x=first_line, remaining_lines)
      } else {
        c(x=first_line)
      }
    })
    
    errors = c(
      "{.cls rmd_ast} validation failed:",
      unlist(formatted_errors)
    )

    cli::cli_abort(c(
      errors
    ), call = NULL)
  }
  
  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_yaml = function(x) {
  required_fields = c()
  validate_basic_structure(x, required_fields, "rmd_yaml")
  
  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_heading = function(x) {
  required_fields = c("name", "level")
  validate_basic_structure(x, required_fields, "rmd_heading")
  
  checks = c(
    level = checkmate::check_int(x$level, lower = 1, upper = 6),
    name = checkmate::check_string(x$name)
  )
  validate_checks(checks, "rmd_heading")
  
  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_chunk = function(x) {
  required_fields = c("engine", "name", "options", "yaml_options", "code", "indent", "n_ticks")
  validate_basic_structure(x, required_fields, "rmd_chunk")
  
  checks = c(
    engine = checkmate::check_string(x$engine),
    name = checkmate::check_string(x$name),
    options = checkmate::check_list(x$options),
    yaml_options = checkmate::check_list(x$yaml_options),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent),
    n_ticks = checkmate::check_int(x$n_ticks, lower = 3)
  )
  validate_checks(checks, "rmd_chunk")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_raw_chunk = function(x) {
  required_fields = c("format", "code", "indent", "n_ticks")
  validate_basic_structure(x, required_fields, "rmd_raw_chunk")
  
  checks = c(
    format = checkmate::check_string(x$format),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent),
    n_ticks = checkmate::check_int(x$n_ticks, lower = 3)
  )
  validate_checks(checks, "rmd_raw_chunk")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_markdown = function(x) {
  required_fields = c("lines")
  validate_basic_structure(x, required_fields, "rmd_markdown")
  
  checks = c(
    lines = checkmate::check_character(x$lines, min.len = 1)
  )
  validate_checks(checks, "rmd_markdown")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_code_block = function(x) {
  required_fields = c("attr", "code", "indent")
  validate_basic_structure(x, required_fields, "rmd_code_block")
  
  checks = c(
    attr = checkmate::check_string(x$attr),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent)
  )
  validate_checks(checks, "rmd_code_block")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_fenced_div_open = function(x) {
  required_fields = c("attr")
  validate_basic_structure(x, required_fields, "rmd_fenced_div_open")
  
  checks = c(
    attr = checkmate::check_character(x$attr)
  )
  validate_checks(checks, "rmd_fenced_div_open")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_fenced_div_close = function(x) {
  required_fields = c()
  validate_basic_structure(x, required_fields, "rmd_fenced_div_close")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_inline_code = function(x) {
  required_fields = c("engine", "code", "braced")
  validate_basic_structure(x, required_fields, "rmd_inline_code")
  
  checks = c(
    engine = checkmate::check_string(x$engine),
    code = checkmate::check_string(x$code),
    braced = checkmate::check_logical(x$braced, len = 1)
  )
  validate_checks(checks, "rmd_inline_code")

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_shortcode = function(x) {
  required_fields = c("func", "args")
  validate_basic_structure(x, required_fields, "rmd_shortcode")
  
  checks = c(
    func = checkmate::check_string(x$func),
    args = checkmate::check_character(x$args)
  )
  validate_checks(checks, "rmd_shortcode")
  
  TRUE
}
