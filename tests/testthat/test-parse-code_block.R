

test_that("code block parsing - Basic", {
  expect_equal(
    check_code_block_parser("```\n```\n"),
    rmd_code_block()
  )

  expect_equal(
    check_code_block_parser("```r\n```\n"),
    rmd_code_block(classes = ".r")
  )

  expect_equal(
    check_code_block_parser("``` r\n```\n"),
    rmd_code_block(classes = ".r")
  )

  # Multi-word unbraced attributes are not valid - these should fail to parse
  expect_error(
    check_code_block_parser("```abc def\n```\n")
  )

  expect_error(
    check_code_block_parser("``` abc def\n```\n")
  )


  expect_equal(
    check_code_block_parser("````\n````\n"),
    rmd_code_block(n_ticks = 4L)
  )

  expect_equal(
    check_code_block_parser("````r\n````\n"),
    rmd_code_block(classes=".r", n_ticks=4L)
  )

  expect_equal(
    check_code_block_parser("````r\n```\n````\n"),
    rmd_code_block(classes=".r", n_ticks=4L, code="```")
  )

  expect_equal(
    check_code_block_parser("````r\n```\n```\n````\n"),
    rmd_code_block(classes=".r", n_ticks=4L, code=c("```", "```"))
  )

  expect_snapshot(
    check_code_block_parser("````r\n````\n````\n"),
    error=TRUE
  )
})

test_that("code block parsing - Indents", {
  expect_equal(
    check_code_block_parser("  ```\n  ```\n"),
    rmd_code_block(indent="  ")
  )

  expect_equal(
    check_code_block_parser("\t```\n\t```\n"),
    rmd_code_block(indent="\t")
  )

  expect_equal(
    check_code_block_parser("> ```\n> ```\n"),
    rmd_code_block(indent="> ")
  )

  expect_snapshot(
    check_code_block_parser("  ```\n\t```\n"),
    error=TRUE
  )

  expect_snapshot(
    check_code_block_parser("  ```\n> ```\n"),
    error=TRUE
  )

  expect_snapshot(
    check_code_block_parser("  ```\n   ```\n"),
    error=TRUE
  )

  # With code

  expect_equal(
    check_code_block_parser("  ```\n  1+1\n  ```\n"),
    rmd_code_block(indent="  ", code="1+1")
  )

  expect_equal(
    check_code_block_parser("\t```\n\t1+1\n\t```\n"),
    rmd_code_block(indent="\t", code="1+1")
  )

  expect_equal(
    check_code_block_parser("> ```\n> 1+1\n> ```\n"),
    rmd_code_block(indent="> ", code="1+1")
  )

  ## Handling of blank lines within indented blocks
  expect_equal(
    check_code_block_parser("  ```\n  1+1\n  \n  2+2\n  ```\n"),
    check_code_block_parser("  ```\n  1+1\n\n  2+2\n  ```\n")
  )

  expect_equal(
    check_code_block_parser("  ```\n  1+1\n\n  2+2\n  ```\n"),
    rmd_code_block(indent="  ", code=c("1+1","","2+2"))
  )
})

