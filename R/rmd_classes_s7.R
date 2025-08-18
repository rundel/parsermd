#' S7 Class Definitions for RMD Nodes
#'
#' @description S7 classes for representing R Markdown AST nodes with automatic validation.
#' All classes inherit from the base `rmd_node` class and provide type-safe object creation
#' with built-in validation of properties.
#'
#' @details
#' The following S7 classes are available for creating R Markdown AST nodes:
#'
#' ## Core Classes
#' 
#' * `rmd_node()` - Abstract base class for all R Markdown AST nodes. This is the parent class
#'   for all specific node types and should not be instantiated directly.
#' 
#' * `rmd_ast()` - Container for multiple nodes representing a complete document AST.
#' 
#' ## Content Nodes
#' 
#' * `rmd_yaml()` - YAML frontmatter header containing document metadata.
#' 
#' * `rmd_chunk()` - Code chunks with executable code in various engines (R, Python, etc.).
#' 
#' * `rmd_raw_chunk()` - Raw code chunks that are not executed.
#' 
#' * `rmd_markdown()` - Plain markdown text content.
#' 
#' * `rmd_heading()` - Section headings at various levels (1-6).
#' 
#' ## Code and Inline Elements
#' 
#' * `rmd_code_block()` - Fenced code blocks without execution.
#' 
#' * `rmd_code_block_literal()` - Code blocks with literal \{\{...\}\} attributes.
#' 
#' * `rmd_inline_code()` - Inline code spans within markdown text.
#' 
#' * `rmd_shortcode()` - Quarto/Pandoc shortcodes for special functionality.
#' 
#' * `rmd_span()` - Generic inline spans with attributes.
#' 
#' ## Structural Elements
#' 
#' * `rmd_fenced_div_open()` - Opening tags for fenced divs (:::).
#' 
#' * `rmd_fenced_div_close()` - Closing tags for fenced divs (:::).
#'
#' @seealso [rmd_node_utilities] for utility functions that work with these S7 objects
#' @name rmd_classes_s7
NULL

#' @rdname rmd_classes_s7
rmd_node = S7::new_class(
  "rmd_node",
  package = NULL
)

#' @rdname rmd_classes_s7
#' @export
rmd_ast = S7::new_class(
  "rmd_ast", 
  parent = rmd_node,
  properties = list(
    nodes = S7::class_list
  ),
  validator = function(self) {
    # Validate each node is a valid rmd node type or NULL
    for (i in seq_along(self@nodes)) {
      node = self@nodes[[i]]
      if (!S7::S7_inherits(node, rmd_node)) {
        return(paste0("Node [[", i, "]] is not a valid rmd node type"))
      }
    }
    
    # Validate balanced fenced divs
    fdiv_balance_error = validate_fdiv_balance(self)
    if (!is.null(fdiv_balance_error)) {
      return(fdiv_balance_error)
    }
    
    NULL
  },
  package = NULL
)

# S7 method for length
S7::method(length, rmd_ast) = function(x) {
  length(x@nodes)
}

#' @rdname rmd_classes_s7
#' @export
rmd_yaml = S7::new_class(
  "rmd_yaml",
  parent = rmd_node,
  properties = list(
    yaml = S7::class_list
  ),
  package = NULL
)

# S7 method for length
S7::method(length, rmd_yaml) = function(x) {
  length(x@yaml)
}

#' @title Heading node
#' @description S7 class representing a markdown heading
#' @param name Character. Heading text
#' @param level Integer. Heading level (1-6)
#' @export
rmd_heading = S7::new_class(
  "rmd_heading",
  parent = rmd_node,
  properties = list(
    name = S7::class_character,
    level = S7::class_integer
  ),
  validator = function(self) {
    if (length(self@name) != 1) {
      return("name must be a single character string")
    }
    if (length(self@level) != 1 || self@level < 1 || self@level > 6) {
      return("level must be a single integer between 1 and 6")
    }
    NULL
  },
  package = NULL
)

