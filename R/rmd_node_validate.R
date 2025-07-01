#' Helper function to throw validation errors consistently
#'
#' @param errors Character vector of error messages
#' @param type The type of rmd node (e.g., "rmd_yaml", "rmd_chunk")
#' @param index Optional position index for error reporting
#'
throw_validation_errors = function(errors, type, index = NULL) {
  pos_msg = if (is.null(index)) "" else paste0(" at position ", index)
  cli::cli_abort(c(
    "{type} validation failed{pos_msg}:",
    rlang::set_names(errors, rep("x", length(errors)))
  ), call = NULL)
}

#' Helper function to validate basic structure and required fields
#'
#' @param x Object to validate
#' @param required_fields Character vector of required field names
#' @param type The type of rmd node for error reporting
#' @param index Optional position index for error reporting
#'
validate_basic_structure = function(x, required_fields, type, index = NULL) {
  # Check basic structure first
  list_check = checkmate::check_list(x)
  if (!isTRUE(list_check)) {
    throw_validation_errors(list_check, type, index)
  }
  
  # Check required fields
  missing_fields = setdiff(required_fields, names(x))
  if (length(missing_fields) != 0 ) {
    throw_validation_errors(
      cli::format_inline("Object is missing required field{?s}: {.field {missing_fields}}"),
      type, index
    )
  }
}

#' Helper function to process checkmate results and throw errors if any fail
#'
#' @param checks Named character vector of checkmate results
#' @param type The type of rmd node for error reporting
#' @param index Optional position index for error reporting
#'
validate_checks = function(checks, type, index = NULL) {
  errors = checks[checks != "TRUE"]
  if (length(errors) != 0) {
    # Format errors with field names
    formatted_errors = purrr::map2_chr(
      names(errors), errors,
      ~ cli::format_inline("Field {.field {.x}} - {.y}")
    )
    throw_validation_errors(formatted_errors, type, index)
  }
}

#' Validate rmd node objects
#'
#' @description S3 generic function to validate that an object is a properly structured
#' rmd node with the correct class and required fields.
#'
#' @param x Object to validate
#' @param index Optional position index for error reporting
#'
#' @return TRUE if validation passes, otherwise throws an error with all issues
#' 
#' @export
#' 
rmd_node_validate = function(x, index = NULL) {
  UseMethod("rmd_node_validate")
}

#' @exportS3Method
rmd_node_validate.default = function(x, index = NULL) {
  valid_classes = c(
    "rmd_yaml", "rmd_heading", "rmd_chunk", "rmd_raw_chunk", 
    "rmd_markdown", "rmd_code_block", "rmd_fenced_div_open", 
    "rmd_fenced_div_close", "rmd_inline_code", "rmd_shortcode"
  )
  
  pos_msg = if (is.null(index)) "" else paste0(" at position ", index)
  cli::cli_abort(c(
    "Function must return a valid rmd node object{pos_msg}.",
    "x" = "Got object of class: {paste(class(x), collapse = ', ')}.",
    "x" = "Valid rmd node classes are: {paste(valid_classes, collapse = ', ')}."
  ), call = NULL)
}

#' @exportS3Method
rmd_node_validate.rmd_yaml = function(x, index = NULL) {
  errors = character(0)
  
  # Basic structure validation
  list_check = checkmate::check_list(x)
  if (!isTRUE(list_check)) {
    throw_validation_errors(list_check, "rmd_yaml", index)
  }
  
  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_heading = function(x, index = NULL) {
  required_fields = c("name", "level")
  validate_basic_structure(x, required_fields, "rmd_heading", index)
  
  checks = c(
    level = checkmate::check_int(x$level, lower = 1, upper = 6),
    name = checkmate::check_string(x$name)
  )
  validate_checks(checks, "rmd_heading", index)
  
  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_chunk = function(x, index = NULL) {
  required_fields = c("engine", "name", "options", "yaml_options", "code", "indent", "n_ticks")
  validate_basic_structure(x, required_fields, "rmd_chunk", index)
  
  checks = c(
    engine = checkmate::check_string(x$engine),
    name = checkmate::check_string(x$name),
    options = checkmate::check_list(x$options),
    yaml_options = checkmate::check_list(x$yaml_options),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent),
    n_ticks = checkmate::check_int(x$n_ticks, lower = 3)
  )
  validate_checks(checks, "rmd_chunk", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_raw_chunk = function(x, index = NULL) {
  required_fields = c("format", "code", "indent", "n_ticks")
  validate_basic_structure(x, required_fields, "rmd_raw_chunk", index)
  
  checks = c(
    format = checkmate::check_string(x$format),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent),
    n_ticks = checkmate::check_int(x$n_ticks, lower = 3)
  )
  validate_checks(checks, "rmd_raw_chunk", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_markdown = function(x, index = NULL) {
  required_fields = c("lines")
  validate_basic_structure(x, required_fields, "rmd_markdown", index)
  
  checks = c(
    lines = checkmate::check_character(x$lines, min.len = 1)
  )
  validate_checks(checks, "rmd_markdown", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_code_block = function(x, index = NULL) {
  required_fields = c("attr", "code", "indent")
  validate_basic_structure(x, required_fields, "rmd_code_block", index)
  
  checks = c(
    attr = checkmate::check_string(x$attr),
    code = checkmate::check_character(x$code),
    indent = checkmate::check_string(x$indent)
  )
  validate_checks(checks, "rmd_code_block", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_fenced_div_open = function(x, index = NULL) {
  required_fields = c("attr")
  validate_basic_structure(x, required_fields, "rmd_fenced_div_open", index)
  
  checks = c(
    attr = checkmate::check_character(x$attr)
  )
  validate_checks(checks, "rmd_fenced_div_open", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_fenced_div_close = function(x, index = NULL) {
  required_fields = c()
  validate_basic_structure(x, required_fields, "rmd_fenced_div_close", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_inline_code = function(x, index = NULL) {
  required_fields = c("engine", "code", "braced")
  validate_basic_structure(x, required_fields, "rmd_inline_code", index)
  
  checks = c(
    engine = checkmate::check_string(x$engine),
    code = checkmate::check_string(x$code),
    braced = checkmate::check_logical(x$braced, len = 1)
  )
  validate_checks(checks, "rmd_inline_code", index)

  TRUE
}

#' @exportS3Method
rmd_node_validate.rmd_shortcode = function(x, index = NULL) {
  required_fields = c("func", "args")
  validate_basic_structure(x, required_fields, "rmd_shortcode", index)
  
  checks = c(
    func = checkmate::check_string(x$func),
    args = checkmate::check_character(x$args)
  )
  validate_checks(checks, "rmd_shortcode", index)
  
  TRUE
}
