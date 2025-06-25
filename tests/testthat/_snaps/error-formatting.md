# Single-line parser errors are formatted correctly

    Failed to parse line 1
    1 | unterminated
        ^~~~~~~~~~~~
    

---

    Failed to parse line 1, expected "="
    1 | ```{r abc.def}
                     ^
    

---

    boost::spirit::x3::expectation_failure

# Error messages with expected information

    Failed to parse line 1, expected R expression
    1 | ```{r x=}
                ^
    

# Multiline expression

    Failed to parse lines 1-5, expected '"'
    1 | :::{.content-visible when-format="HTML}
    2 | ::::{.column-screen}
    3 | Hello
    4 | ::::
    5 | :::
        ~~~^
    

# Line number padding works correctly

    Failed to parse line 10, expected "="
    10 | ```{r invalid.syntax}
                             ^
    

