# rmd_node_validate.rmd_ast works

    rmd_ast validation failed:
    x Must be of type 'list', not 'rmd_ast'

---

    rmd_ast validation failed:
    x Element 1: Function must return a valid rmd node object. x Got object of class: invalid_node. x Valid rmd node classes are: rmd_ast, rmd_yaml, rmd_heading, rmd_chunk, rmd_raw_chunk, rmd_markdown, rmd_code_block, rmd_fenced_div_open, rmd_fenced_div_close, rmd_inline_code, rmd_shortcode.

---

    rmd_ast validation failed:
    x Element 1: rmd_heading validation failed: x Field level - Element 1 is not <= 6

# rmd_node_validate.rmd_yaml works

    Function must return a valid rmd node object.
    x Got object of class: character.
    x Valid rmd node classes are: rmd_ast, rmd_yaml, rmd_heading, rmd_chunk, rmd_raw_chunk, rmd_markdown, rmd_code_block, rmd_fenced_div_open, rmd_fenced_div_close, rmd_inline_code, rmd_shortcode.

# rmd_node_validate.rmd_heading works

    rmd_heading validation failed:
    x Field level - Element 1 is not <= 6

---

    rmd_heading validation failed:
    x Object is missing required field: level

# rmd_node_validate.rmd_chunk works

    rmd_chunk validation failed:
    x Field engine - Must be of type 'string', not 'double'

---

    rmd_chunk validation failed:
    x Object is missing required fields: options, yaml_options, code, indent, and n_ticks

# rmd_node_validate.rmd_raw_chunk works

    rmd_raw_chunk validation failed:
    x Field format - Must be of type 'string', not 'double'

---

    rmd_raw_chunk validation failed:
    x Object is missing required fields: code, indent, and n_ticks

# rmd_node_validate.rmd_markdown works

    rmd_markdown validation failed:
    x Field lines - Must be of type 'character', not 'double'

---

    rmd_markdown validation failed:
    x Object is missing required field: lines

# rmd_node_validate.rmd_code_block works

    rmd_code_block validation failed:
    x Field attr - Must be of type 'string', not 'double'

---

    rmd_code_block validation failed:
    x Object is missing required fields: code and indent

# rmd_node_validate.rmd_fenced_div_open works

    rmd_fenced_div_open validation failed:
    x Field attr - Must be of type 'character', not 'double'

---

    rmd_fenced_div_open validation failed:
    x Object is missing required field: attr

# rmd_node_validate.rmd_fenced_div_close works

    rmd_fenced_div_close validation failed:
    x Must be of type 'list', not 'rmd_fenced_div_close'

# rmd_node_validate.rmd_inline_code works

    rmd_inline_code validation failed:
    x Field braced - Must be of type 'logical', not 'character'

---

    rmd_inline_code validation failed:
    x Object is missing required field: braced

# rmd_node_validate.rmd_shortcode works

    rmd_shortcode validation failed:
    x Field func - Must be of type 'string', not 'double'

---

    rmd_shortcode validation failed:
    x Object is missing required field: args

# rmd_node_validate.default works

    Function must return a valid rmd node object.
    x Got object of class: unknown_class.
    x Valid rmd node classes are: rmd_ast, rmd_yaml, rmd_heading, rmd_chunk, rmd_raw_chunk, rmd_markdown, rmd_code_block, rmd_fenced_div_open, rmd_fenced_div_close, rmd_inline_code, rmd_shortcode.

