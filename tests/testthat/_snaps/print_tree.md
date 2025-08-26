# tree printing

    +-- YAML [4 fields]
    +-- Heading [h1] - Setup
    |   \-- Chunk [r, 1 line] - setup
    \-- Heading [h1] - Content
        +-- Heading [h2] - R Markdown
        |   +-- Markdown [5 lines]
        |   +-- Chunk [r, 1 line] - cars
        |   \-- Chunk [r, 1 line] - unnamed-chunk-1
        \-- Heading [h2] - Including Plots
            +-- Markdown [1 line]
            +-- Chunk [r, 1 line] - pressure
            \-- Markdown [2 lines]

---

    +-- YAML [2 fields]
    +-- Heading [h3] - Load packages
    |   \-- Chunk [r, 2 lines] - load-packages
    +-- Heading [h3] - Exercise 1
    |   +-- Markdown [1 line]
    |   \-- Heading [h4] - Solution
    |       \-- Markdown [4 lines]
    +-- Heading [h3] - Exercise 2
    |   +-- Markdown [1 line]
    |   \-- Heading [h4] - Solution
    |       +-- Markdown [1 line]
    |       +-- Chunk [r, 5 lines] - plot-dino
    |       +-- Markdown [1 line]
    |       \-- Chunk [r, 2 lines] - cor-dino
    \-- Heading [h3] - Exercise 3
        +-- Markdown [1 line]
        \-- Heading [h4] - Solution
            +-- Chunk [r, 5 lines] - plot-star
            \-- Chunk [r, 2 lines] - cor-star

---

    +-- YAML [2 fields]
    +-- Heading [h3] - Load packages
    |   \-- Chunk [r, 2 lines] - load-packages
    +-- Heading [h3] - Exercise 1
    |   +-- Markdown [1 line]
    |   \-- Heading [h4] - Solution
    |       \-- Markdown [1 line]
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
    +-- Heading [h3] - H3
    +-- Heading [h2] - H2
    |   \-- Heading [h3] - H3 - Part 2
    \-- Heading [h1] - H1

---

    +-- YAML [1 field]
    +-- Heading [h2] - R Markdown
    |   +-- Markdown [3 lines]
    |   \-- Chunk [r, 1 line] - cars
    \-- Heading [h2] - Pandoc Raw Attribute Chunk
        +-- Markdown [1 line]
        \-- Raw Attr Chunk [html, 5 lines]

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

# tree printing with various fenced div structures

    +-- YAML [0 fields]
    \-- Heading [h1] - Main Heading
        +-- Fenced div (open) [.callout-warning]
        |   \-- Heading [h2] - Warning Inside
        |       \-- Markdown [1 line]
        +-- Fenced div (close) 
        \-- Heading [h2] - Outside Heading
            \-- Markdown [1 line]

---

    +-- YAML [0 fields]
    +-- Heading [h1] - Document Title
    |   +-- Fenced div (open) [.outer-div]
    |   |   \-- Heading [h2] - Outer Content
    |   |       +-- Fenced div (open) [.inner-div]
    |   |       |   \-- Heading [h3] - Inner Heading
    |   |       |       \-- Markdown [1 line]
    |   |       +-- Fenced div (close) 
    |   |       \-- Markdown [1 line]
    |   \-- Fenced div (close) 
    \-- Heading [h1] - After Nesting
        \-- Markdown [1 line]

---

    +-- YAML [0 fields]
    \-- Heading [h1] - Chapter 1
        +-- Fenced div (open) [.note]
        |   \-- Markdown [1 line]
        +-- Fenced div (close) 
        +-- Heading [h2] - Section A
        |   +-- Fenced div (open) [.warning]
        |   |   \-- Heading [h3] - Warning Header
        |   |       \-- Markdown [1 line]
        |   +-- Fenced div (close) 
        |   +-- Fenced div (open) [.tip]
        |   |   \-- Markdown [1 line]
        |   \-- Fenced div (close) 
        \-- Heading [h2] - Section B
            \-- Markdown [1 line]

---

    +-- YAML [0 fields]
    \-- Heading [h1] - Title
        +-- Fenced div (open) [.empty]
        |   \-- Markdown [1 line]
        +-- Fenced div (close) 
        +-- Fenced div (open) [.just-class]
        |   \-- Markdown [1 line]
        +-- Fenced div (close) 
        \-- Markdown [1 line]

---

    +-- YAML [0 fields]
    +-- Heading [h1] - Analysis
    |   +-- Fenced div (open) [.code-example]
    |   |   \-- Heading [h2] - Code Demo
    |   |       +-- Chunk [r, 2 lines] - unnamed-chunk-1
    |   |       \-- Markdown [1 line]
    |   \-- Fenced div (close) 
    \-- Heading [h1] - Summary
        \-- Markdown [1 line]

# tree printing fenced divs with selection

    +-- YAML [0 fields]
    \-- Heading [h1] - Document
        +-- Heading [h2] - Section A
        |   +-- Fenced div (open) [.callout-note]
        |   |   +-- Heading [h3] - Note Header
        |   |   |   \-- Markdown [1 line]
        |   |   \-- Heading [h3] - Another Note Header
        |   |       \-- Markdown [1 line]
        |   \-- Fenced div (close) 
        +-- Heading [h2] - Section B
        |   +-- Markdown [1 line]
        |   +-- Fenced div (open) [.warning]
        |   |   \-- Heading [h3] - Warning in B
        |   |       \-- Markdown [1 line]
        |   +-- Fenced div (close) 
        |   \-- Heading [h3] - Regular Heading in B
        \-- Heading [h2] - Section C
            +-- Fenced div (open) [.tip]
            |   \-- Markdown [1 line]
            +-- Fenced div (close) 
            \-- Markdown [1 line]

---

    +-- YAML [0 fields]
    \-- Heading [h1] - Document
        \-- Heading [h2] - Section A
            +-- Fenced div (open) [.callout-note]
            |   +-- Heading [h3] - Note Header
            |   |   \-- Markdown [1 line]
            |   \-- Heading [h3] - Another Note Header
            |       \-- Markdown [1 line]
            \-- Fenced div (close) 

---

    +-- YAML [0 fields]
    \-- Heading [h1] - Document
        \-- Heading [h2] - Section B
            +-- Markdown [1 line]
            +-- Fenced div (open) [.warning]
            |   \-- Heading [h3] - Warning in B
            |       \-- Markdown [1 line]
            +-- Fenced div (close) 
            \-- Heading [h3] - Regular Heading in B

---

    +-- YAML [0 fields]
    \-- Heading [h1] - Document
        \-- Heading [h2] - Section B
            +-- Fenced div (open) [.warning]
            |   \-- Heading [h3] - Warning in B
            |       \-- Markdown [1 line]
            \-- Fenced div (close) 

