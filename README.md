
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

Parsing Rmds
------------

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

Working with the AST
--------------------

Once we have parsed an R Markdown document, there are a variety of
things that we can do with our new abstract syntax tree (ast). Below we
will demonstate some of the basic functionality within `parsermd` to
manipulate and edit these objects as well as check their properties.

    rmd = parse_rmd(system.file("hw01-student.Rmd", package="parsermd"))
    rmd
    #> ├── YAML [2 lines]
    #> ├── Heading [h3] - Load packages
    #> │   └── Chunk [r, 1 opt, 2 lines] - load-packages
    #> ├── Heading [h3] - Exercise 1
    #> │   ├── Markdown [2 lines]
    #> │   └── Heading [h4] - Solution
    #> │       └── Markdown [5 lines]
    #> ├── Heading [h3] - Exercise 2
    #> │   ├── Markdown [2 lines]
    #> │   └── Heading [h4] - Solution
    #> │       ├── Markdown [2 lines]
    #> │       ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #> │       ├── Markdown [2 lines]
    #> │       └── Chunk [r, 2 lines] - cor-dino
    #> └── Heading [h3] - Exercise 3
    #>     ├── Markdown [2 lines]
    #>     └── Heading [h4] - Solution
    #>         ├── Chunk [r, 2 opts, 5 lines] - plot-star
    #>         └── Chunk [r, 2 lines] - cor-star

Saw we were interested in examining the solution a student entered for
Exercise 1 - we can get acess to this using the `rmd_subset` function.

    rmd_subset(rmd, sec_refs = c("Exercise 1", "Solution"))
    #> └── Heading [h3] - Exercise 1
    #>     └── Heading [h4] - Solution
    #>         └── Markdown [5 lines]

Note that this gives me the *Exercise 1* and *Solution* headings and the
contained markdown text, if we want to examine the actual text then we
can extact that specific node of the ast usign `rmd_get_node`. Here we
further specify that we want just nodes with type `rmd_markdown` via the
`type_refs` argument.

    rmd_get_node(rmd, sec_refs = c("Exercise 1", "Solution"), type_refs = "rmd_markdown")
    #> [1] "2 columns, 13 rows, 3 variables: "                  
    #> [2] "dataset: indicates which dataset the data are from "
    #> [3] "x: x-values "                                       
    #> [4] "y: y-values "                                       
    #> [5] ""                                                   
    #> attr(,"class")
    #> [1] "rmd_markdown"

We can use a similar approach to examine the solutions to Exercise 2.

    rmd_subset(rmd, sec_refs = c("Exercise 2", "Solution"))
    #> └── Heading [h3] - Exercise 2
    #>     └── Heading [h4] - Solution
    #>         ├── Markdown [2 lines]
    #>         ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #>         ├── Markdown [2 lines]
    #>         └── Chunk [r, 2 lines] - cor-dino

and also note that test functions can be strung together using pipes, so
the following extracts just the code chunks from this set of solutions.

    rmd_subset(rmd, sec_refs = c("Exercise 2", "Solution")) %>% 
      rmd_subset(type_refs = "rmd_chunk")
    #> ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #> └── Chunk [r, 2 lines] - cor-dino

in this case since our second call to `rmd_subset` did not include a
`sec_refs` argument the assumption is that we no longer care about the
section structure and these are therefore dropped. Had we wanted to keep
these headings we would have used the `sec_refs` argument to specify
which of the headings to keep.

    rmd_subset(rmd, sec_refs = c("Exercise 2", "Solution")) %>% 
      rmd_subset(sec_refs = "Exercise 2", type_refs = "rmd_chunk")
    #> └── Heading [h3] - Exercise 2
    #>     ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #>     └── Chunk [r, 2 lines] - cor-dino

Since chunk labels are, supposed to be, unique we can also use these to
reference chunks directly.

    rmd_get_node(rmd, name_refs = "plot-dino")
    #> $engine
    #> [1] "r"
    #> 
    #> $name
    #> [1] "plot-dino"
    #> 
    #> $options
    #> $options$fig.height
    #> [1] "3"
    #> 
    #> $options$fig.width
    #> [1] "6"
    #> 
    #> 
    #> $code
    #> [1] "dino_data <- datasaurus_dozen %>%"                      
    #> [2] "  filter(dataset == \"dino\")"                          
    #> [3] ""                                                       
    #> [4] "ggplot(data = dino_data, mapping = aes(x = x, y = y)) +"
    #> [5] "  geom_point()"                                         
    #> 
    #> $indent
    #> [1] ""
    #> 
    #> attr(,"class")
    #> [1] "rmd_chunk"