test_that("code block parsing - Pandoc Attributes", {
  # === Unbraced class tests ===
  expect_equal(
    check_code_block_parser("```python\n```\n"),
    rmd_code_block(classes = ".python")
  )
  
  expect_equal(
    check_code_block_parser("```my-lang_v2\n```\n"),
    rmd_code_block(classes = ".my-lang_v2")
  )
  
  expect_equal(
    check_code_block_parser("```CSS\n```\n"),
    rmd_code_block(classes = ".CSS")
  )
  
  # === Braced attributes - ID only ===
  expect_equal(
    check_code_block_parser("``` {#mycode}\n```\n"),
    rmd_code_block(id = "#mycode")
  )
  
  # === Braced attributes - Classes only ===  
  expect_equal(
    check_code_block_parser("``` {.python}\n```\n"),
    rmd_code_block(classes = ".python")
  )
  
  expect_equal(
    check_code_block_parser("``` {.python .numberLines}\n```\n"),
    rmd_code_block(classes = c(".python", ".numberLines"))
  )
  
  expect_equal(
    check_code_block_parser("``` {.python .numberLines .highlight}\n```\n"),
    rmd_code_block(classes = c(".python", ".numberLines", ".highlight"))
  )
  
  # === Braced attributes - Key-value pairs only ===
  expect_equal(
    check_code_block_parser("``` {startFrom=\"10\"}\n```\n"),
    rmd_code_block(attr = c(startFrom = "\"10\""))
  )
  
  expect_equal(
    check_code_block_parser("``` {startFrom=10}\n```\n"),
    rmd_code_block(attr = c(startFrom = "10"))
  )
  
  expect_equal(
    check_code_block_parser("``` {lineNumbers=true theme=dark}\n```\n"),
    rmd_code_block(attr = c(lineNumbers = "true", theme = "dark"))
  )
  
  # === Braced attributes - ID + Classes ===
  expect_equal(
    check_code_block_parser("``` {#mycode .python}\n```\n"),
    rmd_code_block(id = "#mycode", classes = ".python")
  )
  
  expect_equal(
    check_code_block_parser("``` {#snippet .python .numberLines}\n```\n"),
    rmd_code_block(id = "#snippet", classes = c(".python", ".numberLines"))
  )
  
  # === Braced attributes - ID + Key-value ===
  expect_equal(
    check_code_block_parser("``` {#mycode startFrom=\"5\"}\n```\n"),
    rmd_code_block(id = "#mycode", attr = c(startFrom = "\"5\""))
  )
  
  # === Braced attributes - Classes + Key-value ===
  expect_equal(
    check_code_block_parser("``` {.python startFrom=\"10\"}\n```\n"),
    rmd_code_block(classes = ".python", attr = c(startFrom = "\"10\""))
  )
  
  expect_equal(
    check_code_block_parser("``` {.python .numberLines startFrom=\"10\" theme=dark}\n```\n"),
    rmd_code_block(
      classes = c(".python", ".numberLines"), 
      attr = c(startFrom = "\"10\"", theme = "dark")
    )
  )
  
  # === Braced attributes - Full combination ===
  expect_equal(
    check_code_block_parser("``` {#mycode .python .numberLines startFrom=\"10\"}\n```\n"),
    rmd_code_block(
      id = "#mycode",
      classes = c(".python", ".numberLines"),
      attr = c(startFrom = "\"10\"")
    )
  )
  
  expect_equal(
    check_code_block_parser("``` {#snippet .haskell .numberLines .highlight startFrom=\"5\" theme=dark lineNumbers=true}\n```\n"),
    rmd_code_block(
      id = "#snippet",
      classes = c(".haskell", ".numberLines", ".highlight"),
      attr = c(startFrom = "\"5\"", theme = "dark", lineNumbers = "true")
    )
  )
})

test_that("code block parsing - Combined Unbraced + Braced", {
  # === Unbraced + ID ===
  expect_equal(
    check_code_block_parser("```python {#mycode}\n```\n"),
    rmd_code_block(id = "#mycode", classes = ".python")
  )
  
  # === Unbraced + Classes ===
  expect_equal(
    check_code_block_parser("```haskell {.numberLines}\n```\n"),
    rmd_code_block(classes = c(".haskell", ".numberLines"))
  )
  
  expect_equal(
    check_code_block_parser("```javascript {.numberLines .highlight}\n```\n"),
    rmd_code_block(classes = c(".javascript", ".numberLines", ".highlight"))
  )
  
  # === Unbraced + Key-value ===
  expect_equal(
    check_code_block_parser("```python {startFrom=\"10\"}\n```\n"),
    rmd_code_block(classes = ".python", attr = c(startFrom = "\"10\""))
  )
  
  # === Unbraced + Full braced ===
  expect_equal(
    check_code_block_parser("```haskell {#mycode .numberLines startFrom=\"10\"}\n```\n"),
    rmd_code_block(
      id = "#mycode",
      classes = c(".haskell", ".numberLines"),
      attr = c(startFrom = "\"10\"")
    )
  )
  
  expect_equal(
    check_code_block_parser("```cpp {#example .cpp .numberLines .highlight startFrom=\"1\" theme=monokai showLines=true}\n```\n"),
    rmd_code_block(
      id = "#example",
      classes = c(".cpp", ".cpp", ".numberLines", ".highlight"),
      attr = c(startFrom = "\"1\"", theme = "monokai", showLines = "true")
    )
  )
})

