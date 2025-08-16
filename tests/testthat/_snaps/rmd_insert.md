# rmd_insert errors on discontinuous ranges by default

    Selected indices are discontinuous: [1, 3]. Found 2 separate ranges: 1, 3. Either modify your selection to be continuous or use `allow_multiple = TRUE` to insert at multiple locations.

# rmd_insert validates nodes argument

    `nodes` must be an <rmd_node> object, a list of <rmd_node> objects, or an <rmd_ast> object

---

    All nodes must inherit from <rmd_node>. Item 2 has class <character>

# rmd_insert validates location argument

    'arg' should be one of "before", "after"

# rmd_insert validates allow_multiple argument

    Assertion on 'allow_multiple' failed: Must be of type 'logical', not 'character'.

# rmd_insert handles unsupported types

    This function does not support class: character

---

    This function does not support class: list

# normalize_nodes helper function works

    `nodes` must be an <rmd_node> object, a list of <rmd_node> objects, or an <rmd_ast> object

---

    All nodes must inherit from <rmd_node>. Item 2 has class <character>

