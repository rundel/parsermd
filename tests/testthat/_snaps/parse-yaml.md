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
      ! Failed to parse line 2, expected YAML closing fence
      --
        ^

---

    Code
      check_yaml_parser("----\n---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML opening fence to be followed by a non-empty line
      ----
         ^

---

    Code
      check_yaml_parser("---\n----\n")
    Condition
      Error:
      ! Failed to parse line 2, expected YAML closing fence
      ----
          ^

---

    Code
      check_yaml_parser("---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML closing fence
      ---
         ^

# yaml parsing - blank lines

    Code
      parse("---\n\n---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML opening fence to be followed by a non-empty line
      ---
         ^

---

    Code
      parse("---\n\nvalue: 1\n---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML opening fence to be followed by a non-empty line
      ---
         ^

# Pandoc - yaml metadata block

    Code
      parse("---\n\n...\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML opening fence to be followed by a non-empty line
      ---
         ^

---

    Code
      parse_rmd("---\n\n---\n---\n...\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML opening fence to be followed by a non-empty line
      ---
         ^

---

    Code
      parse_rmd("---\n---\n---\n\n...\n")
    Condition
      Error:
      ! Failed to parse line 3, expected YAML opening fence to be followed by a non-empty line
      ---
         ^

