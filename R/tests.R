test_round_trip = function(file, skip_files = character()) {
  file_path = unclass(file)
  should_skip = file_path %in% skip_files
  
  test_lines = c(
    paste0("test_that(", rlang::expr_deparse(file_path), ", {"),
    if (should_skip) {
      paste0("  testthat::skip(\"Skipping problematic file: ", file_path, "\")")
    } else {
      c(
        rlang::expr_deparse( rlang::expr(
          ast <- testthat::expect_no_error(
            parse_rmd(!!!file_path), 
            class = "rmd_ast"
          )
        )),
        
        rlang::expr_deparse( rlang::expr(
          testthat::expect_equal(
            ast,
            parse_rmd(as_document(ast, padding = character()))
          )
        ))
      )
    },
    "})"
  )
  
  test_lines
}

extract_shortcode_lines = function(content) {
  lines = strsplit(content, "\n")[[1]]
  shortcode_pattern = "\\{\\{<\\s*[^>]+\\s*>\\}\\}"
  escaped_pattern = "\\{\\{</\\*.*?\\*/>\\}\\}"
  triple_brace_pattern = "\\{\\{\\{<.*?>\\}\\}\\}"  # Filter out {{{< ... >}}} patterns
  
  matches = list()
  for (i in seq_along(lines)) {
    line = lines[i]
    if (grepl(shortcode_pattern, line)) {
      # Skip lines that contain triple-brace shortcode examples
      if (grepl(triple_brace_pattern, line)) {
        next
      }
      
      # Extract all shortcode matches from this line
      shortcode_matches = regmatches(line, gregexpr(shortcode_pattern, line))[[1]]
      has_valid_shortcode = FALSE
      for (match in shortcode_matches) {
        # Filter out escaped shortcodes like {{</* var */>}}
        if (!grepl(escaped_pattern, match)) {
          has_valid_shortcode = TRUE
          break
        }
      }
      # Only add the line once if it has at least one valid shortcode
      if (has_valid_shortcode) {
        matches = append(matches, list(list(line_num = i, full_line = line)), length(matches))
      }
    }
  }
  
  matches
}

extract_span_lines = function(content) {
  lines = strsplit(content, "\n")[[1]]
  span_pattern = "\\[([^]]+)\\]\\{([^}]+)\\}"
  
  matches = list()
  for (i in seq_along(lines)) {
    line = lines[i]
    if (grepl(span_pattern, line)) {
      # Extract all span matches from this line
      span_matches = regmatches(line, gregexpr(span_pattern, line))[[1]]
      span_positions = gregexpr(span_pattern, line)[[1]]
      
      has_valid_span = FALSE
      for (j in seq_along(span_matches)) {
        match = span_matches[j]
        pos = span_positions[j]
        
        # Check if this span is part of a LaTeX command by looking at what precedes it
        preceding_text = substr(line, 1, pos - 1)
        
        # Filter out LaTeX commands - check for \command anywhere in the preceding text
        # and also check for LaTeX parameter patterns like \command{...}[...]
        is_latex = grepl("\\\\[a-zA-Z]+", preceding_text) || 
                   grepl("\\\\[a-zA-Z]+\\{[^}]*\\}\\s*$", preceding_text)
        
        if (!is_latex) {
          has_valid_span = TRUE
          break
        }
      }
      # Only add the line once if it has at least one valid span
      # Also filter out lines that contain examples of invalid syntax or non-span patterns
      contains_invalid_example = grepl("does.*not.*work", line, ignore.case = TRUE) ||
                                 grepl("invalid", line, ignore.case = TRUE) ||
                                 grepl("incorrect", line, ignore.case = TRUE)
      
      # Filter out specific regex pattern from examples/quarto-cli/tests/docs/smoke-all/2024/05/03/9548.qmd
      # Line contains: ['<link .* href=.+revealjs/dist/theme/quarto-([a-f0-9]{32})\.css']
      contains_css_regex = grepl("revealjs/dist/theme/quarto-\\(\\[a-f0-9\\]\\{32\\}\\)", line)
      
      if (has_valid_span && !contains_invalid_example && !contains_css_regex) {
        matches = append(matches, list(list(line_num = i, full_line = line)), length(matches))
      }
    }
  }
  
  matches
}

test_shortcode_parsing = function(file, skip_files = character()) {
  file_path = unclass(file)
  should_skip = file_path %in% skip_files
  
  if (should_skip) {
    test_lines = c(
      paste0("test_that(", rlang::expr_deparse(file_path), ", {"),
      paste0("  testthat::skip(\"Skipping problematic file: ", file_path, "\")"),
      "})"
    )
    return(test_lines)
  }
  
  # Read file and extract shortcode lines
  tryCatch({
    content = readLines(file_path, warn = FALSE) |> paste(collapse = "\n")
    shortcode_matches = extract_shortcode_lines(content)
  }, error = function(e) {
    shortcode_matches = list()
  })
  
  # Return NULL if no shortcodes found (will be filtered out)
  if (length(shortcode_matches) == 0) {
    return(NULL)
  }
  
  test_lines = paste0("test_that(", rlang::expr_deparse(file_path), ", {")
  
  # Generate expectations for each line with shortcodes
  for (match in shortcode_matches) {
    line_num = match$line_num
    full_line = match$full_line
    
    # Create a comment showing just the line number
    comment_line = paste0("  # Line ", line_num)
    
    # Create the expectation testing the full line
    expectation = paste0(
      "  testthat::expect_true(\n",
      "    length(parse_shortcodes_cpp(", rlang::expr_deparse(full_line), ")) >= 1\n",
      "  )"
    )
    
    test_lines = c(test_lines, comment_line, expectation)
  }
  
  test_lines = c(test_lines, "})")
  test_lines
}

test_span_parsing = function(file, skip_files = character()) {
  file_path = unclass(file)
  should_skip = file_path %in% skip_files
  
  if (should_skip) {
    test_lines = c(
      paste0("test_that(", rlang::expr_deparse(file_path), ", {"),
      paste0("  testthat::skip(\"Skipping problematic file: ", file_path, "\")"),
      "})"
    )
    return(test_lines)
  }
  
  # Read file and extract span lines
  tryCatch({
    content = readLines(file_path, warn = FALSE) |> paste(collapse = "\n")
    span_matches = extract_span_lines(content)
  }, error = function(e) {
    span_matches = list()
  })
  
  # Return NULL if no spans found (will be filtered out)
  if (length(span_matches) == 0) {
    return(NULL)
  }
  
  test_lines = paste0("test_that(", rlang::expr_deparse(file_path), ", {")
  
  # Generate expectations for each line with spans
  for (match in span_matches) {
    line_num = match$line_num
    full_line = match$full_line
    
    # Create a comment showing just the line number
    comment_line = paste0("  # Line ", line_num)
    
    # Create the expectation testing the full line
    expectation = paste0(
      "  testthat::expect_true(\n",
      "    length(parse_spans_cpp(", rlang::expr_deparse(full_line), ")) >= 1\n",
      "  )"
    )
    
    test_lines = c(test_lines, comment_line, expectation)
  }
  
  test_lines = c(test_lines, "})")
  test_lines
}
