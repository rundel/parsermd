# tree printing with fenced divs

    +-- YAML [2 fields]
    +-- Heading [h3] - Load packages
    |   +-- Chunk [r, 2 lines] - load-packages
    |   +-- Fenced div (open) [#note-callout, .callout-warning]
    |   |   \-- Heading [h3] - Exercise 1
    |   |       +-- Markdown [1 line]
    |   |       \-- Heading [h4] - Solution
    |   |           \-- Markdown [1 line]
    |   \-- Fenced div (close) 
    +-- Heading [h3] - Exercise 2
    |   +-- Markdown [1 line]
    |   \-- Heading [h4] - Solution
    |       +-- Markdown [3 lines]
    |       +-- Chunk [r, 5 lines] - plot-dino
    |       +-- Markdown [1 line]
    |       \-- Chunk [r, 2 lines] - cor-dino
    \-- Heading [h3] - Exercise 3
        +-- Markdown [1 line]
        \-- Heading [h4] - Solution
            +-- Markdown [3 lines]
            +-- Chunk [r, 1 line] - plot-star
            +-- Markdown [1 line]
            \-- Chunk [r, 1 line] - cor-star

---

    +-- YAML [2 fields]
    \-- Heading [h3] - Load packages
        +-- Fenced div (open) [#note-callout, .callout-warning]
        |   \-- Heading [h3] - Exercise 1
        |       +-- Markdown [1 line]
        |       \-- Heading [h4] - Solution
        |           \-- Markdown [1 line]
        \-- Fenced div (close) 

---

    +-- YAML [2 fields]
    +-- Heading [h3] - Load packages
    |   \-- Chunk [r, 2 lines] - load-packages
    +-- Heading [h3] - Exercise 1
    |   +-- Markdown [1 line]
    |   +-- Fenced div (open) [#note-callout, .callout-warning]
    |   |   \-- Heading [h4] - Solution
    |   |       \-- Markdown [1 line]
    |   \-- Fenced div (close) 
    +-- Heading [h3] - Exercise 2
    |   +-- Markdown [1 line]
    |   \-- Heading [h4] - Solution
    |       +-- Markdown [3 lines]
    |       +-- Chunk [r, 5 lines] - plot-dino
    |       +-- Markdown [1 line]
    |       \-- Chunk [r, 2 lines] - cor-dino
    \-- Heading [h3] - Exercise 3
        +-- Markdown [1 line]
        \-- Heading [h4] - Solution
            +-- Markdown [3 lines]
            +-- Chunk [r, 1 line] - plot-star
            +-- Markdown [1 line]
            \-- Chunk [r, 1 line] - cor-star

---

    +-- YAML [2 fields]
    \-- Heading [h3] - Exercise 1
        +-- Fenced div (open) [#note-callout, .callout-warning]
        |   \-- Heading [h4] - Solution
        |       \-- Markdown [1 line]
        \-- Fenced div (close) 

---

    +-- Heading [h3] - Section 1
    |   +-- Fenced div (open) [.callout-note]
    |   |   \-- Heading [h2] - Test
    |   |       \-- Markdown [1 line]
    |   \-- Fenced div (close) 
    +-- Heading [h3] - Section 2
    |   \-- Markdown [2 lines]
    \-- Heading [h2] - Section 3
        +-- Markdown [3 lines]
        \-- Heading [h3] - Sub Section 1
            \-- Markdown [2 lines]

