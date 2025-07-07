if (!dir.exists("examples")) {
  skip("Additional example files not available")
}

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/_tabulator.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/feature-format-matrix/_tabulator.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/feature-format-matrix/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/appearance-minimal.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/appearance-minimal.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/appearance-simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/appearance-simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/collapse.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/collapse.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-content.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-content.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-icon.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-icon.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-title.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-title.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-type.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/callout/no-type.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-annotation/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-annotation/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-folding/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-folding/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-line-numbers/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/code-cells/code-line-numbers/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/conditional-content/when-format/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/conditional-content/when-format/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/block/callout/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/block/callout/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/block/theorem/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/block/theorem/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/caption-location-bottom/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/caption-location-bottom/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/caption-location-top/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/caption-location-top/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/code-listing/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/code-listing/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/code-listing/executable/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/code-listing/executable/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/custom/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/custom/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/figure/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/figure/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/table/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/crossref/float/table/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/background-color-mediumseagreen.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/background-color-mediumseagreen.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/span-background-color-mediumseagreen.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/background-color/span-background-color-mediumseagreen.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-badstyle.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-badstyle.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-bottom-style-dotted.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-bottom-style-dotted.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-groove.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-groove.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-redo-groove.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-redo-groove.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-solid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-left-style-solid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-remove.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-remove.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-right-shorthand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-right-shorthand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-right-shorthand-dashed.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-right-shorthand-dashed.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-all.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-all.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgb-legacy.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgb-legacy.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgb.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgb.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgba-legacy-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgba-legacy-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgba.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color-rgba.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-shorthand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-style-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-style-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-top-shorthand-dotted.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-top-shorthand-dotted.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-top-shorthand-typo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-top-shorthand-typo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-cm.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-cm.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-ex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-ex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-in.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-in.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-invalid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-invalid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-mm.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-mm.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-rem.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-rem.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-rpx.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-rpx.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-too-many.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/border-width-too-many.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/border/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-fuchsia.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-fuchsia.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-invalid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-invalid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-magenta.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-magenta.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-mediumseagreen.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-mediumseagreen.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-rgb-hex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-rgb-hex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-transparent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/color-transparent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/color/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-family/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-family/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-size/cell-percentage.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-size/cell-percentage.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-size/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-size/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/div-font-style-italic.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/div-font-style-italic.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-italic.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-italic.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-normal.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-normal.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-oblique.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-style/td-font-style-oblique.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/div-font-weight-demi-bold.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/div-font-weight-demi-bold.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/td-font-weight-bold.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/td-font-weight-bold.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/td-font-weight-ultra-light.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/font-weight/td-font-weight-ultra-light.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-mediumseagreen.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-mediumseagreen.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-nocolor.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-nocolor.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-one.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-one.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-fraction.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-fraction.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-int.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-int.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-alpha-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-percent-alpha.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-percent-alpha.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-comma.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-hex-alpha.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-hex-alpha.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-hex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-hex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-shorthex-alpha.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-shorthex-alpha.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-shorthex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-shorthex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-alpha-fraction.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-alpha-fraction.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-alpha-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-alpha-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-fraction.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-fraction.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-none.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-none.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent-alpha-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space-percent.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-rgb-space.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-span.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/opacity/opacity-span.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/vertical-align/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/vertical-align/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/vertical-align/text-align.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/css-properties/vertical-align/text-align.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/format/typst/toc-indent/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/format/typst/toc-indent/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/image/alt-text/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/image/alt-text/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-label.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-label.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-nocaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-python-nocaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-r-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-r-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-r-nocaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/code-r-nocaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-id-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-id-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-id-nocaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-id-nocaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-noid-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-noid-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-noid-nocaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/fig-align/toplevel-noid-nocaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/tabset/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/layout/tabset/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/math/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/math/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/mermaid/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/mermaid/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/html/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/html/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/pandoc-json/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/pandoc-json/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/pandoc-native/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/interpreted/pandoc-native/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/latex/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/latex/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/mdx/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/mdx/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/tex/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-blocks/pass-through/tex/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/colspan/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/colspan/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/rowspan/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/rowspan/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/text-align/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/text-align/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/vertical-align/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/raw-html/cell/vertical-align/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/shortcodes/placeholder/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/shortcodes/placeholder/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/abstract-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/abstract-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/affiliation-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/affiliation-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/author-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/author-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/description-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/description-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/doi-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/doi-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/published-title/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/feature-format-matrix/qmd-files/title-blocks/metadata-labels/published-title/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/engines/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/engines/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/engines/julia.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/engines/julia.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/engines/jupyter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/engines/jupyter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/engines/knitr.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/engines/knitr.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/future-designs/envelope.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/future-designs/envelope.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/future-designs/quarto-wide-theming.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/future-designs/quarto-wide-theming.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/future-designs/responsive-code-block-outputs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/future-designs/responsive-code-block-outputs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/future-designs/well-defined-interfaces.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/future-designs/well-defined-interfaces.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/pandoc/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/pandoc/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/pandoc/lua-filters.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/pandoc/lua-filters.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/quarto-markdown/ast.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/internals-guide/quarto-markdown/ast.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/internals-guide/render.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/internals-guide/render.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/lua-filter-trace-viewer.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/dev-docs/lua-filter-trace-viewer.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/dev-docs/package-author-information/execution-environment.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/dev-docs/package-author-information/execution-environment.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/package/conda-recipe/hello.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/package/conda-recipe/hello.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/package/src/common/import-report/package_report.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/package/src/common/import-report/package_report.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/deno_ral/README.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/src/deno_ral/README.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/documents/default/qstart-filesafename-qend.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/documents/default/qstart-filesafename-qend.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/filter/example.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/filter/example.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/format-docx/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/format-docx/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/format-html/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/format-html/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/format-pdf/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/format-pdf/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/format-revealjs/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/format-revealjs/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/format-typst/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/format-typst/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/journal/template.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/journal/template.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/revealjs-plugin/example.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/revealjs-plugin/example.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/create/extensions/shortcode/example.ejs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/create/extensions/shortcode/example.ejs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/man/quarto-man.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/src/resources/man/quarto-man.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/src/resources/tools/ast-tracing/trace-viewer.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/src/resources/tools/ast-tracing/trace-viewer.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/Syntax Test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/Syntax Test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/appendix/license.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/appendix/license.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ast/test-pandoc-native-raw-in-meta.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/ast/test-pandoc-native-raw-in-meta.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ast/test-quarto-pandoc-json-raw.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/ast/test-quarto-pandoc-json-raw.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ast/test-quarto-pandoc-native-raw.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/ast/test-quarto-pandoc-native-raw.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-inline.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-inline.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-multiple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-multiple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-ref.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/award-institition-ref.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/award-single.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/award-single.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/complex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/complex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/statement-array.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/statement-array.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/statement-open-access.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/statement-open-access.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/statement-open-acess-list.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/statement-open-acess-list.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/author-normalization/funding/statement.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/author-normalization/funding/statement.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/biblio/author.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/biblio/author.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog/posts/post-with-code/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog/posts/welcome/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog-grid/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog-grid/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/posts/no-img/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog-grid/posts/no-img/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/blog-grid/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/posts/remote-img/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/blog-grid/posts/remote-img/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/blog-grid/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/blog-grid/posts/welcome/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/books/simple/chapter2/chapter2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/books/simple/chapter2/chapter2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/books/simple/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/books/simple/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/books/simple/intro.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/books/simple/intro.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/books/simple/references.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/books/simple/references.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/books/simple/summary.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/books/simple/summary.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/brand-yaml/kitchen-sink/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/brand-yaml/kitchen-sink/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/brand-yaml/monospace-colors/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/brand-yaml/monospace-colors/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/brand-yaml/palette-colors/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/brand-yaml/palette-colors/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/break-quarto-md/github-issue-1034.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/break-quarto-md/github-issue-1034.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/bug-repros/issue-1340/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/bug-repros/issue-1340/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/call/engine/julia/sleep.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/call/engine/julia/sleep.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/callouts.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/callouts.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/code-highlighting/code-line-number-knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/code-highlighting/code-line-number-knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/code-tools/code-tools-activated.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/code-tools/code-tools-activated.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/code-tools/code-tools-external-source.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/code-tools/code-tools-external-source.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/code-tools/code-tools-toggle.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/code-tools/code-tools-toggle.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/consistency-checks/julia-ref.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/consistency-checks/julia-ref.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/consistency-checks/observable-ref.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/consistency-checks/observable-ref.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/consistency-checks/python-ref.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/consistency-checks/python-ref.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/consistency-checks/r-ref.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/consistency-checks/r-ref.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/all-docx.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/all-docx.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/all.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/all.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-margin-figure-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-margin-figure-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-no-margin-figure-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-no-margin-figure-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-no-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/captions-no-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-img-no-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-img-no-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-img.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-img.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-link.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/figure-syntax-link.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/knitr-filename.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/knitr-filename.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/listings.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/listings.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subfigures-layout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subfigures-layout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subfigures.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subfigures.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subtables.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/subtables.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/table-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/table-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/tables-simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/tables-simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/tables.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/tables.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/uncaption-column-layout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/before-newcrossref-regression-tests/uncaption-column-layout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/callouts.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/callouts.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/chapters.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/chapters.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/editor-support/crossref-with-raw-latex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/editor-support/crossref-with-raw-latex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/editor-support/theorems.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/editor-support/theorems.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/editor-support/unnumbered-crossrefs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/editor-support/unnumbered-crossrefs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/equations.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/equations.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/figure-syntax-div.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/figure-syntax-div.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/figure-syntax-img-no-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/figure-syntax-img-no-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/figure-syntax-img.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/figure-syntax-img.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/figure-syntax-link.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/figure-syntax-link.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/julia-subfig.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/julia-subfig.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/julia.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/julia.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/julianative-subfig.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/julianative-subfig.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/julianative.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/julianative.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/knitr-tables-latex.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/knitr-tables-latex.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/knitr-tables.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/knitr-tables.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/knitr.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/knitr.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/listings.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/listings.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/numbering.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/numbering.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/options.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/options.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/python-subfig.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/python-subfig.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/python.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/python.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/sections.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/sections.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/simple.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/simple.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/syntax.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/syntax.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/tables.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/tables.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/theorem-types.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/theorem-types.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/theorems.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/theorems.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/unresolved.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/unresolved.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/computational-cell-listings.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/computational-cell-listings.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/custom-categories/diagrams.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/custom-categories/diagrams.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/figure-crossrefs-pdf.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/figure-crossrefs-pdf.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/figure-crossrefs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/crossrefs/v1.4/figure-crossrefs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/remarks-solutions.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/remarks-solutions.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/tables/markdown-table-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/tables/markdown-table-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/crossrefs/v1.4/tables/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/crossrefs/v1.4/tables/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/date/fr-CA.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/date/fr-CA.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/date/fr-FR.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/date/fr-FR.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/date/fr.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/date/fr.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/date/lastmodified.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/date/lastmodified.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/date/today.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/date/today.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/directives/include/test1/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/directives/include/test1/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/directives/pagebreak/minimal.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/directives/pagebreak/minimal.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/directives/pagebreak/one-break.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/directives/pagebreak/one-break.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/directives/pagebreak/one-raw-break.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/directives/pagebreak/one-raw-break.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/doc-layout/title-block-banner.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/doc-layout/title-block-banner.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/doc-layout/title-block-none.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/doc-layout/title-block-none.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/doc-layout/title-block.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/doc-layout/title-block.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/email/email-attach.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/email/email-attach.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/email/email-no-subject.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/email/email-no-subject.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/email/email.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/email/email.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/email/project/email-attach.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/email/project/email-attach.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/embed-ipynb.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/embed-ipynb.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/embed-qmd.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/embed-qmd.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/notebook.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/notebook.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/qmd-embed/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/qmd-embed/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/qmd-embed/notebook.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/qmd-embed/notebook.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/embed/qmd-embed/notebook2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/embed/qmd-embed/notebook2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/empty-frontmatter-julia.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/empty-frontmatter-julia.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/empty-frontmatter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/empty-frontmatter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/engine/_includes-r-statements.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/engine/_includes-r-statements.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/engine/invalid-project/notebook.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/engine/invalid-project/notebook.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/engine/test-include-engine-detection.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/engine/test-include-engine-detection.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/basic/filter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/basic/filter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/basic/format.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/basic/format.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/basic/shortcodes.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/basic/shortcodes.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/format/academic/document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/format/academic/document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/format-resources/9918/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/format-resources/9918/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/install/placeholder.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/install/placeholder.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/lexcorp/lexcorp.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/lexcorp/lexcorp.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/project/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/project/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/project/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/extensions/project/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/project/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/project/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/project/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/project/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/revealjs/bundle/preso.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/revealjs/bundle/preso.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/revealjs/embedded/preso.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/revealjs/embedded/preso.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/extensions/revealjs/simple/preso.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/extensions/revealjs/simple/preso.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/filters/both.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/filters/both.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/filters/filter-order.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/filters/filter-order.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/filters/lua-filter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/filters/lua-filter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/filters/python-filter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/filters/python-filter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/c.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/c.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub1/a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub1/a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub1/c.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub1/c.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub2/a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub2/a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub2/c.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub2/c.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub3/a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/c.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub3/c.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/sub3-2/a.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub3/sub3-2/a.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/sub3-2/a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/globs/sub3/sub3-2/a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/sub3-2/sub3-2-1/sub3-2-1-1/a.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/globs/sub3/sub3-2/sub3-2-1/sub3-2-1-1/a.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/globs/sub3/sub3-2/sub3-2-1/sub3-2-1-1/c.Rmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/globs/sub3/sub3-2/sub3-2-1/sub3-2-1-1/c.Rmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/10039.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/inspect/10039.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/_bar.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/inspect/_bar.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/cleanup-issue-12336/cleanup-bug.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/inspect/cleanup-issue-12336/cleanup-bug.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/foo.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/inspect/foo.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/website-with-extensions/extension-test/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/inspect/website-with-extensions/extension-test/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/inspect/website-with-extensions/extension-test/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/inspect/website-with-extensions/extension-test/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jats/basic.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jats/basic.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jats/empty.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jats/empty.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/julia/intermediate-markdown-output/output-cell-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/julia/intermediate-markdown-output/output-cell-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jupyter/cache/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jupyter/cache/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jupyter/cache-non-default/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jupyter/cache-non-default/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jupyter/intermediate-markdown-output/output-cell-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/jupyter/intermediate-markdown-output/output-cell-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jupyter/parameters/issue-10097.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jupyter/parameters/issue-10097.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/jupyter/parameters/issue-11990.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/jupyter/parameters/issue-11990.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/knitr/intermediate-markdown-output/output-cell-div.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/knitr/intermediate-markdown-output/output-cell-div.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/languages/mermaid/test1-jupyter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/languages/mermaid/test1-jupyter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/languages/mermaid/test1-rmd.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/languages/mermaid/test1-rmd.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latex-output/captionless-margin-image.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/latex-output/captionless-margin-image.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latex-output/figure-div.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latex-output/figure-div.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/all.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/all.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/babel.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/babel.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/bibliography-biblatex.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/bibliography-biblatex.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/bibliography-citeproc.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/bibliography-citeproc.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/bibliography-natbib.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/bibliography-natbib.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/chunks.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/chunks.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/estopdf.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/estopdf.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/make-index-custom.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/make-index-custom.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/make-index.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/make-index.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/missing-font.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/missing-font.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/latexmk/plain.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/latexmk/plain.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/listings/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/lab-reports/10000-applications/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/lab-reports/10000-applications/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/lab-reports/20000-applications/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/lab-reports/20000-applications/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/lab-reports/5-months-and-9000-apps-later/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/lab-reports/5-months-and-9000-apps-later/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/lab-reports/empty-report/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/lab-reports/empty-report/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/meeting-notes/app-store-raw-data/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/meeting-notes/app-store-raw-data/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/meeting-notes/apps-for-a-song/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/meeting-notes/apps-for-a-song/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/meeting-notes/brown-zune/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/meeting-notes/brown-zune/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/meeting-notes/build-and-test-analytics/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/meeting-notes/build-and-test-analytics/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/meeting-notes/comparing-app-store-categories/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/meeting-notes/comparing-app-store-categories/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/other-reports/app-store-business-model-lite/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/other-reports/app-store-business-model-lite/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/other-reports/app-store-category-growth/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/other-reports/app-store-category-growth/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/other-reports/app-store-comments/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/other-reports/app-store-comments/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/other-reports/app-store-data-december-2009/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/other-reports/app-store-data-december-2009/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/listings/other-reports/empty-report/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/listings/other-reports/empty-report/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/logging/lua-error.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/logging/lua-error.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/luacov/report.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/luacov/report.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/base/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/manuscript/base/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/ipynb-full/article.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/manuscript/ipynb-full/article.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/ipynb-full/notebooks/seismic-monitoring-stations.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/manuscript/ipynb-full/notebooks/seismic-monitoring-stations.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/qmd-full/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/manuscript/qmd-full/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/qmd-full/notebook.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/manuscript/qmd-full/notebook.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/manuscript/qmd-single/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/manuscript/qmd-single/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/markdown/commonmark-julia.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/markdown/commonmark-julia.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/markdown/commonmark-julianative.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/markdown/commonmark-julianative.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/markdown/commonmark-plain.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/markdown/commonmark-plain.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/markdown/commonmark-python.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/markdown/commonmark-python.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/markdown/commonmark-r.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/markdown/commonmark-r.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/minimal.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/minimal.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ojs/test-complex-layout-string.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/ojs/test-complex-layout-string.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ojs/test-dependency-traversal-2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/ojs/test-dependency-traversal-2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ojs/test-dependency-traversal.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/ojs/test-dependency-traversal.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/ojs/test-ojs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/ojs/test-ojs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/page-layout/tufte-html.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/page-layout/tufte-html.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/page-layout/tufte-pdf.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/page-layout/tufte-pdf.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/pandoc/pandoc.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/pandoc/pandoc.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/partition-cell-options/issue-3901.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/partition-cell-options/issue-3901.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/default.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/default.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/grid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/grid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/post with space/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/post with space/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/post with space/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/post with space/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts2/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/post with space/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/post with space/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/posts3/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/blog/simple-blog/table.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/blog/simple-blog/table.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/embed-resources/issue-11860/main.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/embed-resources/issue-11860/main.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-font-size.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/html/code-font-size.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-a11y.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-a11y.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-arrow.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-arrow.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-atom-one.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-atom-one.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-ayu-mirage.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-ayu-mirage.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-ayu.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-ayu.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-breeze.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-breeze.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-breezedark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-breezedark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-dracula.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-dracula.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-espresso.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-espresso.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-github.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-github.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-gruvbox.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-gruvbox.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-haddock.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-haddock.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-kate.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-kate.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-light-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-light-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-monochrome.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-monochrome.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-monokai.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-monokai.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-nord.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-nord.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-oblivion.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-oblivion.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-printing.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-printing.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-pygments.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-pygments.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-radical.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-radical.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-solarized.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-solarized.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-tango.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-tango.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-vim-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-vim-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-zenburn.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/code-highlight/code-highlight-zenburn.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/brand-after-theme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/brand-after-theme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/brand-before-theme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/brand-before-theme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/brand-false.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/brand-false.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/brand-under-theme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/brand-under-theme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/simple-respect-color-scheme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/simple-respect-color-scheme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-dark/simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-light/simple-respect-color-scheme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-light/simple-respect-color-scheme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-light/simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/project-light/simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/syntax-highlighting/a11y-syntax-highlighting.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/syntax-highlighting/a11y-syntax-highlighting.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-brand/syntax-highlighting/arrow-syntax-highlighting.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-brand/syntax-highlighting/arrow-syntax-highlighting.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/dark-light-theme-custom/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/dark-light-theme-custom/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/default-border-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/default-border-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/mainfont/mainfont-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/math/katex/crossref-popup.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/math/katex/crossref-popup.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/math/katex/embed-except-math.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/math/katex/embed-except-math.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/math/katex/embed-with-math.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/math/katex/embed-with-math.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/math/katex/not-embed.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/math/katex/not-embed.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/tables/markdown-tables-cap-bottom.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/tables/markdown-tables-cap-bottom.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/tables/markdown-tables.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/tables/markdown-tables.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/tabsets/jupyter-tabsets.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/tabsets/jupyter-tabsets.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-brand-only-file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-brand-only-file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-brand-only.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-brand-only.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-light-brand-file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-light-brand-file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-light-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/dark-light-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-brand-only-file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-brand-only-file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-brand-only.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-brand-only.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-dark-brand-file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-dark-brand-file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-dark-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/light-dark-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-colors-file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-colors-file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-colors.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-colors.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-light-only.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-light-only.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/html/unified-brand/unified-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/bad-attachment.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/bad-attachment.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test-arquero-bug.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/test-arquero-bug.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test-bad-import.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/test-bad-import.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test-multiple-errors.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/test-multiple-errors.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test-no-echo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/test-no-echo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test-yaml-offset.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/errors/test-yaml-offset.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/errors/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/ojs/errors/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-import-refusal.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-import-refusal.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-inline-spans.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-inline-spans.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-no-ojs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/ojs/test-no-ojs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-computes.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-computes.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-define-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-define-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-define-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-define-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-echo-false-codetools-dropdown-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-echo-false-codetools-dropdown-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-echo-false-codetools-dropdown.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-echo-false-codetools-dropdown.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-es-modules.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-es-modules.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-static-data.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs-static-data.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/ojs/test-ojs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/ojs/test-ojs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/callouts/custom-colors.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/callouts/custom-colors.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/callouts/dracula-theme-tweaks.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/callouts/dracula-theme-tweaks.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/code-font-size.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/code-font-size.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/heading-color/serif.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/heading-color/serif.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/heading-color/simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/heading-color/simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/links-id.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/revealjs/links-id.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/logo-footer.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/playwright/revealjs/logo-footer.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/revealjs/scroll-view-activate.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/revealjs/scroll-view-activate.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/serve/shiny-r/tabby-html.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/serve/shiny-r/tabby-html.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/playwright/serve/shiny-r/tabby-reveal.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/playwright/serve/shiny-r/tabby-reveal.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/book/_include.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/book/_include.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/book/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/book/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/book/intro.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/book/intro.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/book/references.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/book/references.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/book/summary.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/book/summary.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/plain/plain.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/plain/plain.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/plain/plain2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/plain/plain2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/extension/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/prepost/extension/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/invalid-mutate/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/invalid-mutate/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/invalid-mutate/listing.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/invalid-mutate/listing.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/issue-10828/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/issue-10828/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/issue-10828/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/issue-10828/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/mutate-render-list/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/mutate-render-list/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/prepost/mutate-render-list/listing.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/project/prepost/mutate-render-list/listing.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/site/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/site/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/project/site/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/project/site/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/quarto-required.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/quarto-required.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/aside-footnotes.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/aside-footnotes.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/fragments.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/fragments.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/absolute.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/absolute.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/auto-animate-code.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/auto-animate-code.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/auto-animate-movement.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/reveal/mini/auto-animate-movement.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/auto-animate-stack.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/auto-animate-stack.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/auto-animate.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/auto-animate.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/fragments-nested.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/fragments-nested.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/fragments.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/fragments.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/stack.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/stack.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/mini/zoom.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/mini/zoom.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/output-location.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/output-location.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/reveal-configs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/reveal-configs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/reveal/stretch.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/reveal/stretch.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/schema-validation/good-validation-fail.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/schema-validation/good-validation-fail.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/scholar/generated-bib.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/scholar/generated-bib.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/scholar/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/scholar/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-10285/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/intro.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-10285/intro.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/references.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-10285/references.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/search-test-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/search/issue-10285/search-test-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/search-test-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/search/issue-10285/search-test-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/search-test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-10285/search-test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-10285/summary.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-10285/summary.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-9905/navbar/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-9905/navbar/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/search/issue-9905/sidebar/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/search/issue-9905/sidebar/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/self-contained/simple.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/self-contained/simple.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/brand-light-dark.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/brand-light-dark.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/brand-logo-dark.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/brand-logo-dark.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/brand-logo-light.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/brand-logo-light.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/brand-logo-one-brand.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/brand-logo-one-brand.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/custom.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/custom.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/metadata-error.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/metadata-error.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/metadata.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/metadata.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/vars-error.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/vars-error.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/vars-links.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/vars-links.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/shortcodes/vars-simple.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/shortcodes/vars-simple.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site/subfolder/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site/subfolder/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-navigation/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-navigation/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-navigation/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-navigation/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-navigation/page1.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-navigation/page1.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-navigation/page2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-navigation/page2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-navigation/page3.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-navigation/page3.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-themes/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-themes/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/site-themes/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/site-themes/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/29/ast-roundtrip-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/29/ast-roundtrip-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/29/hello.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/09/29/hello.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/30/author-crossref-conditions/author.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/30/author-crossref-conditions/author.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/30/author-crossref-conditions/crossref.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/30/author-crossref-conditions/crossref.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/30/caption-footnotes/test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/30/caption-footnotes/test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/30/crossref-false/crossref-false.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/30/crossref-false/crossref-false.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/09/30/custom-writer-emulation/customwriter-yaml.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/09/30/custom-writer-emulation/customwriter-yaml.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/06/issue-2228.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/10/06/issue-2228.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/11/issue-2765.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/10/11/issue-2765.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/12/test-customformat-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/12/test-customformat-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/12/test-customformat.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/12/test-customformat.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/14/google-scholar-project/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/14/google-scholar-project/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/14/google-scholar-project/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/14/google-scholar-project/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/14/invalid-highlight-theme.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/14/invalid-highlight-theme.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/31/callout-inner-content/callout-filter-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/31/callout-inner-content/callout-filter-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/31/include-notebook/embed-sub.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/31/include-notebook/embed-sub.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/10/31/include-notebook/embed.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/10/31/include-notebook/embed.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/01/3126.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/11/01/3126.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/14/3310.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/11/14/3310.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/15/callout-icon-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/11/15/callout-icon-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/17/3359a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/11/17/3359a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/17/3359b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/11/17/3359b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/18/mermaid-themes/3328.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/11/18/mermaid-themes/3328.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/19/kbd-test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2022/11/19/kbd-test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/22/annote/test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/11/22/annote/test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/11/29/callout-constructor.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/11/29/callout-constructor.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/12/12/code-annotation.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/12/12/code-annotation.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2022/12/9/jats/example.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2022/12/9/jats/example.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/02/citation-true.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/02/citation-true.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-hover.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-hover.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-latex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-latex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-select.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-select.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/03/code-annote-simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/03/issue-3833.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/03/issue-3833.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/04/issue-3847.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/04/issue-3847.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/05/content-hidden.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/05/content-hidden.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/05/notebook-preview-complex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/05/notebook-preview-complex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/05/notebook-preview-simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/05/notebook-preview-simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/05/pdf-remote-image.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/05/pdf-remote-image.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/06/input-relative/test/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/06/input-relative/test/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/06/issue-3872.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/06/issue-3872.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/06/test-filters.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/06/test-filters.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/06/test-inner-content.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/06/test-inner-content.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/09/gfm-callout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/09/gfm-callout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/12/knitr-options-yaml.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/12/knitr-options-yaml.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/13/lua-raw-html.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/13/lua-raw-html.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-none.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-none.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-select.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-select.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-two-cells.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/16/code-annote-two-cells.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/16/main.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/16/main.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/16/md-captions.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/16/md-captions.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/17/format-variants.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/17/format-variants.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/17/online-image-mediabag.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/17/online-image-mediabag.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/18/3159.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/18/3159.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/19/2107-2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/19/2107-2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/19/2107.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/19/2107.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/20/asciidoc.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/20/asciidoc.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/20/test-quarto-disable-processing.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/20/test-quarto-disable-processing.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/23/reveal-config-quote-4063.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/23/reveal-config-quote-4063.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/23/table-options.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/23/table-options.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/24/4073.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/24/4073.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/26/4034.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/26/4034.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/26/4068.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/01/26/4068.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/26/asciidoc-annotated-code.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/26/asciidoc-annotated-code.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/26/asciidoc-callout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/26/asciidoc-callout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/27/asciidoc-video.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/27/asciidoc-video.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/31/asciidoc-kbd.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/31/asciidoc-kbd.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/31/asciidoc-theorems.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/31/asciidoc-theorems.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/01/31/css-code-annotation.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/01/31/css-code-annotation.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/01/3085-r.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/01/3085-r.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/01/4174.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/01/4174.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/05/4200-1.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/05/4200-1.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/05/4200.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/05/4200.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/08/4272.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/08/4272.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/13/dot-bug.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/13/dot-bug.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/22/cite-as-only.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/02/22/cite-as-only.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/22/generated-bib.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/02/22/generated-bib.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/22/no-cite-as.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/22/no-cite-as.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/24/issue-4423.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/24/issue-4423.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/02/25/issue-4316.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/02/25/issue-4316.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/01/issue-4568.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/01/issue-4568.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/01/issue-4586.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/01/issue-4586.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/02/issue-4402.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/02/issue-4402.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/03/article-layout/table-endnotes-4324.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/03/article-layout/table-endnotes-4324.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/03/article-layout/tabs-callouts-3280.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/03/article-layout/tabs-callouts-3280.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/03/issue-4621.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/03/issue-4621.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/07/callout-footnote.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/07/callout-footnote.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/07/issue-2997.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/07/issue-2997.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/08/issue-3683.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/08/issue-3683.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/08/issue-4710.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/08/issue-4710.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/08/revealjs-hash-number-pandoc-style.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/08/revealjs-hash-number-pandoc-style.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/08/revealjs-hash-number.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/08/revealjs-hash-number.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/14/issue-1093.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/14/issue-1093.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/14/issue-4748.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/14/issue-4748.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/17/4867.qmd", {
  testthat::skip("Skipping problematic file: examples/quarto-cli/tests/docs/smoke-all/2023/03/17/4867.qmd")
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/22/gha-toc-4917.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/22/gha-toc-4917.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/24/3152.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/24/3152.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/28/remote-resources.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/03/28/remote-resources.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/29/5011.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/29/5011.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/30/5044.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/30/5044.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/03/30/issue-5031.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/03/30/issue-5031.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/01/5060.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/01/5060.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/04/5089.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/04/5089.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/04/issue-5084.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/04/issue-5084.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/04/ojs_define.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/04/ojs_define.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/06/5112.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/06/5112.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/11/format_underscores.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/04/11/format_underscores.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/18/test-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/04/18/test-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/20/callout-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/04/20/callout-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/24/5286.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/24/5286.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/24/format-links.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/04/24/format-links.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/26/issue-5317.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/26/issue-5317.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/27/5316.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/04/27/5316.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/04/27/mergetablehtml.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/04/27/mergetablehtml.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/01/5377.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/01/5377.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/03/5189.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/03/5189.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/03/5368.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/03/5368.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/09/5472.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/09/5472.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/11/5507.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/11/5507.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/15/5536-codefilename-beamer.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/15/5536-codefilename-beamer.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/16/5534.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/16/5534.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/16/empty-data-qmd.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/16/empty-data-qmd.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/24/5657-raw.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/24/5657-raw.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/24/5661-html.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/24/5661-html.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/24/unshortcode.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/24/unshortcode.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/25/callout-missing-title.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/25/callout-missing-title.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/25/escaped-shortcode-in-code.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/25/escaped-shortcode-in-code.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/30/crossrefs-dataqmd.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/30/crossrefs-dataqmd.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/30/shortcode-table-dataqmd.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/05/30/shortcode-table-dataqmd.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/05/31/issue-5506.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/05/31/issue-5506.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/06/07/issue-5783.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/06/07/issue-5783.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/06/12/ojs-local-ts-import.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/06/12/ojs-local-ts-import.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/06/13/5902.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/06/13/5902.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/06/21/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/06/21/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/03/table-colwidths.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/07/03/table-colwidths.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/10/6153.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/07/10/6153.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/17/echo-fenced-annotation.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/07/17/echo-fenced-annotation.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/18/6237.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/07/18/6237.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/20/issue-6289.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/07/20/issue-6289.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/24/code-annotation-exec-only.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/07/24/code-annotation-exec-only.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/24/code-annotation-false.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/07/24/code-annotation-false.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/28/6367.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/07/28/6367.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/07/31/4057.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/07/31/4057.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/08/22/asciidoc-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/08/22/asciidoc-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/08/22/issue-6584.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/08/22/issue-6584.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/08/30/6658.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/08/30/6658.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/08/knitr-quarto-tools-env.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/08/knitr-quarto-tools-env.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/11/6800.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/11/6800.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/14/6833.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/14/6833.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/14/confluence-cross-refs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/14/confluence-cross-refs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2492-b.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2492-b.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2492.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2492.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2546.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-2546.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-6907.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/19/issue-6907.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/19/table-code-cell-location-bug.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/19/table-code-cell-location-bug.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/21/issue-6935.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/21/issue-6935.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/22/beamer-numsec.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/22/beamer-numsec.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/25/6985.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/25/6985.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/25/6993.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/25/6993.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/25/issue-6990.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/25/issue-6990.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/26/6977.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/26/6977.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041-d.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041-d.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041-e.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041-e.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/27/7041.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/28/7066.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/28/7066.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/29/7072.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/29/7072.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/29/7079.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/29/7079.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/29/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/09/29/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/09/30/_pdf-marginfloats.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/09/30/_pdf-marginfloats.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/issue.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/issue.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/nb.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6521/nb.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6568.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6568.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6853.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/6853.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/02/7108.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/02/7108.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/03/7118.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/03/7118.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/04/5637.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/04/5637.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/04/6077.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/04/6077.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/04/6965.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/04/6965.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/04/content-hidden.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/04/content-hidden.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/06/theorem-ast.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/06/theorem-ast.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-b.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-b.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-jupyter.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-jupyter.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187-knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/10/issue-7187.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/11/unicode-subref-labels.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/11/unicode-subref-labels.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/12/7215.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/12/7215.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/16/7236.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/16/7236.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/17/issue-7259.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/17/issue-7259.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7197.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7197.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259b/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259b/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259b/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259b/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259c.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7259c.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7264.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7264.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7265.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7265.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7267.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/18/7267.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/19/7197b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/19/7197b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/19/7294.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/19/7294.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/19/_7276-prefer-html-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/19/_7276-prefer-html-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/19/_7276-prefer-html.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/10/19/_7276-prefer-html.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/24/7334.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/24/7334.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/27/7381.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/27/7381.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/29/6985-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/29/6985-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/30/5101-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/30/5101-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/30/5101.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/30/5101.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/30/7424.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/30/7424.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/10/30/7429.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/10/30/7429.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/02/7262.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/02/7262.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/02/latex-quarto-markdown-base64.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/11/02/latex-quarto-markdown-base64.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/06/7466.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/06/7466.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/08/7516.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/08/7516.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/08/7522.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/08/7522.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/09/3650.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/09/3650.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/10/7905.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/10/7905.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/13/7534.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/13/7534.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/14/7494.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/14/7494.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/14/7568.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/14/7568.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/15/4370.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/15/4370.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/15/5403.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/15/5403.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/15/7516-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/15/7516-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/16/7604.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/16/7604.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/16/tbl-cap-classes.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/11/16/tbl-cap-classes.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/17/foo/7236.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/17/foo/7236.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/17/foo/Foo.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/17/foo/Foo.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/20/7632.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/20/7632.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/20/layout-ncol.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/11/20/layout-ncol.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/21/7655.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/21/7655.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/24/typst-code.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/24/typst-code.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7704.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7704.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7718.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7718.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7721.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7721.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7727.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/27/7727.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/28/6866.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/28/6866.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/11/29/7744.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/11/29/7744.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/01/1237.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/01/1237.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/subdir/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/12/04/7784/subdir/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/04/annotate-decorated.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/12/04/annotate-decorated.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/05/4927.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/05/4927.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/05/knitr-handled-language-cell-options.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/12/05/knitr-handled-language-cell-options.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/06/7607.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/06/7607.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/06/7808.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/06/7808.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/06/canonical.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/06/canonical.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/07/7594.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/07/7594.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/08/7619.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/08/7619.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/11/4376.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/11/4376.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/11/7861.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/11/7861.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/12/2683.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/12/2683.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/13/7913.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/13/7913.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/14/6118.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/14/6118.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/18/7937.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/18/7937.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/18/7945.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/18/7945.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/19/6157.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/19/6157.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/19/7045.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2023/12/19/7045.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2023/12/22/jupyter-no-title-empty-header.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2023/12/22/jupyter-no-title-empty-header.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/03/8055-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/03/8055-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/03/8071.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/03/8071.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/03/issue-8086.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/03/issue-8086.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/05/8066.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/05/8066.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/05/issue-8000.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/05/issue-8000.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/08/8174.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/08/8174.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/08/empty-links.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/08/empty-links.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/09/8002.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/09/8002.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/09/8187.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/09/8187.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/10/8206.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/10/8206.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/11/8234.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/11/8234.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/16/8289.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/16/8289.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8118.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8118.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8274.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8274.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8314.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8314.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8316.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/17/8316.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/18/8331.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/18/8331.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/18/docusaurus/callouts.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/18/docusaurus/callouts.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/18/docusaurus/equations.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/18/docusaurus/equations.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/8354.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/8354.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/8356.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/8356.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-code-annotations.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-code-annotations.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-raw-mdx-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-raw-mdx-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-tabsets.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus/docusaurus-tabsets.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus-columns.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/19/docusaurus-columns.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/22/8389.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/22/8389.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/23/email-no-email.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/23/email-no-email.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/24/8362.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/24/8362.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/24/8417.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/24/8417.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/26/issue-8299-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/26/issue-8299-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/26/issue-8299-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/01/26/issue-8299-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/27/8464/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/27/8464/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/27/8464/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/27/8464/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/29/8485.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/29/8485.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/01/31/8507.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/01/31/8507.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/01/8536.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/01/8536.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/intro.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/intro.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/summary.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/01/issue-8514/summary.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/03/8580-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/03/8580-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/03/8586.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/03/8586.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/05/8603.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/05/8603.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/08/latex-escape.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/08/latex-escape.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/10/8670.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/10/8670.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/11/8582.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/11/8582.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/12/8582-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/12/8582-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/12/issue-8712/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/12/issue-8712/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/12/issue-8712/notebooks/explore-earthquakes.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/12/issue-8712/notebooks/explore-earthquakes.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/13/empty-floats.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/13/empty-floats.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/14/8733.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/14/8733.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/docs/_in.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/docs/_in.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/subdir/test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/21/8779/subdir/test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/intro.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/intro.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/summary.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8814/summary.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8841-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8841-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8843/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/22/8843/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/23/8785.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/23/8785.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/26/8454.Qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/26/8454.Qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/02/28/8919-a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/02/28/8919-a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/04/r_cell_error/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/03/04/r_cell_error/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/11/9041.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/11/9041.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/14/9076.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/14/9076.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/22/8998.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/22/8998.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/25/8770.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/25/8770.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/25/9190.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/25/9190.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/27/9117--issue.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/03/27/9117--issue.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/27/9200.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/27/9200.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/03/28/9219.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/03/28/9219.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/10/9179.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/10/9179.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/11/9335.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/11/9335.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/17/9356/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/17/9356/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/17/9356/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/17/9356/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/18/9414.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/18/9414.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/19/9422.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/19/9422.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/25/lightbox-no-caption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/04/25/lightbox-no-caption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/04/26/9365.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/04/26/9365.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/01/9550.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/01/9550.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/03/9548.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/03/9548.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/file.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/file.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/test/something.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/about/test/something.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/root-page.index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9524/root-page.index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9582.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9582.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9593.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/06/9593.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/08/6945.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/08/6945.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/08/8372.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/08/8372.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/09/9631.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/09/9631.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/13/9635.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/13/9635.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/14/9665.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/14/9665.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/14/placeholder-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/05/14/placeholder-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/15/9675.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/15/9675.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/15/9691.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/15/9691.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9680.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9680.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9681.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9681.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9701.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/16/9701.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9694.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9694.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9722.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9722.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9724.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/20/9724.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-c.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/21/9734-c.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/29/9713/main.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/29/9713/main.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/29/9713/plots.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/29/9713/plots.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/05/31/9816.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/05/31/9816.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/03/9850.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/03/9850.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/04/9796.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/04/9796.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/04/9862.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/04/9862.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/06/9903.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/06/9903.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-1.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-1.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-3.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-3.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-4.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-4.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-5.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/07/9903-5.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9243-a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9243-a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9243-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9243-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9887.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9887.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9927.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/10/9927.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/5413.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/5413.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/8498.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/8498.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/8656.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/8656.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9969/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9969/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9972-a.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9972-a.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9972-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/12/9972-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/19/9208.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/19/9208.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/20/10018.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/20/10018.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/21/10091.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/21/10091.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/21/issue-8987/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/06/21/issue-8987/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/21/issue-8987/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/06/21/issue-8987/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/24/10112.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/24/10112.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/24/8667.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/24/8667.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/26/10100.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/26/10100.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/06/27/10165.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/06/27/10165.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/docs/foo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/docs/foo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/07/01/inspect-test/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-b.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-b.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-c.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-c.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-d.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004-d.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10004.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10168.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10168.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10181.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/10181.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/02/index-nil-value-caption-long-lightbox-bug/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/07/02/index-nil-value-caption-long-lightbox-bug/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/03/10217.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/03/10217.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/09/issue-10251/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/07/09/issue-10251/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/18/10324.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/18/10324.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/18/10328.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/18/10328.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/19/10334.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/19/10334.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/07/23/10358.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/07/23/10358.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/27/10624.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/08/27/10624.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/27/issue-9821.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/08/27/issue-9821.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-es-no-install.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-es-no-install.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-es.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-es.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-zh.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/08/30/10291/latex-hyphen-lang-zh.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/08/30/7715.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/08/30/7715.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/02/10655.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/09/02/10655.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/02/10657.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/09/02/10657.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/13/issue-10340.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/13/issue-10340.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/23/issue-10858.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/23/issue-10858.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10821-b.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10821-b.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10821.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10821.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10870.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/24/issue-10870.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/26/issue-10894-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/27/issue-10891.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/27/issue-10891.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/30/10931-2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/09/30/10931-2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/30/10931.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/09/30/10931.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/09/30/issue-10936.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/09/30/issue-10936.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/03/logo_reveal/revealjs-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/03/logo_reveal/revealjs-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/07/issue-10999.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/07/issue-10999.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/08/issue-10438.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/08/issue-10438.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/08/issue-8179.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/08/issue-8179.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/16/8012.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/16/8012.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-10401.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-10401.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-8932/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-8932/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-8932/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/17/issue-8932/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/22/11146.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/22/11146.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/22/issue-10292.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/22/issue-10292.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/22/issue-11121.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/22/issue-11121.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/below.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/below.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/hover.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/hover.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/select.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/7142/select.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10001.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10001.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-10829/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-8428.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/issue-8428.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/23/spilled-font-size.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/23/spilled-font-size.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/brand-typography-family-string/test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/brand-typography-family-string/test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts/a-test-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts/a-test-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts/a-test-post-og/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts/a-test-post-og/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10311/posts.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/revealjs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/revealjs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/tutorials-bad.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/tutorials-bad.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/tutorials-good.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-10567/tutorials-good.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-5625/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/28/issue-5625/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/29/9803.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2024/10/29/9803.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/29/feature-11192/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/29/feature-11192/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/30/issue-10864/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/30/issue-10864/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/10/30/issue-10864/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/10/30/issue-10864/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/11/04/issue-11303.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/11/04/issue-11303.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/11/14/issue-11401.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/11/14/issue-11401.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/11/14/issue-11441.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/11/14/issue-11441.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/11/27/issue-11549.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/11/27/issue-11549.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/03/issue-11580/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/10/issue-11654.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/10/issue-11654.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/12/11520/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/12/11520/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2024/12/17/issue-11699.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2024/12/17/issue-11699.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/01/08/7260.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/01/08/7260.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/01/10/issue-11835-b.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/01/10/issue-11835-b.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/01/10/issue-11835.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/01/10/issue-11835.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/01/29/issue-11664.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/01/29/issue-11664.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/01/31/11964.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/01/31/11964.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/02/01/11896.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/02/01/11896.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/02/21/12132.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/02/21/12132.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/05/12204/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/05/12204/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/06/issue-12006.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/06/issue-12006.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/21/issue-12344.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/21/issue-12344.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/25/issue-12354.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/25/issue-12354.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/27/12299-1.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/03/27/12299-1.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/27/12299.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/03/27/12299.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/31/383.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/03/31/383.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/31/issue-12338/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/31/issue-12338/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/03/31/issue-12338/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/03/31/issue-12338/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/lab-reports/1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/lab-reports/1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/lab-reports/2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/01/issue-8238/lab-reports/2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/04/12295.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/04/04/12295.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/07/9867.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/04/07/9867.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/07/issue-9089.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/04/07/issue-9089.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/09/issue-11695.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/09/issue-11695.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/09/issue-11948.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/09/issue-11948.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/09/kbd-adoc-bad-input.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/09/kbd-adoc-bad-input.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/11/issue-11338.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/11/issue-11338.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/14/11665.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/04/14/11665.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/04/23/issue-12598.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/04/23/issue-12598.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/13/issue-12727.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/13/issue-12727.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/15/test-gt-axe.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/15/test-gt-axe.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/18/issue12766-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/19/issue-12775.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/19/issue-12775.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/21/keep_ipynb_project/12780.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/21/keep_ipynb_project/12780.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/21/keep_ipynb_single-file/12780.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/21/keep_ipynb_single-file/12780.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/23/12806.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/2025/05/23/12806.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/05/23/issue-12815.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/05/23/issue-12815.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/06/11/issue-12853/quarto-test/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/06/11/issue-12853/quarto-test/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/06/11/issue-12853/quarto-test/somefolder/somefile.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/06/11/issue-12853/quarto-test/somefolder/somefile.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/06/12/issue-12676.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/06/12/issue-12676.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/2025/06/12/issue-12919.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/2025/06/12/issue-12919.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/grid.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/article-layout/grid.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/margin-location/reference-location-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/article-layout/margin-location/reference-location-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/compute-table-margin.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/compute-table-margin.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/compute-table-screen.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/compute-table-screen.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/plain-table-full.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/plain-table-full.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/tufte.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/article-layout/tables/tufte.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/appendix-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/appendix-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/appendix-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/appendix-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/chap-1-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/chap-1-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/chap-1-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/chap-1-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/code.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/code.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/formatting.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/formatting.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/part-1.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/part-1.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/htmlbook/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/page-footer/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/page-footer/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/page-footer/intro.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/page-footer/intro.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/page-footer/license.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/page-footer/license.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/page-footer/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/page-footer/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/page-footer/summary.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/page-footer/summary.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/simple/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/simple/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/simple/intro.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/simple/intro.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/simple/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/book/simple/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/book/simple/summary.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/book/simple/summary.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/intro.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/intro.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/references.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/references.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/summary.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/brand-icon-small-favicon-book/summary.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/choose-logo-resource.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/choose-logo-resource.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/default-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/default-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-path-alt.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-path-alt.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-path.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-path.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-resource-alt.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-resource-alt.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-resource.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/override-logo-resource.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/website-favicon/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/website-favicon/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/logo/website-favicon/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/logo/website-favicon/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/test-01/dashboard.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/test-01/dashboard.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/test-01/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/brand/test-01/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/brand/test-01/revealjs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/brand/test-01/revealjs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/callouts/a11y/issue-726.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/callouts/a11y/issue-726.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/citations/biblatex-refs-position.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/citations/biblatex-refs-position.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/citations/citeproc-refs-position.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/citations/citeproc-refs-position.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/citations/natbib-refs-position.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/citations/natbib-refs-position.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/code-annotations/code-annotations-none.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/code-annotations/code-annotations-none.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/code-annotations/code-annotations-offset.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/code-annotations/code-annotations-offset.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/code-line-numbers/code-line-numbers-document.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/code-line-numbers/code-line-numbers-document.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/code-line-numbers/code-line-numbers-highlight.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/code-line-numbers/code-line-numbers-highlight.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/conditional-content/meta.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/conditional-content/meta.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/conditional-content/when-format.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/conditional-content/when-format.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/4489-exeblocks-lang-value-confluence.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/4489-exeblocks-lang-value-confluence.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/5814-confluence-figure-sizing-is-ignored.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/5814-confluence-figure-sizing-is-ignored.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/5815-confluence-links-to-file-attachments-not-supported.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/5815-confluence-links-to-file-attachments-not-supported.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/9507-no-layouts.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/9507-no-layouts.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/callout.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/confluence/callout.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-cross-refs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-cross-refs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-hello-world.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-hello-world.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-smoke-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/confluence/confluence-smoke-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/contents-shortcode/from-code-cell.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/contents-shortcode/from-code-cell.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/callout/docx-callout-xref-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/callout/docx-callout-xref-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-6.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-6.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/asciidoc-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/asciidoc/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-simple-figure.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-simple-figure.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/docx-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/docx/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/fig-cap.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/fig-cap.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/gfm/gfm-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/gfm/gfm-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/gfm/gfm-float.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/gfm/gfm-float.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-6.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-6.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-lst-and-fig-cell.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-lst-and-fig-cell.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-ojs-lst-cap.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-ojs-lst-cap.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/html-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/html/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-6.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-6.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-lst-and-fig-cell.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-lst-and-fig-cell.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-ojs-lst-cap.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-ojs-lst-cap.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/hugo-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/hugo/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-6.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-6.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/jats-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/jats/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-custom-categories.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-custom-categories.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-fig-title.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-fig-title.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-caption-no-crossref.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-caption-no-crossref.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-no-cap-no-crossref.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-no-cap-no-crossref.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-longtable-fixup-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-margin-figure.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-margin-figure.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-no-tbl-label.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-raw-table-env-no-tbl-label.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/latex/latex-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/lst-cap-in-jupyter-cells.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/lst-cap-in-jupyter-cells.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/lst-cap-in-r-cells.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/lst-cap-in-r-cells.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/multirow-layout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/multirow-layout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/revealjs/revealjs-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/rawtablecaption.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/rawtablecaption.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-4.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-4.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-5.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-5.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-6.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-6.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-caption-formatting-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-caption-formatting-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-numbering-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-numbering-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-options-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-float-options-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-jupyter-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-jupyter-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-jupyter-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-jupyter-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-table-captions-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-knitr-table-captions-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-listings-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-listings-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-listings-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-listings-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-lst-cap-location-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-lst-cap-location-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-subfloat-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/float/typst/typst-subfloat-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/algorithm.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/algorithm.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/lemma-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/lemma-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/theorem-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/theorem-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/theorem-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/crossrefs/theorem/theorem-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/dark-brand.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/dark-brand.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/dark-theme.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/dark-theme.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-brandless.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-brandless.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-duobrand-echo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-duobrand-echo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-duobrand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/ggplot-duobrand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/gt-capcross.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/gt-capcross.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/light-brand.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/light-brand.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/light-theme.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/light-theme.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/both-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/both-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/dark-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/dark-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/light-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/light-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/no-brand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/lua-brand/no-brand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-brandless-defaultdark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-brandless-defaultdark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-brandless.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-brandless.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-duobrand-defaultdark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-duobrand-defaultdark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-duobrand.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dark-mode/matplotlib-duobrand.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dark-mode/no-brand.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dark-mode/no-brand.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/0-card-syntax.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/0-card-syntax.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/0-layout-headings.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/0-layout-headings.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-advanced.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-advanced.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-options-execute.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-options-execute.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-options.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-options.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-syntax.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-cell-syntax.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-content.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-content.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-tabset-advanced.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/1-card-tabset-advanced.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-cell-attr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-cell-attr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-cells-simple.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-cells-simple.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-complex.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-complex.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-divs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-divs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-flow-fill-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-flow-fill-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-flow-fill.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-flow-fill.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-height.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/2-layout-height.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-python.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-python.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-static.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/3-valuebox-static.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-basic.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-basic.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-footer.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-footer.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-nested.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/4-tabset-nested.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/5-inputpanel.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/5-inputpanel.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout-cells.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout-cells.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout-scrolling.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout-scrolling.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/5-sample-layout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/6-broken-example-card.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/6-broken-example-card.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar-columns.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar-columns.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar-global.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar-global.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/6-sidebar.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar-social-nopages.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar-social-nopages.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar-social.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar-social.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/7-navbar.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/8-pages.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/8-pages.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-bslib.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-bslib.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-no-title.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-no-title.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-page-fill-flow.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-page-fill-flow.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-page-orientation.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-page-orientation.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-r-cells.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-r-cells.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/9-theme-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/9-theme-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/finance.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/finance.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/flow.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/flow.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/mdtables.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/mdtables.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/ojs.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/ojs.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/ojs2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/ojs2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/penguins.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/penguins.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/rtables.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/_content/rtables.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/bugs/8552.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/dashboard/bugs/8552.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/dashboard/loose-content.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/dashboard/loose-content.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/embed/tables/inset-table.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/embed/tables/inset-table.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/embed/tables/parent.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/embed/tables/parent.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/engine-reordering/julia-engine/notebook.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/engine-reordering/julia-engine/notebook.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/engine-reordering/jupyter-engine/notebook.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/engine-reordering/jupyter-engine/notebook.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/fenced-div-reader-fixes/test-1.qmd", {
  testthat::skip("Skipping problematic file: examples/quarto-cli/tests/docs/smoke-all/fenced-div-reader-fixes/test-1.qmd")
})

