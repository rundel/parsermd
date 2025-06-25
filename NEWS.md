# parsermd 0.2.0 (development version)

* Added support for yaml chunk options - e.g. (`#| echo: false`)

* Added support for fenced divs - e.g. (`::: {.class} ... :::`)

* Added support for markdown code blocks

* Added support for yaml expressions - e.g. (`!expr`)

* Exported and cleaned up node creation functions - see `?rmd_create` for details

* Added experimental support for parsing collections of Rmd and qmd files - see `parse_qmd_collection()` and `parse_rmd_collection()`

* Removed option to not parse yaml - this is now always parsed. Based on this yaml node classes were simplified to just include `rmd_yaml`.

* Added support for 2ndary parsing to handle quarto shortcodes and inline code
  
  * See helper functions: `rmd_has_shortcode()`, `rmd_extract_shortcodes()`, and `has_shortcode()`

* Added comprehensive inline code detection and extraction utilities
  
  * New functions: `rmd_has_inline_code()`, `rmd_extract_inline_code()`, and `has_inline_code()` for selecting nodes
  * Support for engine-specific filtering using glob patterns

# parsermd 0.1.3

* Unlabeled chunks will now be labeled as unnamed-chunk-n, with n incrementing.

* Minor fixes and updates to resolve CRAN warnings.

# parsermd 0.1.2

* Fix compilation issues with older GCC versions (e.g. GCC@5 on Solaris)

# parsermd 0.1.1

* Fix an issue under Linux when using LANG=en_US.iso88591 (`LANG=en_US.iso88591 LC_ALL=en_US.iso88591 R CMD check`)

# parsermd 0.1.0

* Added new parser error reporting system

* Adopt testthat 3.0.0 for testing

* Added new `render` function to support rendering `rmd_ast` related objects

* Added `rmd_get_options` and `rmd_set_options`

* Added support for [raw attribute chunks](https://pandoc.org/MANUAL.html#extension-raw_attribute) (#13)

* Added `rmd_source` to support sourcing chunks directly into an environment.

* Added `rmd_select` which uses tidyselect based syntax as a replacement for `rmd_subset`.

* Soft deprecated `rmd_subset`, `rmd_get_node`, `rmd_get_markdwon`, and `rmd_get_chunk`.

# parsermd 0.0.1

* Added a `NEWS.md` file to track changes to the package.

* Incremented the version number.

* Overhauled the ast and tibble representations to make them as compatible as possible.

* Starting to add helper functions: `rmd_subset`, `rmd_has_node`, `rmd_get_node`, etc.

* Initial implementation of Rmd templates

