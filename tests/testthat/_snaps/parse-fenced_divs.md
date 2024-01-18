# Basic parser tests

    Code
      check_fenced_div_parser(":::\n:::\n")
    Condition
      Error:
      ! Failed to parse line 1
      :::
      ^~~

---

    Code
      check_fenced_div_parser("::: a x\n:::\n")
    Condition
      Error:
      ! Failed to parse line 1
      ::: a x
      ^~~~~~~

---

    Code
      check_fenced_div_parser(":: {}\n:::\n")
    Condition
      Error:
      ! Failed to parse line 1
      :: {}
      ^~~~~

---

    Code
      check_fenced_div_parser("::: {}\n::\n")
    Condition
      Error:
      ! Failed to parse line 1
      ::: {}
      ^~~~~~

---

    Code
      check_fenced_div_parser("::: test1\n::: test2\n:::\n")
    Condition
      Error:
      ! Failed to parse line 1
      ::: test1
      ^~~~~~~~~

