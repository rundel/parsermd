
<!-- README.md is generated from README.Rmd. Please edit that file -->

# parsermd

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of parsermd is to extract the content of an Rmarkdown file to
allow for programmatic interactions with the document’s cotents
(i.e. code chunks and markdown text). The goal is to capture the
fundamental structure of the document and as such we do not attempt to
parse every detail of the Rmd. Specifically, the yaml front matter,
markdown text, and R code are read as text lines allowing them to be
processed using other tools.

## Installation

You can install the development version of parsermd from
[GitHub](https://github.com/rundel/parsermd) with:

``` r
remotes::install_github("rundel/parsermd")
```

``` r
library(parsermd)
```

## Basic Usage

For more details see the getting started vignette or any of the topic
specific articles.

``` r
(rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd")))
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

as_tibble(rmd)
#> # A tibble: 12 x 5
#>    sec_h1 sec_h2          type          label      ast           
#>    <chr>  <chr>           <chr>         <chr>      <rmd_ast>     
#>  1 <NA>   <NA>            rmd_yaml_list  <NA>      <yaml>        
#>  2 test   <NA>            rmd_heading    <NA>      <heading [h1]>
#>  3 test   <NA>            rmd_chunk     "setup"    <chunk [r]>   
#>  4 hello  <NA>            rmd_heading    <NA>      <heading [h1]>
#>  5 hello  R Markdown      rmd_heading    <NA>      <heading [h2]>
#>  6 hello  R Markdown      rmd_markdown   <NA>      <markdown [4]>
#>  7 hello  R Markdown      rmd_chunk     "cars"     <chunk [r]>   
#>  8 hello  R Markdown      rmd_chunk     ""         <chunk [r]>   
#>  9 hello  Including Plots rmd_heading    <NA>      <heading [h2]>
#> 10 hello  Including Plots rmd_markdown   <NA>      <markdown [2]>
#> 11 hello  Including Plots rmd_chunk     "pressure" <chunk [r]>   
#> 12 hello  Including Plots rmd_markdown   <NA>      <markdown [1]>

rmd_subset(rmd, sec_refs = "hello", type_refs = "rmd_chunk")
#> └── Heading [h1] - hello
#>     ├── Chunk [r, 1 lines] - cars
#>     ├── Chunk [r, 1 lines] - <unnamed>
#>     └── Chunk [r, 1 opt, 1 lines] - pressure

rmd_subset(rmd, sec_refs = c("hello", "*"), type_refs = "rmd_chunk")
#> └── Heading [h1] - hello
#>     ├── Heading [h2] - R Markdown
#>     │   ├── Chunk [r, 1 lines] - cars
#>     │   └── Chunk [r, 1 lines] - <unnamed>
#>     └── Heading [h2] - Including Plots
#>         └── Chunk [r, 1 opt, 1 lines] - pressure

rmd_get_node(rmd, name_refs = "pressure")
#> $engine
#> [1] "r"
#> 
#> $name
#> [1] "pressure"
#> 
#> $options
#> $options$echo
#> [1] "FALSE"
#> 
#> 
#> $code
#> [1] "plot(pressure)"
#> 
#> $indent
#> [1] ""
#> 
#> attr(,"class")
#> [1] "rmd_chunk"
```
