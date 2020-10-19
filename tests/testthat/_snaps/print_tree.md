# tree printing

    Problem: "# t"
    Size: 6, 0, 5
    Error parsing line 1, expected "```"
    # test
    ^~~~~~
    Problem: "# h"
    Size: 7, 0, 6
    Error parsing line 1, expected "```"
    # hello
    ^~~~~~~
    Problem: "## "
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    ## R Markdown
    ^~~~~~~~~~~~~
    Problem: "Thi"
    Size: 191, 0, 190
    Error parsing line 1, expected "```"
    This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "## "
    Size: 18, 0, 17
    Error parsing line 1, expected "```"
    ## Including Plots
    ^~~~~~~~~~~~~~~~~~
    Problem: "You"
    Size: 38, 0, 37
    Error parsing line 1, expected "```"
    You can also embed plots, for example:
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "Not"
    Size: 125, 0, 124
    Error parsing line 1, expected "```"
    Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "8"
    Size: 0, 0, 0
    Error parsing line 1, expected "```"
    
    ^
    +-- YAML [4 lines]
    +-- Heading [h1] - test
    |   \-- Chunk [r, 1 opt, 1 lines] - setup
    \-- Heading [h1] - hello
        +-- Heading [h2] - R Markdown
        |   +-- Markdown [4 lines]
        |   +-- Chunk [r, 1 lines] - cars
        |   \-- Chunk [r, 1 lines] - <unnamed>
        \-- Heading [h2] - Including Plots
            +-- Markdown [2 lines]
            +-- Chunk [r, 1 opt, 1 lines] - pressure
            \-- Markdown [1 lines]

---

    Problem: "###"
    Size: 17, 0, 16
    Error parsing line 1, expected "```"
    ### Load packages
    ^~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 1
    ^~~~~~~~~~~~~~
    Problem: "Bas"
    Size: 290, 0, 289
    Error parsing line 1, expected "```"
    Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report. When you’re done, commit your changes with the commit message “Added answer for Ex 1”, and push.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: "2 c"
    Size: 33, 0, 32
    Error parsing line 1, expected "```"
    2 columns, 13 rows, 3 variables: 
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 2
    ^~~~~~~~~~~~~~
    Problem: "Plo"
    Size: 118, 0, 117
    Error parsing line 1, expected "```"
    Plot `y` vs. `x` for the `dino` dataset. Then, calculate the correlation coefficient between x and y for this dataset.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: "Fir"
    Size: 46, 0, 45
    Error parsing line 1, expected "```"
    First let's plot the data in the dino dataset:
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "And"
    Size: 71, 0, 70
    Error parsing line 1, expected "```"
    And next calculate the correlation between `x` and `y` in this dataset:
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 3
    ^~~~~~~~~~~~~~
    Problem: "Plo"
    Size: 273, 0, 272
    Error parsing line 1, expected "```"
    Plot `y` vs. `x` for the `star` dataset. You can (and should) reuse code we introduced above, just replace the dataset name with the desired dataset. Then, calculate the correlation coefficient between x and y for this dataset. How does this value compare to the r of dino?
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: ""
    Size: 0, 0, 0
    Error parsing line 1, expected "```"
    
    ^
    +-- YAML [2 lines]
    +-- Heading [h3] - Load packages
    |   \-- Chunk [r, 1 opt, 2 lines] - load-packages
    +-- Heading [h3] - Exercise 1
    |   +-- Markdown [2 lines]
    |   \-- Heading [h4] - Solution
    |       \-- Markdown [5 lines]
    +-- Heading [h3] - Exercise 2
    |   +-- Markdown [2 lines]
    |   \-- Heading [h4] - Solution
    |       +-- Markdown [2 lines]
    |       +-- Chunk [r, 2 opts, 5 lines] - plot-dino
    |       +-- Markdown [2 lines]
    |       \-- Chunk [r, 2 lines] - cor-dino
    \-- Heading [h3] - Exercise 3
        +-- Markdown [2 lines]
        \-- Heading [h4] - Solution
            +-- Chunk [r, 2 opts, 5 lines] - plot-star
            \-- Chunk [r, 2 lines] - cor-star

