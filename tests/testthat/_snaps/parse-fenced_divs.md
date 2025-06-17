# Basic parser tests - open

    Code
      check_fdiv_open_parser(":::\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | :::
          ^~~

---

    Code
      check_fdiv_open_parser("::: a x\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ::: a x
          ^~~~~~~

---

    Code
      check_fdiv_open_parser(":: {}\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | :: {}
          ^~~~~

---

    Code
      check_fdiv_open_parser(":: \n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | :: 
          ^~~

# Basic parser tests - close

    Code
      check_fdiv_close_parser("::: a\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ::: a
          ^~~~~

---

    Code
      check_fdiv_close_parser("::: {a}\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ::: {a}
          ^~~~~~~

---

    Code
      check_fdiv_close_parser("::: {}\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ::: {}
          ^~~~~~

---

    Code
      check_fdiv_close_parser(":: a\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | :: a
          ^~~~

# Bad fdivs

    Code
      parse_rmd("::: test1\n")
    Condition
      Error:
      ! Failed to parse line 1, expected to find closing div fence (:::), end of document reached.
      1 | ::: test1
          ~~~~~~~~~^

---

    Code
      parse_rmd(":::\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | :::
          ^~~

---

    Code
      parse_rmd("::: test1\n::: test2\n:::\n")
    Condition
      Error:
      ! Failed to parse line 1, expected to find closing div fence (:::), end of document reached.
      1 | ::: test1
          ~~~~~~~~~^

---

    Code
      parse_rmd("::: test1\n:::\n:::\n")
    Condition
      Error:
      ! Failed to parse lines 1-3
      1 | ::: test1
      2 | :::
      3 | :::
          ^~~

# Enhanced attribute parsing - error cases

    Code
      check_fdiv_open_parser("::: {.}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected "}"
      1 | ::: {.}
               ^~

---

    Code
      check_fdiv_open_parser("::: {#}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected "}"
      1 | ::: {#}
               ^~

---

    Code
      check_fdiv_open_parser("::: {.class\n")
    Condition
      Error:
      ! Failed to parse line 1, expected "}"
      1 | ::: {.class
                     ^