#' @title Code chunk node
#' @description S7 class representing an executable code chunk
#' @param engine Character. Language engine
#' @param name Character. Chunk name
#' @param options List. Combined chunk options (traditional and YAML)
#' @param code Character vector. Code lines
#' @param indent Character. Indentation
#' @param n_ticks Integer. Number of backticks
#' @export
rmd_chunk = S7::new_class(
  "rmd_chunk",
  parent = rmd_node,
  properties = list(
    engine  = S7::new_property(S7::class_character, default = quote("r")),
    name    = S7::new_property(S7::class_character, default = quote("")),
    options = S7::new_property(
      S7::class_list, 
      default = quote(list()),
      setter = function(self, value) {
        # Internally store option names in "traditional" format (dots)
        names(value) = normalize_option_names(names(value))
        self@options = value
        self
      }
    ),
    code    = S7::new_property(S7::class_character, default = quote(character())),
    indent  = S7::new_property(S7::class_character, default = quote("")),
    n_ticks = S7::new_property(S7::class_integer, default = quote(3L))
  ),
  validator = function(self) {
    if (length(self@engine) != 1) {
      return("@engine must be a single character string")
    } else if (length(self@name) != 1) {
      return("@name must be a single character string")
    } else if (length(self@indent) != 1) {
      return("@indent must be a single character string")
    } else if (length(self@n_ticks) != 1 || self@n_ticks < 3) {
      return("@n_ticks must be a single integer >= 3")
    } else if (length(self@options) > 0 && !is.null(names(self@options))) {
      # Check that option names don't contain hyphens (should be normalized to dots)
      option_names = names(self@options)
      if (any(grepl("-", option_names, fixed = TRUE))) {
        hyphenated_options = option_names[grepl("-", option_names, fixed = TRUE)]
        return(cli::format_inline("Option names must not contain hyphens: {.val {hyphenated_options}}. Use dots instead or let the constructor normalize them automatically."))
      }
    }
    NULL
  },
  package = NULL
)

#' @title Raw chunk node
#' @description S7 class representing a raw output chunk
#' @param format Character. Output format
#' @param code Character vector. Code lines
#' @param indent Character. Indentation
#' @param n_ticks Integer. Number of backticks
#' @export
rmd_raw_chunk = S7::new_class(
  "rmd_raw_chunk",
  parent = rmd_node,
  properties = list(
    format  = S7::class_character,
    code    = S7::new_property(S7::class_character, default = quote(character())),
    indent  = S7::new_property(S7::class_character, default = quote("")),
    n_ticks = S7::new_property(S7::class_integer,   default = quote(3L)) 
  ),
  validator = function(self) {
    if (length(self@format) != 1) {
      return("format must be a single character string")
    }
    if (length(self@indent) != 1) {
      return("indent must be a single character string")
    }
    if (length(self@n_ticks) != 1 || self@n_ticks < 3) {
      return("n_ticks must be a single integer >= 3")
    }
    NULL
  },
  package = NULL
)

#' @title Markdown text node
#' @description S7 class representing markdown text content
#' @param lines Character vector. Markdown text lines
#' @export
rmd_markdown = S7::new_class(
  "rmd_markdown",
  parent = rmd_node,
  properties = list(
    lines = S7::class_character
  ),
  validator = function(self) {
    if (length(self@lines) < 1) {
      return("lines must contain at least one character string")
    }
    NULL
  },
  package = NULL
)