---

    Problem: "###"
    Size: 17, 0, 16
    Error parsing line 1, expected "```"
    ### Load packages
    ^~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 1
    ^~~~~~~~~~~~~~
    Problem: "Bas"
    Size: 290, 0, 289
    Error parsing line 1, expected "```"
    Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report. When you’re done, commit your changes with the commit message “Added answer for Ex 1”, and push.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: "(Ty"
    Size: 81, 0, 80
    Error parsing line 1, expected "```"
    (Type your answer to Exercise 1 here. This exercise does not require any R code.)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 2
    ^~~~~~~~~~~~~~
    Problem: "Plo"
    Size: 118, 0, 117
    Error parsing line 1, expected "```"
    Plot `y` vs. `x` for the `dino` dataset. Then, calculate the correlation coefficient between x and y for this dataset.
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: "(Th"
    Size: 153, 0, 152
    Error parsing line 1, expected "```"
    (The answers for this Exercise are given for you below. But you should clean up some of the narrative so that it only includes what you want to turn in.)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "And"
    Size: 71, 0, 70
    Error parsing line 1, expected "```"
    And next calculate the correlation between `x` and `y` in this dataset:
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 14, 0, 13
    Error parsing line 1, expected "```"
    ### Exercise 3
    ^~~~~~~~~~~~~~
    Problem: "Plo"
    Size: 273, 0, 272
    Error parsing line 1, expected "```"
    Plot `y` vs. `x` for the `star` dataset. You can (and should) reuse code we introduced above, just replace the dataset name with the desired dataset. Then, calculate the correlation coefficient between x and y for this dataset. How does this value compare to the r of dino?
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "###"
    Size: 13, 0, 12
    Error parsing line 1, expected "```"
    #### Solution
    ^~~~~~~~~~~~~
    Problem: "(Ad"
    Size: 262, 0, 261
    Error parsing line 1, expected "```"
    (Add code and narrative as needed. Note that the R chunks are labeled with `plot-star` and `cor-star` to provide spaces to place the code for plotting and calculating the correlation coefficient. To finish, clean up the narrative by removing these instructions.)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: "I'm"
    Size: 65, 0, 64
    Error parsing line 1, expected "```"
    I'm some text, you should replace me with more meaningful text...
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Problem: ""
    Size: 0, 0, 0
    Error parsing line 1, expected "```"
    
    ^
    +-- YAML [2 lines]
    +-- Heading [h3] - Load packages
    |   \-- Chunk [r, 1 opt, 2 lines] - load-packages
    +-- Heading [h3] - Exercise 1
    |   +-- Markdown [2 lines]
    |   \-- Heading [h4] - Solution
    |       \-- Markdown [2 lines]
    +-- Heading [h3] - Exercise 2
    |   +-- Markdown [2 lines]
    |   \-- Heading [h4] - Solution
    |       +-- Markdown [4 lines]
    |       +-- Chunk [r, 2 opts, 5 lines] - plot-dino
    |       +-- Markdown [2 lines]
    |       \-- Chunk [r, 2 lines] - cor-dino
    \-- Heading [h3] - Exercise 3
        +-- Markdown [2 lines]
        \-- Heading [h4] - Solution
            +-- Markdown [4 lines]
            +-- Chunk [r, 1 lines] - plot-star
            +-- Markdown [2 lines]
            \-- Chunk [r, 1 lines] - cor-star

---

    Problem: "###"
    Size: 6, 0, 5
    Error parsing line 1, expected "```"
    ### H3
    ^~~~~~
    Problem: "## "
    Size: 5, 0, 4
    Error parsing line 1, expected "```"
    ## H2
    ^~~~~
    Problem: "###"
    Size: 15, 0, 14
    Error parsing line 1, expected "```"
    ### H3 - Part 2
    ^~~~~~~~~~~~~~~
    Problem: "# H"
    Size: 4, 0, 3
    Error parsing line 1, expected "```"
    # H1
    ^~~~
    Problem: ""
    Size: 0, 0, 0
    Error parsing line 1, expected "```"
    
    ^
    +-- YAML [2 lines]
    +-- Heading [h3] - H3
    +-- Heading [h2] - H2
    |   \-- Heading [h3] - H3 - Part 2
    \-- Heading [h1] - H1

