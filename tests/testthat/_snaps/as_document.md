# ast -> document

    ---
    title: Minimal
    author: Colin Rundel
    date: 7/21/2020
    output: html_document
    ---
    
    # Setup
    
    ```{r setup, include = FALSE}
    knitr::opts_chunk$set(echo = TRUE)
    ```
    
    # Content
    
    ## R Markdown
    
    This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, 
    PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    
    When you click the **Knit** button a document will be generated that includes both content as well 
    as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
    
    
    ```{r cars}
    summary(cars)
    ```
    
    ```{r}
    knitr::knit_patterns$get()
    ```
    
    ## Including Plots
    
    You can also embed plots, for example:
    
    
    ```{r pressure, echo = FALSE}
    plot(pressure)
    ```
    
    Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code 
    that generated the plot.
    

---

    ---
    title: Lab 01 - Hello R
    output: html_document
    ---
    
    ### Load packages
    
    ```{r load-packages, message = FALSE}
    library(tidyverse) 
    library(datasauRus)
    ```
    
    ### Exercise 1
    
    Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report. When you’re done, commit your changes with the commit message “Added answer for Ex 1”, and push.
    
    
    #### Solution
    
    2 columns, 13 rows, 3 variables: 
    dataset: indicates which dataset the data are from 
    x: x-values 
    y: y-values 
    
    
    ### Exercise 2
    
    Plot `y` vs. `x` for the `dino` dataset. Then, calculate the correlation coefficient between x and y for this dataset.
    
    
    #### Solution
    
    First let's plot the data in the dino dataset:
    
    
    ```{r plot-dino, fig.height = 3, fig.width = 6}
    dino_data <- datasaurus_dozen %>%
      filter(dataset == "dino")
    
    ggplot(data = dino_data, mapping = aes(x = x, y = y)) +
      geom_point()
    ```
    
    And next calculate the correlation between `x` and `y` in this dataset:
    
    
    ```{r cor-dino}
    dino_data %>%
      summarize(r = cor(x, y))
    ```
    
    ### Exercise 3
    
    Plot `y` vs. `x` for the `star` dataset. You can (and should) reuse code we introduced above, just replace the dataset name with the desired dataset. Then, calculate the correlation coefficient between x and y for this dataset. How does this value compare to the r of dino?
    
    
    #### Solution
    
    ```{r plot-star, fig.height = 3, fig.width = 6}
    star_data <- datasaurus_dozen %>%
      filter(dataset == "star")
    
    ggplot(data = star_data, mapping = aes(x = x, y = y)) +
      geom_point()
    ```
    
    ```{r cor-star}
    star_data %>%
      summarize(r = cor(x, y))
    ```
    

---

    ---
    title: Homework 01 - Hello R
    output: html_document
    ---
    
    ### Load packages
    
    ```{r load-packages, message = FALSE}
    library(tidyverse) 
    library(datasauRus)
    ```
    
    ### Exercise 1
    
    Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report. When you’re done, commit your changes with the commit message “Added answer for Ex 1”, and push.
    
    
    #### Solution
    
    (Type your answer to Exercise 1 here. This exercise does not require any R code.)
    
    
    ### Exercise 2
    
    Plot `y` vs. `x` for the `dino` dataset. Then, calculate the correlation coefficient between x and y for this dataset.
    
    
    #### Solution
    
    (The answers for this Exercise are given for you below. But you should clean up some of the narrative so that it only includes what you want to turn in.)
    
    First let's plot the data in the dino dataset:
    
    
    ```{r plot-dino, fig.height = 3, fig.width = 6}
    dino_data <- datasaurus_dozen %>%
      filter(dataset == "dino")
    
    ggplot(data = dino_data, mapping = aes(x = x, y = y)) +
      geom_point()
    ```
    
    And next calculate the correlation between `x` and `y` in this dataset:
    
    
    ```{r cor-dino}
    dino_data %>%
      summarize(r = cor(x, y))
    ```
    
    ### Exercise 3
    
    Plot `y` vs. `x` for the `star` dataset. You can (and should) reuse code we introduced above, just replace the dataset name with the desired dataset. Then, calculate the correlation coefficient between x and y for this dataset. How does this value compare to the r of dino?
    
    
    #### Solution
    
    (Add code and narrative as needed. Note that the R chunks are labeled with `plot-star` and `cor-star` to provide spaces to place the code for plotting and calculating the correlation coefficient. To finish, clean up the narrative by removing these instructions.)
    
    Blah blah blah...
    
    
    ```{r plot-star}
    
    ```
    
    I'm some text, you should replace me with more meaningful text...
    
    
    ```{r cor-star}
    
    ```
    

---

    ---
    title: Reversed Sections
    output: html_document
    ---
    
    ### H3
    
    ## H2
    
    ### H3 - Part 2
    
    # H1
    

---

    ---
    title: Raw attribute example
    ---
    
    ## R Markdown
    
    This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    
    When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
    
    
    ```{r cars}
    summary(cars)
    ```
    
    ## Pandoc Raw Attribute Chunk
    
    This is more markdown text,
    
    
    ```{=html}
    Hello, <b>I</b> am some html!
    
    <del>Uh oh!</del>
    
    <br/>
    ```
    

