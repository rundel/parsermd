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
      ! Failed to parse lines 3-2, expected YAML closing fence

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
      ! Failed to parse lines 3-2, expected YAML closing fence

---

    Code
      check_yaml_parser("---\n")
    Condition
      Error:
      ! Failed to parse lines 2-1, expected YAML closing fence

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

