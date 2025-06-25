

test_that("C++ single shortcode parser - basic functionality", {
  
  # Test single shortcode with simple arguments
  expect_equal(
    check_shortcode_parser("{{< video url >}}"), 
    rmd_shortcode("video", "url")
  )
  
  # Test shortcode with no arguments
  expect_equal(
    check_shortcode_parser("{{< pagebreak >}}"), 
    rmd_shortcode("pagebreak", character())
  )
  
  # Test shortcode with multiple arguments
  expect_equal(
    check_shortcode_parser("{{< video arg1 arg2 arg3 >}}"), 
    rmd_shortcode("video", c("arg1", "arg2", "arg3"))
  )
  
  # Test shortcode with quoted arguments
  expect_equal(
    check_shortcode_parser("{{< video \"quoted arg\" >}}"), 
    rmd_shortcode("video", "\"quoted arg\"")
  )
  
  # Test shortcode with key=value arguments
  expect_equal(
    check_shortcode_parser("{{< video url=https://example.com >}}"), 
    rmd_shortcode("video", "url=https://example.com")
  )
  
  # Test shortcode with mixed argument types
  expect_equal(
    check_shortcode_parser("{{< include file.txt lines=10 echo=true >}}"), 
    rmd_shortcode("include", c("file.txt", "lines=10", "echo=true"))
  )
  
  # Test shortcode with function name containing special characters
  expect_equal(
    check_shortcode_parser("{{< video-player url >}}"), 
    rmd_shortcode("video-player", "url")
  )
  
  # Test shortcode with underscores and dots in function name
  expect_equal(
    check_shortcode_parser("{{< my_func.v2 arg >}}"), 
    rmd_shortcode("my_func.v2", "arg")
  )
})

test_that("C++ single shortcode parser - error cases", {
  
  # Test incomplete shortcode
  expect_error(check_shortcode_parser("{{< incomplete"), 
               "Failed to parse")
  
  # Test missing opening delimiter
  expect_error(check_shortcode_parser("video url >}}"), 
               "Failed to parse")
  
  # Test missing closing delimiter
  expect_error(check_shortcode_parser("{{< video url"), 
               "Failed to parse")
  
  # Test empty shortcode
  expect_error(check_shortcode_parser("{{<  >}}"), 
               "Failed to parse")
  
  # Test malformed delimiters
  expect_error(check_shortcode_parser("{{ video url >}}"), 
               "Failed to parse")
  
  # Test wrong closing delimiter
  expect_error(check_shortcode_parser("{{< video url }}"), 
               "Failed to parse")
})

test_that("C++ single shortcode parser - complex arguments", {
  
  # Test arguments with spaces in quotes
  expect_equal(
    check_shortcode_parser("{{< video \"file with spaces.mp4\" >}}"), 
    rmd_shortcode("video", "\"file with spaces.mp4\"")
  )
  
  # Test escaped quotes in arguments
  expect_equal(
    check_shortcode_parser("{{< kbd key=\"\\\"quoted\\\"\" >}}"), 
    rmd_shortcode("kbd", "key=\"\\\"quoted\\\"\"")
  )
  
  # Test mixed quotes
  expect_equal(
    check_shortcode_parser("{{< func arg1=\"value1\" arg2='value2' >}}"), 
    rmd_shortcode("func", c("arg1=\"value1\"", "arg2='value2'"))
  )
  
  # Test complex key=value arguments
  expect_equal(
    check_shortcode_parser("{{< video url=https://example.com title=\"My Video\" width=800 >}}"), 
    rmd_shortcode("video", c("url=https://example.com", "title=\"My Video\"", "width=800"))
  )
})

test_that("C++ string shortcodes parser - basic functionality", {
  
  # Test single shortcode
  expect_equal(
    parse_shortcodes_cpp("Hello {{< video url >}} world"),
    list(rmd_shortcode("video", "url", 6, 17))
  )
  
  # Test multiple shortcodes
  expect_equal(
    parse_shortcodes_cpp("{{< func1 >}} and {{< func2 arg >}}"),
    list(
      rmd_shortcode("func1", character(), 0, 13),
      rmd_shortcode("func2", "arg", 18, 17)
    )
  )
  
  # Test no shortcodes
  expect_equal(
    parse_shortcodes_cpp("Hello world with no shortcodes"),
    list()
  )
  
  # Test shortcode with no arguments
  expect_equal(
    parse_shortcodes_cpp("{{< pagebreak >}}"),
    list(rmd_shortcode("pagebreak", character(), 0, 17))
  )
})

test_that("C++ string shortcodes parser - argument parsing", {
  
  # Test simple arguments
  expect_equal(
    parse_shortcodes_cpp("{{< video arg1 arg2 arg3 >}}"),
    list(rmd_shortcode("video", c("arg1", "arg2", "arg3"), 0, 28))
  )
  
  # Test quoted arguments
  expect_equal(
    parse_shortcodes_cpp("{{< video \"quoted arg\" >}}"),
    list(rmd_shortcode("video", "\"quoted arg\"", 0, 26))
  )
  
  # Test single quoted arguments
  expect_equal(
    parse_shortcodes_cpp("{{< kbd key='Ctrl+C' >}}"),
    list(rmd_shortcode("kbd", "key='Ctrl+C'", 0, 24))
  )
  
  # Test key=value arguments
  expect_equal(
    parse_shortcodes_cpp("{{< video url=https://example.com title=\"My Video\" >}}"),
    list(rmd_shortcode("video", c("url=https://example.com", "title=\"My Video\""), 0, 54))
  )
  
  # Test mixed argument types
  expect_equal(
    parse_shortcodes_cpp("{{< include file.txt lines=10 echo=true >}}"),
    list(rmd_shortcode("include", c("file.txt", "lines=10", "echo=true"), 0, 43))
  )
})

