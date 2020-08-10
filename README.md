
<!-- README.md is generated from README.Rmd. Please edit that file -->

parsermd
========

<!-- badges: start -->
<!-- badges: end -->

The goal of parsermd is to extract the content of an Rmarkdown file to
allow for programmatic interactions with the code chunks and markdown
contents.

Installation
------------

You can install the released version of parsermd from
[GitHub](https://github.com/rundel/parsermd) with:

    remotes::install_github("rundel/parsermd")

    library(parsermd)

Example - Minimal
-----------------

This is a basic example which shows you the basic abstract syntax tree
(AST) that results from parsing a simple Rmd file,

    rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

The RMarkdown document is parsed and stored in a flat, ordered list
object containing tagged elements. By default the package will present a
heirachical view of the document where chunks and markdown text are
nested within headings, this is shown by the default print methods.

    print(rmd)
    #> Rmd AST
    #> ├─YAML [4 lines]
    #> ├─Heading [h1] - test
    #> │ └─Chunk [r, 1 opt, 1 lines] - setup
    #> └─Heading [h1] - hello
    #>   ├─Heading [h2] - R Markdown
    #>   │ ├─Markdown [4 lines]
    #>   │ ├─Chunk [r, 1 lines] - cars
    #>   │ └─Chunk [r, 1 lines] - <unnamed>
    #>   └─Heading [h2] - Including Plots
    #>     ├─Markdown [2 lines]
    #>     ├─Chunk [r, 1 opt, 1 lines] - pressure
    #>     └─Markdown [1 lines]

If you would prefer to see the underlying flat structure, this can be
seen by setting `use_headings = FALSE` with `print`.

    print(rmd, use_headings = FALSE)
    #> Rmd AST
    #> ├─YAML [4 lines]
    #> ├─Heading [h1] - test
    #> ├─Chunk [r, 1 opt, 1 lines] - setup
    #> ├─Heading [h1] - hello
    #> ├─Heading [h2] - R Markdown
    #> ├─Markdown [4 lines]
    #> ├─Chunk [r, 1 lines] - cars
    #> ├─Chunk [r, 1 lines] - <unnamed>
    #> ├─Heading [h2] - Including Plots
    #> ├─Markdown [2 lines]
    #> ├─Chunk [r, 1 opt, 1 lines] - pressure
    #> └─Markdown [1 lines]

Additionally, to ease the manipulation of the AST the package supports
the transformation of the object into a tidy tibble with `as_tibble` or
`as.data.frame` (both return a tibble).

    as_tibble(rmd)
    #> # A tibble: 8 x 4
    #>   sec_h1 sec_h2          type         data          
    #>   <chr>  <chr>           <chr>        <list>        
    #> 1 <NA>   <NA>            rmd_yaml     <rmd_yaml [4]>
    #> 2 test   <NA>            rmd_chunk    <rmd_chnk>    
    #> 3 hello  R Markdown      rmd_markdown <rmd_mrkd [4]>
    #> 4 hello  R Markdown      rmd_chunk    <rmd_chnk>    
    #> 5 hello  R Markdown      rmd_chunk    <rmd_chnk>    
    #> 6 hello  Including Plots rmd_markdown <rmd_mrkd [2]>
    #> 7 hello  Including Plots rmd_chunk    <rmd_chnk>    
    #> 8 hello  Including Plots rmd_markdown <rmd_mrkd [1]>

and as expected this data frame representation can also be converted
back into an AST.

    as_ast( as_tibble(rmd) )
    #> Rmd AST
    #> ├─YAML [4 lines]
    #> ├─Heading [h1] - test
    #> │ └─Chunk [r, 1 opt, 1 lines] - setup
    #> └─Heading [h1] - hello
    #>   ├─Heading [h2] - R Markdown
    #>   │ ├─Markdown [4 lines]
    #>   │ ├─Chunk [r, 1 lines] - cars
    #>   │ └─Chunk [r, 1 lines] - <unnamed>
    #>   └─Heading [h2] - Including Plots
    #>     ├─Markdown [2 lines]
    #>     ├─Chunk [r, 1 opt, 1 lines] - pressure
    #>     └─Markdown [1 lines]

Finally, we can also convert the AST back into an RMarkdown document via
`as_document`

    cat(
      as_document(rmd),
      sep = "\n"
    )
    #> ---
    #> title: "Minimal"
    #> author: "Colin Rundel"
    #> date: "7/21/2020"
    #> output: html_document
    #> ---
    #> 
    #> # test
    #> 
    #> ```{rsetup, include = FALSE}
    #> knitr::opts_chunk$set(echo = TRUE)
    #> ```
    #> 
    #> # hello
    #> 
    #> ## R Markdown
    #> 
    #> This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    #> 
    #> When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
    #> 
    #> 
    #> ```{rcars}
    #> summary(cars)
    #> ```
    #> 
    #> ```{r}
    #> knitr::knit_patterns$get()
    #> ```
    #> 
    #> ## Including Plots
    #> 
    #> You can also embed plots, for example:
    #> 
    #> 
    #> ```{rpressure, echo = FALSE}
    #> plot(pressure)
    #> ```
    #> 
    #> Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

Example - Student Work
----------------------
