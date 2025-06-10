# echo

    Code
      rmd_source(ast, local = TRUE, echo = TRUE)
    Output
      > ## ---- Chunk 1 ------------------------------
      > 
      > x = 1
      > ## ---- Chunk 2 ------------------------------
      > 
      > y = 2

---

    Code
      rmd_source(ast, local = TRUE, echo = TRUE, label_comment = FALSE)
    Output
      > x = 1
      > y = 2