#' @title Markdown code block node
#' @description S7 class representing a fenced code block
#' @param id Character vector. HTML ID (length 0 or 1)
#' @param classes Character vector. CSS classes
#' @param attr Named character vector. Key-value attributes (keys as names)
#' @param code Character vector. Code lines
#' @param indent Character. Indentation
#' @param n_ticks Integer. Number of backticks
#' @export
rmd_code_block = S7::new_class(
  "rmd_code_block",
  parent = rmd_node,
  properties = list(
    id      = S7::new_property(S7::class_character, default = quote(character())),
    classes = S7::new_property(S7::class_character, default = quote(character())),
    attr    = S7::new_property(S7::class_character, default = quote(character())),
    code    = S7::new_property(S7::class_character, default = quote(character())),
    indent  = S7::new_property(S7::class_character, default = quote("")),
    n_ticks = S7::new_property(S7::class_integer, default = quote(3L))
  ),
  validator = function(self) {
    if (length(self@id) > 1) {
      return("id must be a character vector of length 0 or 1")
    }
    if (!is.null(names(self@classes))) {
      return("classes cannot be named")
    }
    if (length(self@attr) > 0 && is.null(names(self@attr))) {
      return("attr must be named if not empty")
    }
    if (length(self@indent) != 1) {
      return("indent must be a single character string")
    }
    if (length(self@n_ticks) != 1) {
      return("n_ticks must be a single integer")
    }
    NULL
  },
  package = NULL
)

#' @title Code block literal node
#' @description S7 class representing a code block with \{\{...\}\} attributes
#' @param attr Character. Raw attribute content from \{\{...\}\}
#' @param code Character vector. Code lines
#' @param indent Character. Indentation
#' @param n_ticks Integer. Number of backticks
#' @export
rmd_code_block_literal = S7::new_class(
  "rmd_code_block_literal",
  parent = rmd_node,
  properties = list(
    attr    = S7::new_property(S7::class_character, default = quote("")),
    code    = S7::new_property(S7::class_character, default = quote(character())),
    indent  = S7::new_property(S7::class_character, default = quote("")),
    n_ticks = S7::new_property(S7::class_integer, default = quote(3L))
  ),
  validator = function(self) {
    if (length(self@attr) != 1) {
      return("attr must be a single character string")
    }
    if (length(self@indent) != 1) {
      return("indent must be a single character string")
    }
    if (length(self@n_ticks) != 1 || self@n_ticks < 3) {
      return("n_ticks must be a single integer >= 3")
    }
    NULL
  },
  package = NULL
)

#' @title Opening fenced div node
#' @description S7 class representing the opening of a fenced div
#' @param id Character vector. HTML ID (length 0 or 1)
#' @param classes Character vector. CSS classes
#' @param attr Named character vector. Key-value attributes (keys as names)
#' @export
rmd_fenced_div_open = S7::new_class(
  "rmd_fenced_div_open",
  parent = rmd_node,
  properties = list(
    id = S7::new_property(S7::class_character, default = quote(character())),
    classes = S7::new_property(S7::class_character, default = quote(character())),
    attr = S7::new_property(S7::class_character, default = quote(character()))
  ),
  validator = function(self) {
    if (length(self@id) > 1) {
      return("id must be a character vector of length 0 or 1")
    }
    if (length(self@id) > 0 && !startsWith(self@id, "#")) {
      return("id must start with # prefix")
    }
    if (!is.character(self@classes)) {
      return("classes must be a character vector")
    }
    if (length(self@classes) > 0 && !all(startsWith(self@classes, "."))) {
      return("all classes must start with . prefix")
    }
    if (!is.character(self@attr)) {
      return("attr must be a character vector")
    }
    if (length(self@attr) > 0 && is.null(names(self@attr))) {
      return("attr must be a named character vector when not empty")
    }
    NULL
  },
  package = NULL
)

#' @title Closing fenced div node
#' @description S7 class representing the closing of a fenced div
#' @export
rmd_fenced_div_close = S7::new_class(
  "rmd_fenced_div_close",
  parent = rmd_node,
  package = NULL
)

