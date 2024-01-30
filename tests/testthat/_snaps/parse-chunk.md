# chunk parsing - bad chunks

    Failed to parse line 1
    ```{}
    ^~~~~
    

---

    Failed to parse line 1
    ```{r
    ^~~~~
    

---

    Failed to parse line 1
    ```r}
    ^~~~~
    

---

    Failed to parse line 1
    ```{r}
    ^~~~~~
    

---

    Failed to parse line 1, expected "="
    ```{r m, m}
              ^
    

---

    Failed to parse line 1, expected "="
    ```{r abc.def}
                 ^
    

---

    Failed to parse line 1, expected ','
    ```{r m x=1}
            ^~~~
    

---

    Failed to parse line 1, expected R expression
    ```{r x=}
            ^
    

---

    Failed to parse line 1, expected R expression
    ```{r x=, y=1}
            ^~~~~~
    

---

    Failed to parse line 1, expected R expression
    ```{r x=1, y=}
                 ^
    

# chunk parsing - raw attribute chunk

    Code
      parse("```{=}\n```\n")
    Condition
      Error:
      ! Failed to parse line 1
      ```{=}
      ^~~~~~

---

    Code
      parse("```{==}\n```\n")
    Condition
      Error:
      ! Failed to parse line 1
      ```{==}
      ^~~~~~~

---

    Code
      parse("```{=a=}\n```\n")
    Condition
      Error:
      ! Failed to parse line 1
      ```{=a=}
      ^~~~~~~~

---

    Code
      parse("```{a=}\n```\n")
    Condition
      Error:
      ! Failed to parse line 1
      ```{a=}
      ^~~~~~~

# chunk parsing - more than 3 ticks

    Code
      parse("````{r}\n```")
    Condition
      Error:
      ! Failed to parse line 1
      ````{r}
      ^~~~~~~

---

    Code
      parse("```{r}\n````")
    Condition
      Error:
      ! Failed to parse line 1
      ```{r}
      ^~~~~~

---

    Code
      parse("````{r}\n`````")
    Condition
      Error:
      ! Failed to parse line 1
      ````{r}
      ^~~~~~~

---

    Code
      parse("`````{r}\n````")
    Condition
      Error:
      ! Failed to parse line 1
      `````{r}
      ^~~~~~~~

