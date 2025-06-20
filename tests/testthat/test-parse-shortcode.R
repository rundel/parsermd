test_that("Shortcode arguments are parsed correctly", {
  
  expect_equal(
    check_shortcode_parser("{{< myfunc >}}"),
    rmd_shortcode("myfunc")
  )

  # TODO - check if this is the correct behavior
  expect_equal(
    check_shortcode_parser("{{< myfunc>}}"),
    rmd_shortcode("myfunc")
  )

  # TODO - check if this is the correct behavior
  expect_equal(
    check_shortcode_parser("{{< myfunc arg1>}}"),
    rmd_shortcode("myfunc", "arg1")
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc arg1 >}}"),
    rmd_shortcode("myfunc", "arg1")
  )
  
  expect_equal(
    check_shortcode_parser("{{< myfunc arg1 arg2 >}}"),
    rmd_shortcode("myfunc", c("arg1", "arg2")),
    info = "Shortcode: simple unquoted args"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc \"arg with spaces\" arg2 >}}"),
    rmd_shortcode("myfunc", c("\"arg with spaces\"", "arg2")),
    info = "Shortcode: double-quoted arg with spaces"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc arg1 'another quoted arg' >}}"),
    rmd_shortcode("myfunc", c("arg1", "'another quoted arg'")),
    info = "Shortcode: single-quoted arg with spaces"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc \"arg \\\"with\\\" quotes\" >}}"),
    rmd_shortcode("myfunc", "\"arg \\\"with\\\" quotes\""),
    info = "Shortcode: escaped quote in double-quoted arg"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc arg_no_space >}}"),
    rmd_shortcode("myfunc", "arg_no_space"),
    info = "Shortcode: single unquoted arg"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc >}}"),
    rmd_shortcode("myfunc"),
    info = "Shortcode: no arguments"
  )

  # Current parser captures unquoted key=value as a single string argument
  expect_equal(
    check_shortcode_parser("{{< myfunc arg1=\"val1\" >}}"),
    rmd_shortcode("myfunc", "arg1=\"val1\""),
    info = "Shortcode: unquoted arg with equals and quotes (captured as one string)"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc arg1 .class #id key=value >}}"),
    rmd_shortcode("myfunc", c("arg1", ".class", "#id", "key=value")),
    info = "Shortcode: unquoted args with special chars"
  )

  expect_equal(
    check_shortcode_parser("{{<  myfunc   arg1   \"arg two\"   >}}"),
    rmd_shortcode("myfunc", c("arg1", "\"arg two\"")),
    info = "Shortcode: leading/trailing spaces around args are handled"
  )

  expect_error(
    check_shortcode_parser("{{< myfunc arg1 \"unterminated quote >}}"),
    info = "Shortcode: unterminated quote in arg"
  )

  expect_error(
    check_shortcode_parser("{{< myfunc arg1 "),
    regexp = "expected shortcode close",
    info = "Shortcode: missing closing >}}"
  )

  expect_error(
    check_shortcode_parser("{{{< myfunc arg1 >}}}"),
    info = "Escaped shortcode reference with extra braces"
  )
})

test_that("Shortcode key=value arguments are parsed correctly", {
  expect_equal(
    check_shortcode_parser("{{< myfunc key=value >}}"),
    rmd_shortcode("myfunc", "key=value"),
    info = "Shortcode: simple key=value argument"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc key=\"quoted value\" >}}"),
    rmd_shortcode("myfunc", "key=\"quoted value\""),
    info = "Shortcode: key=value with quoted value"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc arg1 key=value arg2 >}}"),
    rmd_shortcode("myfunc", c("arg1", "key=value", "arg2")),
    info = "Shortcode: mixed positional and key=value arguments"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc key1=value1 key2=\"value with spaces\" >}}"),
    rmd_shortcode("myfunc", c("key1=value1", "key2=\"value with spaces\"")),
    info = "Shortcode: multiple key=value arguments"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc key_name=value >}}"),
    rmd_shortcode("myfunc", "key_name=value"),
    info = "Shortcode: key with underscore"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc key.name=value >}}"),
    rmd_shortcode("myfunc", "key.name=value"),
    info = "Shortcode: key with dot"
  )

  expect_equal(
    check_shortcode_parser("{{< myfunc key-name=value >}}"),
    rmd_shortcode("myfunc", "key-name=value"),
    info = "Shortcode: key with dash"
  )
})

test_that("Edge cases", {
  
  # From quarto_cli/tests/docs/smoke-all/video/video-smoke-test.qmd
  sc = '{{< video https://www.youtube.com/embed/wo9vZccmqwc
  title="What is the CERN?"
  start="116"
  aspect-ratio="21x9">}}'
  
  expect_equal(
    check_shortcode_parser(sc),
    rmd_shortcode(
      "video",
      c("https://www.youtube.com/embed/wo9vZccmqwc", 'title="What is the CERN?"',
       'start="116"', 'aspect-ratio="21x9"')
    )
  )

  # Semi-ambiguous edgecase from quarto-cli/tests/docs/smoke-all/2025/04/09/kbd-adoc-bad-input.qmd 
  expect_equal(
    check_shortcode_parser('{{< kbd key="\\" >}}'),
    rmd_shortcode("kbd", 'key="\\"')
  )

  expect_equal(
    check_shortcode_parser("{{< kbd key='\\' >}}"),
    rmd_shortcode("kbd", "key='\\'")
  )

})
