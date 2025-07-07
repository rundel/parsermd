test_that("C++ single shortcode parser - basic functionality", {
  
  expect_equal(
    check_shortcode_parser("{{< video url >}}"), 
    rmd_shortcode("video", "url")
  )
  
  expect_equal(
    check_shortcode_parser("{{< pagebreak >}}"), 
    rmd_shortcode("pagebreak", character())
  )
  
  expect_equal(
    check_shortcode_parser("{{< video arg1 arg2 arg3 >}}"), 
    rmd_shortcode("video", c("arg1", "arg2", "arg3"))
  )
  
  expect_equal(
    check_shortcode_parser("{{< video \"quoted arg\" >}}"), 
    rmd_shortcode("video", "\"quoted arg\"")
  )
  
  expect_equal(
    check_shortcode_parser("{{< video url=https://example.com >}}"), 
    rmd_shortcode("video", "url=https://example.com")
  )
  
  expect_equal(
    check_shortcode_parser("{{< include file.txt lines=10 echo=true >}}"), 
    rmd_shortcode("include", c("file.txt", "lines=10", "echo=true"))
  )
  
  expect_equal(
    check_shortcode_parser("{{< video-player url >}}"), 
    rmd_shortcode("video-player", "url")
  )
  
  expect_equal(
    check_shortcode_parser("{{< my_func.v2 arg >}}"), 
    rmd_shortcode("my_func.v2", "arg")
  )
})

test_that("C++ single shortcode parser - error cases", {
  

  expect_error(check_shortcode_parser("{{< incomplete"), 
               "Failed to parse")
  

  expect_error(check_shortcode_parser("video url >}}"), 
               "Failed to parse")
  

  expect_error(check_shortcode_parser("{{< video url"), 
               "Failed to parse")
  

  expect_error(check_shortcode_parser("{{<  >}}"), 
               "Failed to parse")
  

  expect_error(check_shortcode_parser("{{ video url >}}"), 
               "Failed to parse")
  

  expect_error(check_shortcode_parser("{{< video url }}"), 
               "Failed to parse")
})

test_that("C++ single shortcode parser - complex arguments", {
  

  expect_equal(
    check_shortcode_parser("{{< video \"file with spaces.mp4\" >}}"), 
    rmd_shortcode("video", "\"file with spaces.mp4\"")
  )
  

  expect_equal(
    check_shortcode_parser("{{< kbd key=\"\\\"quoted\\\"\" >}}"), 
    rmd_shortcode("kbd", "key=\"\\\"quoted\\\"\"")
  )
  

  expect_equal(
    check_shortcode_parser("{{< func arg1=\"value1\" arg2='value2' >}}"), 
    rmd_shortcode("func", c("arg1=\"value1\"", "arg2='value2'"))
  )
  

  expect_equal(
    check_shortcode_parser("{{< video url=https://example.com title=\"My Video\" width=800 >}}"), 
    rmd_shortcode("video", c("url=https://example.com", "title=\"My Video\"", "width=800"))
  )
})

test_that("C++ string shortcodes parser - basic functionality", {
  

  expect_equal(
    parse_shortcodes_cpp("Hello {{< video url >}} world"),
    list(rmd_shortcode("video", "url", 6L, 17L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< func1 >}} and {{< func2 arg >}}"),
    list(
      rmd_shortcode("func1", character(), 0L, 13L),
      rmd_shortcode("func2", "arg", 18L, 17L)
    )
  )
  

  expect_equal(
    parse_shortcodes_cpp("Hello world with no shortcodes"),
    list()
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< pagebreak >}}"),
    list(rmd_shortcode("pagebreak", character(), 0L, 17L))
  )
})

