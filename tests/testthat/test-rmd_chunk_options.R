test_that("rmd_get_options normalizes dash option names", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(fig.width = 8, fig.height = 6, out.width = "100%"),
    code = "plot(cars)"
  )
  
  # Test getting options using dash notation
  result_dash = rmd_get_options(chunk, "fig-width", "out-width")
  result_dot = rmd_get_options(chunk, "fig.width", "out.width")
  
  # Expected results
  expected_dash = list(`fig-width` = 8, `out-width` = "100%")
  expected_dot = list(fig.width = 8, out.width = "100%")
  
  expect_equal(result_dash, expected_dash)
  expect_equal(result_dot, expected_dot)
})

test_that("rmd_set_options normalizes dash option names", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    code = "plot(cars)"
  )
  
  # Set options using dash notation
  result = rmd_set_options(chunk, `fig-width` = 10, `out-height` = "75%")
  
  # Expected chunk with normalized option names
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(fig.width = 10, out.height = "75%"),
    code = "plot(cars)"
  )
  
  expect_equal(result, expected_chunk)
})

test_that("rmd_set_options and rmd_get_options work together with normalization", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test", 
    code = "plot(cars)"
  )
  
  # Set options using dash notation
  updated_chunk = rmd_set_options(chunk, `fig-width` = 8, `fig-height` = 6)
  
  # Get options using both notations
  dash_result = rmd_get_options(updated_chunk, "fig-width", "fig-height")
  dot_result = rmd_get_options(updated_chunk, "fig.width", "fig.height")
  
  # Expected results
  expected_dash = list(`fig-width` = 8, `fig-height` = 6)
  expected_dot = list(fig.width = 8, fig.height = 6)
  
  expect_equal(dash_result, expected_dash)
  expect_equal(dot_result, expected_dot)
})

test_that("rmd_get_options works with defaults and normalization", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(fig.width = 8),
    code = "plot(cars)"
  )
  
  defaults = list(fig.height = 6, out.width = "100%")
  
  # Get options using dash notation with defaults
  result = rmd_get_options(chunk, "fig-width", "fig-height", "out-width", defaults = defaults)
  
  # Expected result with defaults applied
  expected_result = list(
    `fig-width` = 8,        # from chunk
    `fig-height` = 6,       # from defaults
    `out-width` = "100%"     # from defaults
  )
  
  expect_equal(result, expected_result)
})

test_that("normalization preserves complex option names", {
  chunk = rmd_chunk(
    engine = "r",
    name = "test",
    code = "plot(cars)"
  )
  
  # Set options with multiple dashes/dots
  updated_chunk = rmd_set_options(chunk, 
    `fig-cap-location` = "bottom",
    `out-extra-css` = "color: red"
  )
  
  # Expected chunk with normalized option names
  expected_chunk = rmd_chunk(
    engine = "r",
    name = "test",
    options = list(fig.cap.location = "bottom", out.extra.css = "color: red"),
    code = "plot(cars)"
  )
  
  expect_equal(updated_chunk, expected_chunk)
  
  # Test retrieval with both notations
  dash_result = rmd_get_options(updated_chunk, "fig-cap-location", "out-extra-css")
  dot_result = rmd_get_options(updated_chunk, "fig.cap.location", "out.extra.css")
  
  expected_dash = list(`fig-cap-location` = "bottom", `out-extra-css` = "color: red")
  expected_dot = list(fig.cap.location = "bottom", out.extra.css = "color: red")
  
  expect_equal(dash_result, expected_dash)
  expect_equal(dot_result, expected_dot)
})