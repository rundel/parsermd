# check output - with content

    Code
      rmd_check_template(ast, template)
    Message <cliMessage>
      x The following document elements were unmodified from the template:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" has markdown text which has not been
          modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has markdown text which has not been
          modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has a code chunk named 'ex2-plot' which
          has not been modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has markdown text which has not been
          modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has a code chunk named 'cor-dino' which
          has not been modified.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'ex2-plot'.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'cor-dino'.

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'ex2-plot'.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'cor-dino'.
    Output
      
    Message <cliMessage>
      x The following document elements were unmodified from the template:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" has markdown text which has not been
          modified.

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" is missing required markdown text.
    Output
      
    Message <cliMessage>
      x The following document elements were unmodified from the template:
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has markdown text which has not been
          modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has a code chunk named 'ex2-plot' which
          has not been modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has markdown text which has not been
          modified.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" has a code chunk named 'cor-dino' which
          has not been modified.

# check output - without content

    Code
      rmd_check_template(ast, template)
    Message <cliMessage>
      v Rmd document matches the provided template.

---

    Code
      rmd_check_template(as_tibble(ast)[1, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'ex2-plot'.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'cor-dino'.

---

    Code
      rmd_check_template(as_tibble(ast)[9:10, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'ex2-plot'.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing required markdown text.
    Message <cliMessage>
        * Section "Exercise 2" > "Answer" is missing a required code chunk named
          'cor-dino'.

---

    Code
      rmd_check_template(as_tibble(ast)[15:19, ], template)
    Message <cliMessage>
      x The following required elements were missing in the document:
    Message <cliMessage>
        * Section "Exercise 1" > "Answer" is missing required markdown text.

