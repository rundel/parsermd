# parsermd 0.2.0 (development version)

* **Breaking Change**: Migrated from S3/S4 classes to S7 classes for all AST node types (`rmd_ast`, `rmd_chunk`, `rmd_heading`, etc.)

* **Breaking Change**: Removed deprecated `rmd_subset()` and related helper functions (`rmd_get_node()`, `rmd_get_chunk()`, `rmd_get_markdown()`, `rmd_has_node()`, `rmd_has_chunk()`, `rmd_has_markdown()`). Use `rmd_select()` with tidyselect syntax instead.

* Added support for yaml chunk options - e.g. (`#| echo: false`)

* Added support for fenced divs - e.g. (`::: {.class} ... :::`)

* Added support for markdown code blocks

* Added support for yaml expressions - e.g. (`!expr`)

* Added support for parsing collections of Rmd and qmd files - see `parse_qmd_collection()` and `parse_rmd_collection()`

* Removed option to not parse yaml - this is now always parsed. Based on this yaml node classes were simplified to just include `rmd_yaml`.

* Added support for Pandoc-style ordered fenced attributes for code blocks, fenced divs, and spans

* Added `rmd_fenced_div_wrap()` function to wrap selected nodes with fenced divs

* Added `rmd_insert()` function to insert nodes relative to selected nodes

* Added support for code block literals - e.g. ```{{r}}

* Added support for 2ndary parsing to handle inline elements:

  * quarto shortcodes, inline code, and spans

* Enhanced `rmd_select()` functionality and node manipulation

  * Added `has_heading()` helper function for selecting heading nodes using glob patterns
  * Added `by_fenced_div()` helper function for selecting fenced div sections using attribute patterns
  * Added `keep_yaml` argument to `rmd_select()` (defaults to `TRUE`) to automatically include YAML nodes in selections

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

