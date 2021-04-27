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

