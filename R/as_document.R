#' @title Convert an `rmd_ast`, `rmd_tibble`, or any ast node into text.
#'
#' @param x `rmd_ast`, `rmd_tibble`, or parsermd node object.
#' @param padding Padding to add between nodes when assembling the text.
#' @param collapse If not `NULL`, use value to collapse lines.
#' @param use_yaml_opts Logical. Whether to use YAML format for chunk options (default TRUE).
#' @param ... Passed to `to_ast()` when converting `rmd_collection` or `qmd_collection`.
#'
#' @return Returns a character vector.
#'
#' @export
as_document = function(x, padding = "", collapse = NULL, use_yaml_opts = TRUE, ...) {
  UseMethod("as_document")
}

#' @exportS3Method
as_document.default = function(x, ...) {
  stop("Unsupported class:", paste(class(x), collapse=", "))
}

#' @exportS3Method
as_document.character = function(x, ...) {
  x
}

#' @exportS3Method
as_document.rmd_ast = function(x, padding = "", collapse = NULL, use_yaml_opts = TRUE, ...) {
  if (length(x@nodes) == 0) {
    lines = ""
  } else {
    lines = unlist(
      purrr::map(x@nodes, ~ c(as_document(.x, use_yaml_opts = use_yaml_opts, ...), padding))
    )
  }

  if (!is.null(collapse))
    lines = paste(lines, collapse = collapse)

  lines
}

#' @exportS3Method
as_document.rmd_collection = function(x, padding = "", collapse = NULL, use_yaml_opts = TRUE, ...) {
  as_document(as_ast(x, ...), padding, collapse, use_yaml_opts = use_yaml_opts)
}

#' @exportS3Method
as_document.qmd_collection = function(x, padding = "", collapse = NULL, use_yaml_opts = TRUE, ...) {
  as_document(as_ast(x, ...), padding, collapse, use_yaml_opts = use_yaml_opts)
}

#' @exportS3Method
as_document.rmd_tibble = function(x, padding = "", collapse = NULL, use_yaml_opts = TRUE, ...) {
  as_document(x$ast, padding, collapse, use_yaml_opts = use_yaml_opts, ...)
}


