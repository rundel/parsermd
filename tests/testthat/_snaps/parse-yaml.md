# yaml parsing - bad yaml

    Code
      check_yaml_parser("--\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      --
      ^~

---

    Code
      check_yaml_parser("---\n--\n")
    Condition
      Error:
      ! Failed to parse line 2, expected eol
      --
        ^

---

    Code
      check_yaml_parser("----\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      ----
         ^

---

    Code
      check_yaml_parser("---\n----\n")
    Condition
      Error:
      ! Failed to parse line 2, expected eol
      ----
         ^

---

    Code
      check_yaml_parser("---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected eol
      ---
         ^

