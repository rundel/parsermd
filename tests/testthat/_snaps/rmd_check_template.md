# check output - with content

    Code
      rmd_check_template(ast, template)
    Message
      x The following document elements were unmodified from the template:
        * Section "Exercise 1" > "Answer" has "markdown text" which has not been
          modified.
        * Section "Exercise 2" > "Answer" has "markdown text" which has not been
          modified.
        * Section "Exercise 2" > "Answer" has a "code chunk" named "ex2-plot" which
          has not been modified.
        * Section "Exercise 2" > "Answer" has "markdown text" which has not been
          modified.
        * Section "Exercise 2" > "Answer" has a "code chunk" named "cor-dino" which
          has not been modified.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 1" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "ex2-plot".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "cor-dino".

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "ex2-plot".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "cor-dino".
    Output
      
    Message
      x The following document elements were unmodified from the template:
        * Section "Exercise 1" > "Answer" has "markdown text" which has not been
          modified.

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 1" > "Answer" is missing required "markdown text".
    Output
      
    Message
      x The following document elements were unmodified from the template:
        * Section "Exercise 2" > "Answer" has "markdown text" which has not been
          modified.
        * Section "Exercise 2" > "Answer" has a "code chunk" named "ex2-plot" which
          has not been modified.
        * Section "Exercise 2" > "Answer" has "markdown text" which has not been
          modified.
        * Section "Exercise 2" > "Answer" has a "code chunk" named "cor-dino" which
          has not been modified.

# check output - without content

    Code
      rmd_check_template(ast, template)
    Message
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 1" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "ex2-plot".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "cor-dino".

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "ex2-plot".
        * Section "Exercise 2" > "Answer" is missing required "markdown text".
        * Section "Exercise 2" > "Answer" is missing a required "code chunk" named
          "cor-dino".

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message
      x The following required elements were missing in the document:
        * Section "Exercise 1" > "Answer" is missing required "markdown text".

