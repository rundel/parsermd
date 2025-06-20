# yaml parsing - bad yaml

    Code
      check_yaml_parser("--\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | --
          ^~

---

    Code
      check_yaml_parser("---\n--\n")
    Condition
      Error:
      ! Failed to parse line 2, expected YAML closing fence
      2 | --
            ^

---

    Code
      check_yaml_parser("----\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ----
          ^~~~

---

    Code
      check_yaml_parser("---\n----\n")
    Condition
      Error:
      ! Failed to parse line 2, expected YAML closing fence
      2 | ----
              ^

---

    Code
      check_yaml_parser("---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAML closing fence
      1 | ---
             ^

# yaml parsing - blank lines

    Code
      parse("---\n\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ---
          ^~~

---

    Code
      parse("---\n\nvalue: 1\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ---
          ^~~

