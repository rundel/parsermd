# code block parsing - Basic

    Code
      check_code_block_parser("````r\n````\n````\n")
    Condition
      Error:
      ! Failed to parse lines 1-3
      1 | ````r
      2 | ````
      3 | ````
          ^~~~

# code block parsing - Indents

    Code
      check_code_block_parser("  ```\n\t```\n")
    Condition
      Error:
      ! Failed to parse line 2, expected code block end (```)
      2 | 	```
          ^~~~

---

    Code
      check_code_block_parser("  ```\n> ```\n")
    Condition
      Error:
      ! Failed to parse line 2, expected code block end (```)
      2 | > ```
          ^~~~~

---

    Code
      check_code_block_parser("  ```\n   ```\n")
    Condition
      Error:
      ! Failed to parse line 2, expected code block end (```)
      2 |    ```
          ^~~~~~