test_that("examples/quarto-cli/tests/docs/smoke-all/format/html/code-links-manual.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/format/html/code-links-manual.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/format/html/code-links-root.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/format/html/code-links-root.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/format/html/code-links.auto.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/format/html/code-links.auto.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/inline-execution/inline-jupyter.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/inline-execution/inline-jupyter.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/inline-execution/inline-knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/inline-execution/inline-knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/body.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/body.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/left-body.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/left-body.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/left.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/left.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/right-body.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/right-body.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/right.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/3473-toc-side-body/right.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-default/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-default/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-light-cobalt/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-light-cobalt/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-light-dark/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/darkly-light-dark/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-cobalt_only/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-cobalt_only/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-default/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-default/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-light-cobalt/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/issues/4820-giscus-dark-mode/lightly-light-cobalt/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jats/basic.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/jats/basic.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-false.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-false.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-cell.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-cell.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-global-cell-false.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-global-cell-false.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-global.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/error/display-error-true-global.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/error/traceback.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/error/traceback.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/execution-env-project/execution-env-var.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/execution-env-project/execution-env-var.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/execution-env-var.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/execution-env-var.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/fig-format/matplotlib-svg.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/fig-format/matplotlib-svg.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/ipython-png.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/ipython-png.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/ipython-retina.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/ipython-retina.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-png.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-png.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-quarto-retina.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-quarto-retina.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-retina.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/image-dimensions/matplotlib-retina.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/inline-execution-jupyter.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/inline-execution-jupyter.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/subfigures/plotly.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/subfigures/plotly.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/title/proj/test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/title/proj/test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-no-title.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-no-title.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-title.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-title.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-weird-yaml.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/jupyter/title/qmd-weird-yaml.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/embed-verbatim-engine/knitr-embed-verbatim.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/knitr/embed-verbatim-engine/knitr-embed-verbatim.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/embed-verbatim-engine/revealjs-knitr-embed-verbatim.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/knitr/embed-verbatim-engine/revealjs-knitr-embed-verbatim.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/eng-sql.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/knitr/eng-sql.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/execute-options.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/knitr/execute-options.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/execution-env-project/execution-env-var.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/knitr/execution-env-project/execution-env-var.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/execution-env-var.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/knitr/execution-env-var.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/in-chunk-layout.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/knitr/in-chunk-layout.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/knitr/inline-code-execution/new-syntax.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/knitr/inline-code-execution/new-syntax.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/landscape/landscape.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/landscape/landscape.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/latex/table-captions-bottom.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/latex/table-captions-bottom.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/8697.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/8697.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/addtl/example.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lightbox/addtl/example.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/example.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/example.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/lightbox-explicit.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lightbox/lightbox-explicit.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/lightbox-off.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/lightbox-off.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/options.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/options.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/pandoc-figure.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lightbox/pandoc-figure.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/plot-layout.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/plot-layout.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lightbox/plot.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lightbox/plot.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-default-eager.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-default-eager.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-default.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-default.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-grid-eager.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-grid-eager.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-grid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-grid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-table-eager.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-table-eager.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-table.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/index-table.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-1.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-1.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-2.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-2.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-3.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/blog/post-3.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/listings/image-lazy-loading/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lua/6215/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/lua/6215/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lua/quarto-utils-match/test_match.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lua/quarto-utils-match/test_match.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lua-api/quarto-lua-filters-quarto-format-api.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lua-api/quarto-lua-filters-quarto-format-api.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/lua-api/typst/quartoluatypst.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/lua-api/typst/quartoluatypst.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/mermaid/backticks.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/mermaid/backticks.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/revealjs/jump-to-slide.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/revealjs/jump-to-slide.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/revealjs/scroll-view-config.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/revealjs/scroll-view-config.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/table/appearance-bottom-cap.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/table/appearance-bottom-cap.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/table/appearance.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/table/appearance.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/block-divs.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/block-divs.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/exper/brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/exper/brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/foreground-background.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/foreground-background.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/foreground-lines.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/foreground-lines.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/homedepot/brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/homedepot/brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/link-primary-brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/link-primary-brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/nobrand/brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/nobrand/brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit/brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit/brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit-duobrand/brand-color-light-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit-duobrand/brand-color-light-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit-duobrand/brand-color-light-light.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/posit-duobrand/brand-color-light-light.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-named-color-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-named-color-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-named-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-named-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-wrong-named-color-dark.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-wrong-named-color-dark.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-wrong-named-color-light.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-duobrand-wrong-named-color-light.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-named-brand-color.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/color/typst-css-named-brand-color.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/online-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/online-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/padding/brand-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/padding/brand-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/padding-xy/brand-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/padding-xy/brand-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/posit/brand-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/posit/brand-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/quarto/brand-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/quarto/brand-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/relative-path/brand-logo.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/logo/relative-path/brand-logo.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/complex/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/complex/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/dashed-font-weights.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/dashed-font-weights.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/font-list.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/font-list.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/google/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/google/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/kitchen-sink-1/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/kitchen-sink-1/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/kitchen-sink-2/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/kitchen-sink-2/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/nobrand/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/nobrand/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/relative-path/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/relative-path/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/simple/brand-typography.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/simple/brand-typography.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/title-inherit-base-family.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/brand-yaml/typography/title-inherit-base-family.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/callout.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/callout.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/default.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/default.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/none.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/none.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/translate.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/css-property-processing/translate.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/custom-fonts.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/custom-fonts.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/great-tables-oceania.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/great-tables-oceania.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/gt-islands.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/gt-islands.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/juice/gt-table-images.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/juice/gt-table-images.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/juice/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/juice/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/layout/fraction-layout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/layout/fraction-layout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/layout/overflowing-callout-7.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/layout/overflowing-callout-7.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/layout/overflowing-callout.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/layout/overflowing-callout.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/layout/unitless-image-width.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/layout/unitless-image-width.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/pandas-cell-css-rules.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/pandas-cell-css-rules.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/relative-font-path/report1/report.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/relative-font-path/report1/report.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/tbl-align-issue10086.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/tbl-align-issue10086.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/typst-citeproc.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/typst-citeproc.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/typst-i18n.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/typst-i18n.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/typst-no-citeproc.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/typst-no-citeproc.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/typst-subfig-badid.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/typst/typst-subfig-badid.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/typst/typst-subfig.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/typst/typst-subfig.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/video/video-smoke-test.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/smoke-all/video/video-smoke-test.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/website/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/website/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/smoke-all/website/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/smoke-all/website/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/acm/document.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/acm/document.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/acs/document.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/acs/document.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/custom-template.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/custom-template.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/elsevier/document.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/elsevier/document.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/template-partial.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/template-partial.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/templates/title-partial-html.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/templates/title-partial-html.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-citeproc.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-citeproc.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-knitr-options.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-knitr-options.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-knitr-sql.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-knitr-sql.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-params.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-params.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-singleformat-context.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-singleformat-context.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-singleformat-docx.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-singleformat-docx.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test-singleformat-html.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test-singleformat-html.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test.Rmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test.Rmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/test.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/test.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/dark.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/dark.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/default.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/default.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/github-dark.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/github-dark.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/github-pdf.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/github-pdf.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/markdown-quarto-syntax.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/text-highlighting/markdown-quarto-syntax.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/user-complex.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/user-complex.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/user-simple.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/user-simple.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/text-highlighting/vimdark-pdf.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/text-highlighting/vimdark-pdf.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/ansi/ansi-colors.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/ansi/ansi-colors.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/great-tables/air-quality.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/great-tables/air-quality.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/great-tables/carbon-intensity.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/great-tables/carbon-intensity.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/great-tables/islands.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/great-tables/islands.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/great-tables/oceania.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/great-tables/oceania.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/great-tables/solar-zenith.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/great-tables/solar-zenith.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/air-quality.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/gt/air-quality.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/gtcars.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/gt/gtcars.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/islands.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/gt/islands.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/mtcars.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/gt/mtcars.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/red-blue-palette.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/gt/red-blue-palette.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/gt/test-pattern.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/gt/test-pattern.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/pandas/acting-on-data.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/pandas/acting-on-data.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/pandas/concatenating-stylers.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/pandas/concatenating-stylers.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/pandas/confusion-matrix.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/typst/tables/pandas/confusion-matrix.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/typst/tables/pandas/weather.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/typst/tables/pandas/weather.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-default/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-default/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-default/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-default/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-default/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-env/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-env/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-env/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-env/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-env/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-gone/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-preprocessor/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/drafts-visible/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/no-drafts/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/drafts/no-drafts/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/no-drafts/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/drafts/no-drafts/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/draft-post/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/draft-post/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/post-with-code/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/post-with-code/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/welcome/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/drafts/no-drafts/posts/welcome/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-3686/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-3686/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-3686/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-3686/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-5756/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-5756/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-5756/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-5756/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-9253/_include.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-9253/_include.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-9253/_include2.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-9253/_include2.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-9253/about.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-9253/about.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/issue-9253/index.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/websites/issue-9253/index.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/search/merge-navbar-crumbs-configuration/about.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/search/merge-navbar-crumbs-configuration/about.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/websites/search/merge-navbar-crumbs-configuration/index.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/websites/search/merge-navbar-crumbs-configuration/index.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/bad-config-yaml/subfolder/bad-config-yaml.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/yaml/bad-config-yaml/subfolder/bad-config-yaml.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-julia-backticks.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/yaml/fail-validation-julia-backticks.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-julia.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/fail-validation-julia.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-jupyter-backticks.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/yaml/fail-validation-jupyter-backticks.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-jupyter.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/fail-validation-jupyter.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-knitr-backticks.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/yaml/fail-validation-knitr-backticks.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/fail-validation-knitr.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/fail-validation-knitr.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/guess-chunk-options-format-knitr.qmd", {
  ast <- testthat::expect_no_error(
    parse_rmd(
      "examples/quarto-cli/tests/docs/yaml/guess-chunk-options-format-knitr.qmd"
    ),
    class = "rmd_ast"
  )
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/issue-11967.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/issue-11967.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/test-tag-expr.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/test-tag-expr.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tests/docs/yaml/yaml-parse-dashes.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tests/docs/yaml/yaml-parse-dashes.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tools/sass-variable-explainer/_attic/hello.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tools/sass-variable-explainer/_attic/hello.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tools/sass-variable-explainer/_attic/main.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tools/sass-variable-explainer/_attic/main.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})

test_that("examples/quarto-cli/tools/sass-variable-explainer/sass-ui.qmd", {
  ast <- testthat::expect_no_error(parse_rmd(
    "examples/quarto-cli/tools/sass-variable-explainer/sass-ui.qmd"
  ), class = "rmd_ast")
  testthat::expect_equal(ast, parse_rmd(as_document(ast, padding = character())))
})
