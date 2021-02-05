# check output - with content

    Code
      rmd_check_template(ast, template)
    Message <cliMessage>
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message <cliMessage>
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * YAML cannot be located.

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * YAML cannot be located.

# check output - without content

    Code
      rmd_check_template(ast, template)
    Message <cliMessage>
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message <cliMessage>
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * YAML cannot be located.

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * YAML cannot be located.

