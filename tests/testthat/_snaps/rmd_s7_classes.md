# rmd_ast S7 class works

    <rmd_ast> object properties are invalid:
    - @nodes must be <list>, not <character>

# rmd_yaml S7 class works

    <rmd_yaml> object properties are invalid:
    - @yaml must be <list>, not <character>

# rmd_heading S7 class works

    <rmd_heading> object is invalid:
    - level must be a single integer between 1 and 6

---

    <rmd_heading> object is invalid:
    - level must be a single integer between 1 and 6

---

    <rmd_heading> object is invalid:
    - name must be a single character string

# rmd_chunk S7 class works

    <rmd_chunk> object is invalid:
    - @engine must be a single character string

---

    <rmd_chunk> object is invalid:
    - @n_ticks must be a single integer >= 3

# rmd_raw_chunk S7 class works

    <rmd_raw_chunk> object is invalid:
    - format must be a single character string

---

    <rmd_raw_chunk> object is invalid:
    - n_ticks must be a single integer >= 3

# rmd_markdown S7 class works

    <rmd_markdown> object is invalid:
    - lines must contain at least one character string

# rmd_code_block S7 class works

    <rmd_code_block> object is invalid:
    - attr must be a single character string

---

    <rmd_code_block> object is invalid:
    - n_ticks must be a single integer

# rmd_fenced_div_open S7 class works

    <rmd_fenced_div_open> object is invalid:
    - id must start with # prefix

---

    <rmd_fenced_div_open> object is invalid:
    - all classes must start with . prefix

---

    <rmd_fenced_div_open> object is invalid:
    - id must be a character vector of length 0 or 1

---

    <rmd_fenced_div_open> object is invalid:
    - attr must be a named character vector when not empty

# rmd_inline_code S7 class works

    <rmd_inline_code> object is invalid:
    - braced must be a single logical value

---

    <rmd_inline_code> object is invalid:
    - engine must be a single character string

# rmd_shortcode S7 class works

    <rmd_shortcode> object is invalid:
    - func must be a single character string

# rmd_span S7 class works

    <rmd_span> object is invalid:
    - text must be a single character string

---

    <rmd_span> object is invalid:
    - id must be a character vector of length 0 or 1

---

    <rmd_span> object is invalid:
    - id must start with '#' when present

---

    <rmd_span> object is invalid:
    - all classes must start with '.' when present

---

    <rmd_span> object is invalid:
    - attr must be a named character vector when not empty

# rmd_ast unbalanced fenced div validation fails

    <rmd_ast> object is invalid:
    - Unbalanced fenced divs: 1 <rmd_fenced_div_open> without matching <rmd_fenced_div_close>

---

    <rmd_ast> object is invalid:
    - Unbalanced fenced divs: 2 <rmd_fenced_div_open>s without matching <rmd_fenced_div_close>s

---

    <rmd_ast> object is invalid:
    - Unbalanced fenced divs: <rmd_fenced_div_close> at [[1]] does not have a matching <rmd_fenced_div_open>

---

    <rmd_ast> object is invalid:
    - Unbalanced fenced divs: <rmd_fenced_div_close> at [[3]] does not have a matching <rmd_fenced_div_open>

---

    <rmd_ast> object is invalid:
    - Unbalanced fenced divs: 1 <rmd_fenced_div_open> without matching <rmd_fenced_div_close>