### Wildcards

One useful feature of these subsetting functions is that they support
[glob](https://en.wikipedia.org/wiki/Glob_(programming)) style pattern
matching for determining matches within section headings and in chunk
labels. As such we can do the following to extract all of the solutions
from our document:

    rmd_subset(rmd, sec_refs = c("Exercise *", "Solution"))
    #> ├── Heading [h3] - Exercise 1
    #> │   └── Heading [h4] - Solution
    #> │       └── Markdown [5 lines]
    #> ├── Heading [h3] - Exercise 2
    #> │   └── Heading [h4] - Solution
    #> │       ├── Markdown [2 lines]
    #> │       ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #> │       ├── Markdown [2 lines]
    #> │       └── Chunk [r, 2 lines] - cor-dino
    #> └── Heading [h3] - Exercise 3
    #>     └── Heading [h4] - Solution
    #>         ├── Chunk [r, 2 opts, 5 lines] - plot-star
    #>         └── Chunk [r, 2 lines] - cor-star

Similarly, if we wanted to just extract the chunks that involve plotting
we can match for chunk labels with a “plot” prefix,

    rmd_subset(rmd, name_refs = "plot*")
    #> ├── Chunk [r, 2 opts, 5 lines] - plot-dino
    #> └── Chunk [r, 2 opts, 5 lines] - plot-star

and as before if we want to keep track of the parent headings we need to
specify an appropriate `sec_refs`,

    rmd_subset(rmd, sec_refs = "Exercise *", name_refs = "plot*")
    #> ├── Heading [h3] - Exercise 1
    #> ├── Heading [h3] - Exercise 2
    #> │   └── Chunk [r, 2 opts, 5 lines] - plot-dino
    #> └── Heading [h3] - Exercise 3
    #>     └── Chunk [r, 2 opts, 5 lines] - plot-star

### ast as a tibble

As mentioned earlier, the ast can be represented as a tibble, in which
case we construct several columns using the properties of the ast
(sections, type, and chunk label).

    tbl = as_tibble(rmd)
    tbl
    #> # A tibble: 19 x 5
    #>    sec_h3        sec_h4   type          label         ast           
    #>    <chr>         <chr>    <chr>         <chr>         <rmd_ast>     
    #>  1 <NA>          <NA>     rmd_yaml_list <NA>          <yaml>        
    #>  2 Load packages <NA>     rmd_heading   <NA>          <heading [h3]>
    #>  3 Load packages <NA>     rmd_chunk     load-packages <chunk [r]>   
    #>  4 Exercise 1    <NA>     rmd_heading   <NA>          <heading [h3]>
    #>  5 Exercise 1    <NA>     rmd_markdown  <NA>          <markdown [2]>
    #>  6 Exercise 1    Solution rmd_heading   <NA>          <heading [h4]>
    #>  7 Exercise 1    Solution rmd_markdown  <NA>          <markdown [5]>
    #>  8 Exercise 2    <NA>     rmd_heading   <NA>          <heading [h3]>
    #>  9 Exercise 2    <NA>     rmd_markdown  <NA>          <markdown [2]>
    #> 10 Exercise 2    Solution rmd_heading   <NA>          <heading [h4]>
    #> 11 Exercise 2    Solution rmd_markdown  <NA>          <markdown [2]>
    #> 12 Exercise 2    Solution rmd_chunk     plot-dino     <chunk [r]>   
    #> 13 Exercise 2    Solution rmd_markdown  <NA>          <markdown [2]>
    #> 14 Exercise 2    Solution rmd_chunk     cor-dino      <chunk [r]>   
    #> 15 Exercise 3    <NA>     rmd_heading   <NA>          <heading [h3]>
    #> 16 Exercise 3    <NA>     rmd_markdown  <NA>          <markdown [2]>
    #> 17 Exercise 3    Solution rmd_heading   <NA>          <heading [h4]>
    #> 18 Exercise 3    Solution rmd_chunk     plot-star     <chunk [r]>   
    #> 19 Exercise 3    Solution rmd_chunk     cor-star      <chunk [r]>

All of the functions above also work with this tibble representation,
and allow for the same manipulations of the underlying ast.

    rmd_subset(tbl, sec_refs = c("Exercise *", "Solution"))
    #> # A tibble: 13 x 5
    #>    sec_h3     sec_h4   type         label     ast           
    #>    <chr>      <chr>    <chr>        <chr>     <rmd_ast>     
    #>  1 Exercise 1 <NA>     rmd_heading  <NA>      <heading [h3]>
    #>  2 Exercise 1 Solution rmd_heading  <NA>      <heading [h4]>
    #>  3 Exercise 1 Solution rmd_markdown <NA>      <markdown [5]>
    #>  4 Exercise 2 <NA>     rmd_heading  <NA>      <heading [h3]>
    #>  5 Exercise 2 Solution rmd_heading  <NA>      <heading [h4]>
    #>  6 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>
    #>  7 Exercise 2 Solution rmd_chunk    plot-dino <chunk [r]>   
    #>  8 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>
    #>  9 Exercise 2 Solution rmd_chunk    cor-dino  <chunk [r]>   
    #> 10 Exercise 3 <NA>     rmd_heading  <NA>      <heading [h3]>
    #> 11 Exercise 3 Solution rmd_heading  <NA>      <heading [h4]>
    #> 12 Exercise 3 Solution rmd_chunk    plot-star <chunk [r]>   
    #> 13 Exercise 3 Solution rmd_chunk    cor-star  <chunk [r]>

    rmd_subset(tbl, sec_refs = c("Exercise *", "Solution"), type = "rmd_chunk")
    #> # A tibble: 10 x 5
    #>    sec_h3     sec_h4   type        label     ast           
    #>    <chr>      <chr>    <chr>       <chr>     <rmd_ast>     
    #>  1 Exercise 1 <NA>     rmd_heading <NA>      <heading [h3]>
    #>  2 Exercise 1 Solution rmd_heading <NA>      <heading [h4]>
    #>  3 Exercise 2 <NA>     rmd_heading <NA>      <heading [h3]>
    #>  4 Exercise 2 Solution rmd_heading <NA>      <heading [h4]>
    #>  5 Exercise 2 Solution rmd_chunk   plot-dino <chunk [r]>   
    #>  6 Exercise 2 Solution rmd_chunk   cor-dino  <chunk [r]>   
    #>  7 Exercise 3 <NA>     rmd_heading <NA>      <heading [h3]>
    #>  8 Exercise 3 Solution rmd_heading <NA>      <heading [h4]>
    #>  9 Exercise 3 Solution rmd_chunk   plot-star <chunk [r]>   
    #> 10 Exercise 3 Solution rmd_chunk   cor-star  <chunk [r]>

As the complete ast is store directly in the `ast` column, we can also
manipulate this tibble using dplyr or similar packages and have these
changes persist. For example we can use the `rmd_node_length` function
to return the number of lines in the various nodes of the ast and add a
new length column to our tibble.

    tbl_lines = tbl %>%
      dplyr::mutate(lines = rmd_node_length(ast))

    tbl_lines
    #> # A tibble: 19 x 6
    #>    sec_h3        sec_h4   type          label         ast            lines
    #>    <chr>         <chr>    <chr>         <chr>         <rmd_ast>      <int>
    #>  1 <NA>          <NA>     rmd_yaml_list <NA>          <yaml>             2
    #>  2 Load packages <NA>     rmd_heading   <NA>          <heading [h3]>    NA
    #>  3 Load packages <NA>     rmd_chunk     load-packages <chunk [r]>        2
    #>  4 Exercise 1    <NA>     rmd_heading   <NA>          <heading [h3]>    NA
    #>  5 Exercise 1    <NA>     rmd_markdown  <NA>          <markdown [2]>     2
    #>  6 Exercise 1    Solution rmd_heading   <NA>          <heading [h4]>    NA
    #>  7 Exercise 1    Solution rmd_markdown  <NA>          <markdown [5]>     5
    #>  8 Exercise 2    <NA>     rmd_heading   <NA>          <heading [h3]>    NA
    #>  9 Exercise 2    <NA>     rmd_markdown  <NA>          <markdown [2]>     2
    #> 10 Exercise 2    Solution rmd_heading   <NA>          <heading [h4]>    NA
    #> 11 Exercise 2    Solution rmd_markdown  <NA>          <markdown [2]>     2
    #> 12 Exercise 2    Solution rmd_chunk     plot-dino     <chunk [r]>        5
    #> 13 Exercise 2    Solution rmd_markdown  <NA>          <markdown [2]>     2
    #> 14 Exercise 2    Solution rmd_chunk     cor-dino      <chunk [r]>        2
    #> 15 Exercise 3    <NA>     rmd_heading   <NA>          <heading [h3]>    NA
    #> 16 Exercise 3    <NA>     rmd_markdown  <NA>          <markdown [2]>     2
    #> 17 Exercise 3    Solution rmd_heading   <NA>          <heading [h4]>    NA
    #> 18 Exercise 3    Solution rmd_chunk     plot-star     <chunk [r]>        5
    #> 19 Exercise 3    Solution rmd_chunk     cor-star      <chunk [r]>        2

Now we can apply a `rmd_subset` to this updated tibble

    rmd_subset(tbl_lines, sec_refs = c("Exercise 2", "Solution"))
    #> # A tibble: 6 x 6
    #>   sec_h3     sec_h4   type         label     ast            lines
    #>   <chr>      <chr>    <chr>        <chr>     <rmd_ast>      <int>
    #> 1 Exercise 2 <NA>     rmd_heading  <NA>      <heading [h3]>    NA
    #> 2 Exercise 2 Solution rmd_heading  <NA>      <heading [h4]>    NA
    #> 3 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>     2
    #> 4 Exercise 2 Solution rmd_chunk    plot-dino <chunk [r]>        5
    #> 5 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>     2
    #> 6 Exercise 2 Solution rmd_chunk    cor-dino  <chunk [r]>        2

and see that our new `lines` column is maintained.

Note that using the `rmd_subset` function is optional here and we can
also accomplish the same task using `dplyr::filter` or any similar
approach

    dplyr::filter(tbl_lines, sec_h3 == "Exercise 2", sec_h4 == "Solution")
    #> # A tibble: 5 x 6
    #>   sec_h3     sec_h4   type         label     ast            lines
    #>   <chr>      <chr>    <chr>        <chr>     <rmd_ast>      <int>
    #> 1 Exercise 2 Solution rmd_heading  <NA>      <heading [h4]>    NA
    #> 2 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>     2
    #> 3 Exercise 2 Solution rmd_chunk    plot-dino <chunk [r]>        5
    #> 4 Exercise 2 Solution rmd_markdown <NA>      <markdown [2]>     2
    #> 5 Exercise 2 Solution rmd_chunk    cor-dino  <chunk [r]>        2

As such, it is possible to mix and match between `parsermd`’s built-in
functions and any of your other prefered data manipulation packages.

One small note of caution is that when converting back to an ast,
`as_ast`, or document, `as_document`, only the structure of the `ast`
column matters so changes made to the section columns, `type` column, or
the `label` column will not affect the output in any way. This is
particularly important when headings are filtered out, as their columns
may still appear in the tibble while they are no longer in the ast - the
`rmd_subset` circumvents this by recalclating these specific columns as
part of the subset process.

    dplyr::filter(tbl, sec_h3 == "Exercise 2", sec_h4 == "Solution", type == "rmd_chunk")
    #> # A tibble: 2 x 5
    #>   sec_h3     sec_h4   type      label     ast        
    #>   <chr>      <chr>    <chr>     <chr>     <rmd_ast>  
    #> 1 Exercise 2 Solution rmd_chunk plot-dino <chunk [r]>
    #> 2 Exercise 2 Solution rmd_chunk cor-dino  <chunk [r]>

<br/>

    dplyr::filter(tbl, sec_h3 == "Exercise 2", sec_h4 == "Solution", type == "rmd_chunk") %>%
      as_document() %>% 
      cat(sep="\n")
    #> ```{rplot-dino, fig.height = 3, fig.width = 6}
    #> dino_data <- datasaurus_dozen %>%
    #>   filter(dataset == "dino")
    #> 
    #> ggplot(data = dino_data, mapping = aes(x = x, y = y)) +
    #>   geom_point()
    #> ```
    #> 
    #> ```{rcor-dino}
    #> dino_data %>%
    #>   summarize(r = cor(x, y))
    #> ```

<br/>

    rmd_subset(tbl, sec_refs = c("Exercise 2", "Solution"), type_refs = "rmd_chunk") %>%
      as_document() %>% 
      cat(sep="\n")
    #> ### Exercise 2
    #> 
    #> #### Solution
    #> 
    #> ```{rplot-dino, fig.height = 3, fig.width = 6}
    #> dino_data <- datasaurus_dozen %>%
    #>   filter(dataset == "dino")
    #> 
    #> ggplot(data = dino_data, mapping = aes(x = x, y = y)) +
    #>   geom_point()
    #> ```
    #> 
    #> ```{rcor-dino}
    #> dino_data %>%
    #>   summarize(r = cor(x, y))
    #> ```