test_that("C++ string shortcodes parser - multiline strings", {
  
  # Test shortcode spanning multiple lines
  expect_equal(
    parse_shortcodes_cpp("{{< video https://example.com/video.mp4
  title=\"My Long Video Title\"
  width=800
  height=600 >}}"),
    list(rmd_shortcode("video", c(
      "https://example.com/video.mp4",
      "title=\"My Long Video Title\"",
      "width=800",
      "height=600"
    ), 0, 98))
  )
  
  # Test multiple shortcodes across lines
  expect_equal(
    parse_shortcodes_cpp("Start {{< pagebreak >}}
  Middle text here
  {{< video url >}} more text
  {{< include file.txt >}} end"),
    list(
      rmd_shortcode("pagebreak", character(), 6, 17),
      rmd_shortcode("video", "url", 45, 17),
      rmd_shortcode("include", "file.txt", 75, 24)
    )
  )
  
  # Test shortcode with newlines in text around it
  expect_equal(
    parse_shortcodes_cpp("Line 1\n{{< shortcode arg >}}\nLine 3"),
    list(rmd_shortcode("shortcode", "arg", 7, 21))
  )
})

test_that("C++ string shortcodes parser - edge cases", {
  
  # Test escaped shortcode (currently parsed due to parser limitation)
  expect_equal(
    parse_shortcodes_cpp("{{{< escaped >}}}"),
    list()
  )
  
  # Test incomplete shortcode (should throw error)
  expect_error(
    parse_shortcodes_cpp("{{< incomplete"),
    "Failed to parse"
  )
  
  # Test shortcode with unmatched braces
  expect_equal(
    parse_shortcodes_cpp("{{ missing angle bracket >}}"),
    list()
  )
  
  # Test shortcode with special characters in function name
  expect_equal(
    parse_shortcodes_cpp("{{< video-player >}}"),
    list(rmd_shortcode("video-player", character(), 0, 20))
  )
  
  # Test shortcode with underscores and dots
  expect_equal(
    parse_shortcodes_cpp("{{< my_func.v2 >}}"),
    list(rmd_shortcode("my_func.v2", character(), 0, 18))
  )
  
  # Test shortcode with spaces around function name
  expect_equal(
    parse_shortcodes_cpp("{{<   video   arg   >}}"),
    list(rmd_shortcode("video", "arg", 0, 23))
  )
  
  # Test empty shortcode (should fail to parse)
  expect_error(
    parse_shortcodes_cpp("{{<  >}}"),
    "Failed to parse"
  )
})

test_that("C++ string shortcodes parser - complex quoted arguments", {
  
  # Test arguments with spaces in quotes
  expect_equal(
    parse_shortcodes_cpp("{{< video \"file with spaces.mp4\" >}}"),
    list(rmd_shortcode("video", "\"file with spaces.mp4\"", 0, 36))
  )
  
  # Test escaped quotes in arguments
  expect_equal(
    parse_shortcodes_cpp("{{< kbd key=\"\\\"quoted\\\"\" >}}"),
    list(rmd_shortcode("kbd", "key=\"\\\"quoted\\\"\"", 0, 28))
  )
  
  # Test mixed quotes
  expect_equal(
    parse_shortcodes_cpp("{{< func arg1=\"value1\" arg2='value2' >}}"),
    list(rmd_shortcode("func", c("arg1=\"value1\"", "arg2='value2'"), 0, 40))
  )
  
  # Test unterminated quote (should handle gracefully)
  expect_error(
    parse_shortcodes_cpp("{{< func \"unterminated >}}"),
    class = "Rcpp::exception"
  )
})

test_that("C++ string shortcodes parser - real-world examples", {
  
  # Example from Quarto documentation
  expect_equal(
    parse_shortcodes_cpp("{{< video https://www.youtube.com/embed/wo9vZccmqwc
  title=\"What is the CERN?\"
  start=\"116\"
  aspect-ratio=\"21x9\" >}}"),
    list(rmd_shortcode("video", c(
      "https://www.youtube.com/embed/wo9vZccmqwc",
      "title=\"What is the CERN?\"",
      "start=\"116\"",
      "aspect-ratio=\"21x9\""
    ), 0, 119))
  )
  
  # Multiple shortcodes in a document
  expect_equal(
    parse_shortcodes_cpp("# My Document
  
  Here is a video: {{< video demo.mp4 >}}
  
  {{< pagebreak >}}
  
  And here is some code:
  {{< include script.py lines=\"1-10\" echo=true >}}
  
  Finally, press {{< kbd Ctrl+C >}} to copy."),
    list(
      rmd_shortcode("video", "demo.mp4", 36, 22),
      rmd_shortcode("pagebreak", character(), 64, 17),
      rmd_shortcode("include", c("script.py", "lines=\"1-10\"", "echo=true"), 112, 48),
      rmd_shortcode("kbd", "Ctrl+C", 181, 18)
    )
  )
  
  # Shortcode with CSS-like selectors
  expect_equal(
    parse_shortcodes_cpp("{{< div .class #id data-attr=value >}}"),
    list(rmd_shortcode("div", c(".class", "#id", "data-attr=value"), 0, 38))
  )
})
