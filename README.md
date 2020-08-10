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

Example - Minimal
-----------------

This is a basic example which shows you the basic abstract syntax tree
(AST) that results from parsing a simple Rmd file,

    rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

    print(rmd)
    #> Rmd AST
    #> ├─YAML [90m[4 lines][39m
    #> ├─Heading [90m[h1] - [1mtest[22m[39m
    #> │ └─Chunk [90m[r, 1 opt, 1 lines] - [1msetup[22m[39m
    #> └─Heading [90m[h1] - [1mhello[22m[39m
    #>   ├─Heading [90m[h2] - [1mR Markdown[22m[39m
    #>   │ ├─Markdown [90m[4 lines][39m
    #>   │ ├─Chunk [90m[r, 1 lines] - [1mcars[22m[39m
    #>   │ └─Chunk [90m[r, 1 lines] - [3m<unnamed>[23m[39m
    #>   └─Heading [90m[h2] - [1mIncluding Plots[22m[39m
    #>     ├─Markdown [90m[2 lines][39m
    #>     ├─Chunk [90m[r, 1 opt, 1 lines] - [1mpressure[22m[39m
    #>     └─Markdown [90m[1 lines][39m

    print(rmd, as_tree = FALSE)
    #> ── [1m[1mHeading[1m[22m [h1] - [3m[3mtest[3m[23m ──────────────────────────────────────────────────────────────────────────────────────────
    #> ── [1m[1mChunk[1m[22m [engine: [34m[34m'r'[34m[39m name: [34m[34m'setup'[34m[39m options: [38;5;235m[48;5;253m[38;5;235m[48;5;253m`include = FALSE`[48;5;253m[38;5;235m[49m[39m] ─────────────────────────────────────────────────
    #> ┌──────────────────────────────────┐
    #> │knitr::opts_chunk$set(echo = TRUE)│
    #> └──────────────────────────────────┘
    #> ── [1m[1mHeading[1m[22m [h1] - [3m[3mhello[3m[23m ─────────────────────────────────────────────────────────────────────────────────────────
    #> ── [1m[1mHeading[1m[22m [h2] - [3m[3mR Markdown[3m[23m ────────────────────────────────────────────────────────────────────────────────────
    #> This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    #> 
    #> When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
    #> ── [1m[1mChunk[1m[22m [engine: [34m[34m'r'[34m[39m name: [34m[34m'cars'[34m[39m] ─────────────────────────────────────────────────────────────────────────────
    #> ┌─────────────┐
    #> │summary(cars)│
    #> └─────────────┘
    #> ── [1m[1mChunk[1m[22m [engine: [34m[34m'r'[34m[39m] ──────────────────────────────────────────────────────────────────────────────────────────
    #> ┌──────────────────────────┐
    #> │knitr::knit_patterns$get()│
    #> └──────────────────────────┘
    #> ── [1m[1mHeading[1m[22m [h2] - [3m[3mIncluding Plots[3m[23m ───────────────────────────────────────────────────────────────────────────────
    #> You can also embed plots, for example:
    #> ── [1m[1mChunk[1m[22m [engine: [34m[34m'r'[34m[39m name: [34m[34m'pressure'[34m[39m options: [38;5;235m[48;5;253m[38;5;235m[48;5;253m`echo = FALSE`[48;5;253m[38;5;235m[49m[39m] ─────────────────────────────────────────────────
    #> ┌──────────────┐
    #> │plot(pressure)│
    #> └──────────────┘
    #> Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

Example - Student Work
----------------------