#' @title Inline code node
#' @description S7 class representing inline code
#' @param engine Character. Language engine
#' @param code Character. Code content
#' @param braced Logical. Whether code is braced
#' @param start Integer. Start position
#' @param length Integer. Length
#' @export
rmd_inline_code = S7::new_class(
  "rmd_inline_code",
  properties = list(
    engine = S7::new_property(S7::class_character, default = quote("")),
    code   = S7::new_property(S7::class_character, default = quote("")),
    braced = S7::new_property(S7::class_logical, default = quote(FALSE)),
    start  = S7::new_property(S7::class_integer, default = quote(-1L)),
    length = S7::new_property(S7::class_integer, default = quote(-1L))
  ),
  validator = function(self) {
    if (length(self@engine) != 1) {
      return("engine must be a single character string")
    }
    if (length(self@code) != 1) {
      return("code must be a single character string")
    }
    if (length(self@braced) != 1) {
      return("braced must be a single logical value")
    }
    if (length(self@start) != 1) {
      return("start must be a single integer")
    }
    if (length(self@length) != 1) {
      return("length must be a single integer")
    }
    NULL
  },
  package = NULL
)

#' @title Shortcode node
#' @description S7 class representing a shortcode function call
#' @param func Character. Function name
#' @param args Character vector. Function arguments
#' @param start Integer. Start position
#' @param length Integer. Length
#' @export
rmd_shortcode = S7::new_class(
  "rmd_shortcode",
  properties = list(
    func   = S7::class_character,
    args   = S7::new_property(S7::class_character, default = quote(character())),
    start  = S7::new_property(S7::class_integer, default = quote(-1L)),
    length = S7::new_property(S7::class_integer, default = quote(-1L))
  ),
  validator = function(self) {
    if (length(self@func) != 1) {
      return("func must be a single character string")
    }
    if (length(self@start) != 1) {
      return("start must be a single integer")
    }
    if (length(self@length) != 1) {
      return("length must be a single integer")
    }
    NULL
  },
  package = NULL
)

#' @title Span node
#' @description S7 class representing a span with attributes
#' @param text Character. Span text content
#' @param id Character vector. HTML ID (length 0 or 1)
#' @param classes Character vector. CSS classes
#' @param attr Named character vector. Additional attributes
#' @export
rmd_span = S7::new_class(
  "rmd_span",
  properties = list(
    text = S7::new_property(S7::class_character, default = quote("")),
    id = S7::new_property(S7::class_character, default = quote(character())),
    classes = S7::new_property(S7::class_character, default = quote(character())),
    attr = S7::new_property(S7::class_character, default = quote(character()))
  ),
  validator = function(self) {
    if (length(self@text) != 1) {
      return("text must be a single character string")
    }
    if (length(self@id) > 1) {
      return("id must be a character vector of length 0 or 1")
    }
    if (length(self@id) == 1 && !grepl("^#", self@id)) {
      return("id must start with '#' when present")
    }
    if (any(!grepl("^\\.", self@classes))) {
      return("all classes must start with '.' when present")
    }
    if (length(self@attr) > 0 && is.null(names(self@attr))) {
      return("attr must be a named character vector when not empty")
    }
    NULL
  },
  package = NULL
)

validate_fdiv_balance = function(ast) {
  nodes = ast@nodes

  if (length(nodes) == 0) return(NULL)
  
  # Track the balance with a stack-like counter
  balance = 0
  
  for (i in seq_along(nodes)) {
    if (S7::S7_inherits(nodes[[i]], rmd_fenced_div_open)) {
      balance = balance + 1
    } else if (S7::S7_inherits(nodes[[i]], rmd_fenced_div_close)) {
      balance = balance - 1
    }

    if (balance < 0) { # Close without matching open
      return(cli::format_inline("Unbalanced fenced divs: {.cls rmd_fenced_div_close} at [[{i}]] does not have a matching {.cls rmd_fenced_div_open}"))
    }
  }
  
  # Check if we have unmatched opens
  if (balance > 0) {
    return(
      cli::format_inline("Unbalanced fenced divs: {cli::no(balance)} {.cls rmd_fenced_div_open}{?s} without matching {.cls rmd_fenced_div_close}{?s}")
    )
  }
  
  NULL
}