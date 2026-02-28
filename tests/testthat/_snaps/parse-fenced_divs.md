# Basic parser tests - open

    Code
      check_fdiv_open_parser(":::\n")
    Condition
      Error:
      ! Failed to parse line 1, expected div attribute (unbraced name or {attrs})
      1 | :::
             ^

---

    Code
      check_fdiv_open_parser("::: a x\n")
    Condition
      Error:
      ! Failed to parse line 1, expected end of line after div attribute
      1 | ::: a x
                ^

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
      ! Failed to parse line 1, expected div attribute (unbraced name or {attrs})
      1 | :::
             ^

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
      ! Failed to parse line 3, expected div attribute (unbraced name or {attrs})
      3 | :::
             ^

# Enhanced attribute parsing - error cases

    Code
      check_fdiv_open_parser("::: {.}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected class name after '.'
      1 | ::: {.}
               ~^

---

    Code
      check_fdiv_open_parser("::: {#}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected id name after '#'
      1 | ::: {#}
               ~^

---

    Code
      check_fdiv_open_parser("::: {key=}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected value after '=' in key=value attribute
      1 | ::: {key=}
                   ^

---

    Code
      check_fdiv_open_parser("::: {.class\n")
    Condition
      Error:
      ! Failed to parse line 1
      1 | ::: {.class
                     ^

---

    Code
      check_fdiv_open_parser("::: {.myclass #myid}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {.myclass #myid}
                        ^~~~~~

---

    Code
      check_fdiv_open_parser("::: {.my-class_name #my-id_value}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {.my-class_name #my-id_value}
                              ^~~~~~~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {.class1 #id2 data-level=3}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {.class1 #id2 data-level=3}
                       ^~~~~~~~~~~~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {data-value=test .highlight}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected .class attributes to appear before any key=value attributes
      1 | ::: {data-value=test .highlight}
                               ^~~~~~~~~~~

---

    Code
      check_fdiv_open_parser(
        "::: {title=\"Main Section\" data-id=section1 .highlighted}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected .class attributes to appear before any key=value attributes
      1 | ::: {title="Main Section" data-id=section1 .highlighted}
                                                     ^~~~~~~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {data-role=button #submit}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {data-role=button #submit}
                                ^~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {warning}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id, .class, or key=value attribute(s)
      1 | ::: {warning}
               ^~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {test}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id, .class, or key=value attribute(s)
      1 | ::: {test}
               ^~~~~

---

    Code
      check_fdiv_open_parser("::: {#id1 #id2}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {#id1 #id2}
                    ^~~~~

---

    Code
      check_fdiv_open_parser("::: {.col width='50%' .fragment}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected .class attributes to appear before any key=value attributes
      1 | ::: {.col width='50%' .fragment}
                                ^~~~~~~~~~

---

    Code
      check_fdiv_open_parser("::: {.col width='50%' #myid}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {.col width='50%' #myid}
                                ^~~~~~

---

    Code
      check_fdiv_open_parser("::: {#id1 key=val #id2}\n")
    Condition
      Error:
      ! Failed to parse line 1, expected #id attributes to appear before any .class or key=value attributes
      1 | ::: {#id1 key=val #id2}
                            ^~~~~

