# chunk parsing - bad chunks

    Failed to parse line 1, expected chunk engine
    ```{}
        ^
    

---

    Failed to parse line 1, expected '}'
    ```{r
    ~~~~~^
    

---

    Failed to parse line 1
    ```r}
    ^~~~~
    

---

    Failed to parse line 2
    ``
    ~~^
    

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
    

