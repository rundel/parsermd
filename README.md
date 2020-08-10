
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

    parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd"))
    #> ── Heading [h1] - test ──────────────────────────────────────────────────────────────────────────────────────────
    #> ── Chunk [engine: 'r' name: 'setup' options: `include = FALSE`] ─────────────────────────────────────────────────
    #> ┌──────────────────────────────────┐
    #> │knitr::opts_chunk$set(echo = TRUE)│
    #> └──────────────────────────────────┘
    #> ── Heading [h1] - hello ─────────────────────────────────────────────────────────────────────────────────────────
    #> ── Heading [h2] - R Markdown ────────────────────────────────────────────────────────────────────────────────────
    #> This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
    #> 
    #> When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
    #> ── Chunk [engine: 'r' name: 'cars'] ─────────────────────────────────────────────────────────────────────────────
    #> ┌─────────────┐
    #> │summary(cars)│
    #> └─────────────┘
    #> ── Chunk [engine: 'r'] ──────────────────────────────────────────────────────────────────────────────────────────
    #> ┌──────────────────────────┐
    #> │knitr::knit_patterns$get()│
    #> └──────────────────────────┘
    #> ── Heading [h2] - Including Plots ───────────────────────────────────────────────────────────────────────────────
    #> You can also embed plots, for example:
    #> ── Chunk [engine: 'r' name: 'pressure' options: `echo = FALSE`] ─────────────────────────────────────────────────
    #> ┌──────────────┐
    #> │plot(pressure)│
    #> └──────────────┘
    #> Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

Example - Student Work
----------------------
