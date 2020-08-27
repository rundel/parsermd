
<!-- README.md is generated from README.Rmd. Please edit that file -->

parsermd
========

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of parsermd is to extract the content of an Rmarkdown file to
allow for programmatic interactions with the code chunks and markdown
content. The goal is to capture the fundamental structure of the
document and as such we do not attempt to parse every detail of the Rmd.
Specifically, the yaml front matter, markdown text, and R code are read
as text lines allowing them to be processed latter with sepecific tools
like `yaml::read_yaml` or `base::parse`.

Installation
------------

You can install the released version of parsermd from
[GitHub](https://github.com/rundel/parsermd) with:

    remotes::install_github("rundel/parsermd")

    library(parsermd)

Example
-------

This is a basic example which shows you the basic abstract syntax tree
(AST) that results from parsing a simple Rmd file,

    rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

The RMarkdown document is parsed and stored in a flat, ordered list
object containing tagged elements. By default the package will present a
heirachical view of the document where chunks and markdown text are
nested within headings, which is shown by the default print method for
`rmd_ast` objects.

    print(rmd)
    #> ├── YAML [4 lines]
    #> ├── Heading [h1] - test
    #> │   └── Chunk [r, 1 opt, 1 lines] - setup
    #> └── Heading [h1] - hello
    #>     ├── Heading [h2] - R Markdown
    #>     │   ├── Markdown [4 lines]
    #>     │   ├── Chunk [r, 1 lines] - cars
    #>     │   └── Chunk [r, 1 lines] - <unnamed>
    #>     └── Heading [h2] - Including Plots
    #>         ├── Markdown [2 lines]
    #>         ├── Chunk [r, 1 opt, 1 lines] - pressure
    #>         └── Markdown [1 lines]

If you would prefer to see the underlying flat structure, this can be
printed by setting `use_headings = FALSE` with `print`.

    print(rmd, use_headings = FALSE)
    #> ├── YAML [4 lines]
    #> ├── Heading [h1] - test
    #> ├── Chunk [r, 1 opt, 1 lines] - setup
    #> ├── Heading [h1] - hello
    #> ├── Heading [h2] - R Markdown
    #> ├── Markdown [4 lines]
    #> ├── Chunk [r, 1 lines] - cars
    #> ├── Chunk [r, 1 lines] - <unnamed>
    #> ├── Heading [h2] - Including Plots
    #> ├── Markdown [2 lines]
    #> ├── Chunk [r, 1 opt, 1 lines] - pressure
    #> └── Markdown [1 lines]

Additionally, to ease the manipulation of the AST the package supports
the transformation of the object into a tidy tibble with `as_tibble` or
`as.data.frame` (both return a tibble).

    as_tibble(rmd)
    #> # A tibble: 12 x 5
    #>    sec_h1 sec_h2          type          name              ast           
    #>    <chr>  <chr>           <chr>         <chr>             <rmd_ast>     
    #>  1 <NA>   <NA>            rmd_yaml_list  <NA>             <yaml>        
    #>  2 test   <NA>            rmd_heading   "test"            <heading [h1]>
    #>  3 test   <NA>            rmd_chunk     "setup"           <chunk [r]>   
    #>  4 hello  <NA>            rmd_heading   "hello"           <heading [h1]>
    #>  5 hello  R Markdown      rmd_heading   "R Markdown"      <heading [h2]>
    #>  6 hello  R Markdown      rmd_markdown   <NA>             <markdown [4]>
    #>  7 hello  R Markdown      rmd_chunk     "cars"            <chunk [r]>   
    #>  8 hello  R Markdown      rmd_chunk     ""                <chunk [r]>   
    #>  9 hello  Including Plots rmd_heading   "Including Plots" <heading [h2]>
    #> 10 hello  Including Plots rmd_markdown   <NA>             <markdown [2]>
    #> 11 hello  Including Plots rmd_chunk     "pressure"        <chunk [r]>   
    #> 12 hello  Including Plots rmd_markdown   <NA>             <markdown [1]>

and it is possible to convert from these data frames back into an
`rmd_ast`.

    as_ast( as_tibble(rmd) )
    #> ├── YAML [4 lines]
    #> ├── Heading [h1] - test
    #> │   └── Chunk [r, 1 opt, 1 lines] - setup
    #> └── Heading [h1] - hello
    #>     ├── Heading [h2] - R Markdown
    #>     │   ├── Markdown [4 lines]
    #>     │   ├── Chunk [r, 1 lines] - cars
    #>     │   └── Chunk [r, 1 lines] - <unnamed>
    #>     └── Heading [h2] - Including Plots
    #>         ├── Markdown [2 lines]
    #>         ├── Chunk [r, 1 opt, 1 lines] - pressure
    #>         └── Markdown [1 lines]

Finally, we can also convert the `rmd_ast` back into an RMarkdown
document via `as_document`

    cat(
      as_document(rmd),
      sep = "\n"
    )
    #> ---
    #> title: Minimal
    #> author: Colin Rundel
    #> date: 7/21/2020
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