#' @exportS3Method
as_document.rmd_chunk = function(x, ..., use_yaml_opts = TRUE) {
  ticks = paste(rep('`', x@n_ticks), collapse="")
  
  if (use_yaml_opts && length(x@options) > 0) {
    # Use YAML format for options
    details = if (x@label != "") x@label else ""
    if (details != "") details = paste0(" ", details)
    
    # Convert option names from . to - for YAML format
    yaml_options = x@options
    if (length(names(yaml_options)) > 0) {
      names(yaml_options) = yamlize_option_names(names(yaml_options))
    }
    
    yaml_lines = yaml_text(yaml_options)
    
    lines = c(
      paste0(ticks, "{", x@engine, details, "}"),
      paste("#|", yaml_lines),
      x@code,
      ticks
    )
  } else {
    # Use traditional R format for options
    if (x@label != "") {
      details = x@label
      if (length(x@options) > 0)
        details = paste0(details, ", ")
    } else {
      details = ""
    }

    if (length(x@options) > 0)
      details = paste0(
        details,
        paste(names(x@options), "=", x@options, collapse=", ")
      )

    if (details != "")
      details = paste0(" ", details)

    lines = c(
      paste0(ticks, "{", x@engine, details, "}"),
      x@code,
      ticks
    )
  }

  paste0(
    x@indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_raw_chunk = function(x, ...) {
  ticks = paste(rep('`', x@n_ticks), collapse="")

  lines = c(
    paste0(ticks, "{=", x@format,"}"),
    x@code,
    ticks
  )

  paste0(
    x@indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_code_block = function(x, ...) {
  ticks = paste(rep('`', x@n_ticks), collapse="")
  
  # Reconstruct code block attributes
  has_id = length(x@id) > 0
  has_attr = length(x@attr) > 0  
  has_classes = length(x@classes) > 0
  
  attr_str = ""
  
  if (has_id || has_attr || has_classes) {
    # Check if we can use pure unbraced syntax (single class, no id/attr)
    if (!has_id && !has_attr && has_classes && length(x@classes) == 1) {
      # Remove . prefix for unbraced syntax
      class_name = x@classes[1]
      if (startsWith(class_name, ".")) {
        class_name = substr(class_name, 2, nchar(class_name))
      }
      attr_str = class_name
    } else {
      # Use braced syntax for any complex attributes
      components = character(0)
      
      # Add ID (already has # prefix)
      if (has_id) {
        components = c(components, x@id)
      }
      
      # Add classes (already have . prefix)
      if (has_classes) {
        components = c(components, x@classes)
      }
      
      # Add key=value pairs
      if (has_attr) {
        kv_pairs = paste0(names(x@attr), "=", x@attr)
        components = c(components, kv_pairs)
      }
      
      if (length(components) > 0) {
        attr_str = paste0("{", paste(components, collapse=" "), "}")
      }
    }
  }
  
  lines = c(
    paste(ticks, attr_str),
    x@code,
    ticks
  )

  paste0(
    x@indent,
    lines
  )
}

#' @exportS3Method
as_document.rmd_code_block_literal = function(x, ...) {
  ticks = paste(rep('`', x@n_ticks), collapse="")
  
  lines = c(
    paste0(ticks, "{{", x@attr, "}}"),
    x@code,
    ticks
  )

  paste0(
    x@indent,
    lines
  )
}


#' @exportS3Method
as_document.rmd_heading = function(x, ...) {
  heading_text = paste(
    paste(rep("#", x@level), collapse=""),
    x@name
  )
  
  # Add pandoc attributes if present
  has_id = length(x@id) > 0
  has_attr = length(x@attr) > 0  
  has_classes = length(x@classes) > 0
  
  if (has_id || has_attr || has_classes) {
    components = character(0)
    
    # Add ID (already has # prefix)
    if (has_id) {
      components = c(components, x@id)
    }
    
    # Add classes (already have . prefix)
    if (has_classes) {
      components = c(components, x@classes)
    }
    
    # Add key=value pairs
    if (has_attr) {
      kv_pairs = paste0(names(x@attr), "=", x@attr)
      components = c(components, kv_pairs)
    }
    
    attr_str = paste0(" {", paste(components, collapse=" "), "}")
    heading_text = paste0(heading_text, attr_str)
  }
  
  heading_text
}


#' @exportS3Method
as_document.rmd_yaml = function(x, ...) {
  c(
    "---",
    yaml_text(x@yaml),
    "---"
  )
}

#' @exportS3Method
`as_document.parsermd::rmd_yaml` = function(x, ...) {
  as_document.rmd_yaml(x, ...)
}



#' @exportS3Method
as_document.rmd_fenced_div_open = function(x, ...) {
  # FIXME - add depth counting to make :'s match for more readability
  
  # Check if this is an unbraced case (only classes, no ID or attr)
  has_id = length(x@id) > 0
  has_attr = length(x@attr) > 0
  has_classes = length(x@classes) > 0
  
  # If only classes and exactly one class, use unbraced syntax
  if (!has_id && !has_attr && has_classes && length(x@classes) == 1) {
    # Remove . prefix for unbraced syntax
    class_name = x@classes[1]
    if (startsWith(class_name, ".")) {
      class_name = substr(class_name, 2, nchar(class_name))
    }
    paste0("::: ", class_name)
  } else {
    # Use braced syntax
    components = character(0)
    
    # Add ID (already has # prefix)
    if (has_id) {
      components = c(components, x@id)
    }
    
    # Add classes (already have . prefix)
    if (has_classes) {
      components = c(components, x@classes)
    }
    
    # Add key=value pairs
    if (has_attr) {
      kv_pairs = paste0(names(x@attr), "=", x@attr)
      components = c(components, kv_pairs)
    }
    
    if (length(components) == 0) {
      "::: {}"
    } else {
      paste0("::: {", paste(components, collapse=" "), "}")
    }
  }
}


#' @exportS3Method
as_document.rmd_fenced_div_close = function(x, ...) {
  c(":::")
}


#' @exportS3Method
as_document.rmd_markdown = function(x, ...) {
  c(
    purrr::map_chr(x@lines, as_document),
    "" # Blank line spacing between markdown blocks
  )
}


#' @exportS3Method
as_document.rmd_shortcode = function(x, ...) {
  paste0(
    "{{< ",
      paste( c(
        x@func,
        if (length(x@args) != 0) paste0(" ", x@args) else ""
      ), collapse=""),
    " >}}"
  )
}

#' @exportS3Method
as_document.rmd_inline_code = function(x, ...) {
  paste0(
    "`",
    "{", x@engine, "} ",
    x@code,
    "`"
  )
}