test_that("C++ string shortcodes parser - argument parsing", {
  

  expect_equal(
    parse_shortcodes_cpp("{{< video arg1 arg2 arg3 >}}"),
    list(rmd_shortcode("video", c("arg1", "arg2", "arg3"), 0L, 28L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< video \"quoted arg\" >}}"),
    list(rmd_shortcode("video", "\"quoted arg\"", 0L, 26L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< kbd key='Ctrl+C' >}}"),
    list(rmd_shortcode("kbd", "key='Ctrl+C'", 0L, 24L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< video url=https://example.com title=\"My Video\" >}}"),
    list(rmd_shortcode("video", c("url=https://example.com", "title=\"My Video\""), 0L, 54L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< include file.txt lines=10 echo=true >}}"),
    list(rmd_shortcode("include", c("file.txt", "lines=10", "echo=true"), 0L, 43L))
  )
})

test_that("C++ string shortcodes parser - multiline strings", {
  

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
    ), 0L, 98L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("Start {{< pagebreak >}}
  Middle text here
  {{< video url >}} more text
  {{< include file.txt >}} end"),
    list(
      rmd_shortcode("pagebreak", character(), 6L, 17L),
      rmd_shortcode("video", "url", 45L, 17L),
      rmd_shortcode("include", "file.txt", 75L, 24L)
    )
  )
  

  expect_equal(
    parse_shortcodes_cpp("Line 1\n{{< shortcode arg >}}\nLine 3"),
    list(rmd_shortcode("shortcode", "arg", 7L, 21L))
  )
})

test_that("C++ string shortcodes parser - edge cases", {
  

  expect_equal(
    parse_shortcodes_cpp("{{{< escaped >}}}"),
    list()
  )
  

  expect_error(
    parse_shortcodes_cpp("{{< incomplete"),
    "Failed to parse"
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{ missing angle bracket >}}"),
    list()
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< video-player >}}"),
    list(rmd_shortcode("video-player", character(), 0L, 20L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< my_func.v2 >}}"),
    list(rmd_shortcode("my_func.v2", character(), 0L, 18L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{<   video   arg   >}}"),
    list(rmd_shortcode("video", "arg", 0L, 23L))
  )
  

  expect_error(
    parse_shortcodes_cpp("{{<  >}}"),
    "Failed to parse"
  )
})

test_that("C++ string shortcodes parser - complex quoted arguments", {
  

  expect_equal(
    parse_shortcodes_cpp("{{< video \"file with spaces.mp4\" >}}"),
    list(rmd_shortcode("video", "\"file with spaces.mp4\"", 0L, 36L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< kbd key=\"\\\"quoted\\\"\" >}}"),
    list(rmd_shortcode("kbd", "key=\"\\\"quoted\\\"\"", 0L, 28L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< func arg1=\"value1\" arg2='value2' >}}"),
    list(rmd_shortcode("func", c("arg1=\"value1\"", "arg2='value2'"), 0L, 40L))
  )
  

  expect_error(
    parse_shortcodes_cpp("{{< func \"unterminated >}}"),
    class = "Rcpp::exception"
  )
})

test_that("C++ string shortcodes parser - real-world examples", {
  

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
    ), 0L, 119L))
  )
  

  expect_equal(
    parse_shortcodes_cpp("# My Document
  
  Here is a video: {{< video demo.mp4 >}}
  
  {{< pagebreak >}}
  
  And here is some code:
  {{< include script.py lines=\"1-10\" echo=true >}}
  
  Finally, press {{< kbd Ctrl+C >}} to copy."),
    list(
      rmd_shortcode("video", "demo.mp4", 36L, 22L),
      rmd_shortcode("pagebreak", character(), 64L, 17L),
      rmd_shortcode("include", c("script.py", "lines=\"1-10\"", "echo=true"), 112L, 48L),
      rmd_shortcode("kbd", "Ctrl+C", 181L, 18L)
    )
  )
  

  expect_equal(
    parse_shortcodes_cpp("{{< div .class #id data-attr=value >}}"),
    list(rmd_shortcode("div", c(".class", "#id", "data-attr=value"), 0L, 38L))
  )
})