test_that("code block parsing - Edge Cases and Errors", {
  # === Valid CSS class names ===
  expect_equal(
    check_code_block_parser("```a\n```\n"),
    rmd_code_block(classes = ".a")
  )
  
  expect_equal(
    check_code_block_parser("```A1\n```\n"),
    rmd_code_block(classes = ".A1")
  )
  
  expect_equal(
    check_code_block_parser("```lang-2023_v1\n```\n"),
    rmd_code_block(classes = ".lang-2023_v1")
  )
  
  # === Invalid unbraced classes (should fail) ===
  expect_error(
    check_code_block_parser("```abc def\n```\n")
  )
  
  
  expect_error(
    check_code_block_parser("```python code\n```\n")  # Spaces not allowed
  )
  
  expect_error(
    check_code_block_parser("```city=\"Corvallis\"\n```\n")  # Not valid CSS class
  )
  
  # Unbraced class starting with dot is now allowed
  expect_equal(
    check_code_block_parser("```.yaml\n```\n"),
    rmd_code_block(classes = ".yaml")
  )
  
  expect_equal(
    check_code_block_parser("``` .python\n```\n"),
    rmd_code_block(classes = ".python")
  )
  
  # Both dotted and non-dotted unbraced classes should result in same internal representation
  expect_equal(
    check_code_block_parser("```yaml\n```\n"),
    check_code_block_parser("```.yaml\n```\n")
  )
  
  # Invalid unbraced classes that should still fail with good error messages
  expect_error(
    check_code_block_parser("```1invalid\n```\n")  # starts with number
  )
  
  expect_error(
    check_code_block_parser("```--invalid\n```\n")  # starts with --
  )
  
  expect_error(
    check_code_block_parser("```_invalid\n```\n")  # starts with underscore
  )
  
  expect_error(
    check_code_block_parser("```-invalid\n```\n")  # starts with single hyphen
  )
  
  # === Empty braces ===
  expect_equal(
    check_code_block_parser("``` {}\n```\n"),
    rmd_code_block()
  )
  
  # === Whitespace handling ===
  expect_equal(
    check_code_block_parser("```python {#test .numberLines}\n```\n"),
    rmd_code_block(id = "#test", classes = c(".python", ".numberLines"))
  )
})

test_that("code block parsing - Round-trip", {
  test_roundtrip <- function(input) {
    parsed <- check_code_block_parser(input)
    reconstructed <- as_document(parsed)
    # Parse the reconstructed version
    reparsed <- check_code_block_parser(paste(c(reconstructed, ""), collapse = "\n"))
    expect_equal(parsed, reparsed, info = paste("Failed roundtrip for:", input))
  }
  
  # Basic cases
  test_roundtrip("```python\n```\n")
  test_roundtrip("``` {.python}\n```\n")
  test_roundtrip("``` {#test}\n```\n")
  test_roundtrip("``` {startFrom=\"10\"}\n```\n")
  
  # Combined cases  
  test_roundtrip("```haskell {.numberLines}\n```\n")
  test_roundtrip("```python {#test .numberLines startFrom=\"5\"}\n```\n")
  
  # Complex cases
  test_roundtrip("``` {#complex .lang1 .lang2 .feature1 attr1=\"val1\" attr2=val2}\n```\n")
})
