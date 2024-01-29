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
      ! Failed to parse line 2, expected YAMLs closing fence 
      --
        ^

---

    Code
      check_yaml_parser("----\n---\n")
    Condition
      Error:
      ! Failed to parse line 1
      ----
      ^~~~

---

    Code
      check_yaml_parser("---\n----\n")
    Condition
      Error:
      ! Failed to parse line 2, expected YAMLs closing fence 
      ----
      ^~~~

---

    Code
      check_yaml_parser("---\n")
    Condition
      Error:
      ! Failed to parse line 1, expected YAMLs closing fence 
      ---
         ^

