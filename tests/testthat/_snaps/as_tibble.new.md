# as_tibble - minimal.Rmd

    # A tibble: 8 x 5
      sec_h1  sec_h2          type          label ast            
      <chr>   <chr>           <chr>         <chr> <rmd_ast>      
    1 <NA>    <NA>            rmd_yaml_list <NA>  <yaml>         
    2 Setup   <NA>            rmd_heading   <NA>  <heading [h1]> 
    3 Setup   <NA>            rmd_chunk     setup <chunk [r]>    
    4 Content <NA>            rmd_heading   <NA>  <heading [h1]> 
    5 Content R Markdown      rmd_heading   <NA>  <heading [h2]> 
    6 Content R Markdown      rmd_markdown  <NA>  <rmd_mrkd [14]>
    7 Content Including Plots rmd_heading   <NA>  <heading [h2]> 
    8 Content Including Plots rmd_markdown  <NA>  <rmd_mrkd [8]> 

# as_tibble - hw01.Rmd

    # A tibble: 15 x 5
       sec_h3        sec_h4   type          label         ast            
       <chr>         <chr>    <chr>         <chr>         <rmd_ast>      
     1 <NA>          <NA>     rmd_yaml_list <NA>          <yaml>         
     2 Load packages <NA>     rmd_heading   <NA>          <heading [h3]> 
     3 Load packages <NA>     rmd_chunk     load-packages <chunk [r]>    
     4 Exercise 1    <NA>     rmd_heading   <NA>          <heading [h3]> 
     5 Exercise 1    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
     6 Exercise 1    Solution rmd_heading   <NA>          <heading [h4]> 
     7 Exercise 1    Solution rmd_markdown  <NA>          <rmd_mrkd [2]> 
     8 Exercise 2    <NA>     rmd_heading   <NA>          <heading [h3]> 
     9 Exercise 2    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
    10 Exercise 2    Solution rmd_heading   <NA>          <heading [h4]> 
    11 Exercise 2    Solution rmd_markdown  <NA>          <rmd_mrkd [19]>
    12 Exercise 3    <NA>     rmd_heading   <NA>          <heading [h3]> 
    13 Exercise 3    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
    14 Exercise 3    Solution rmd_heading   <NA>          <heading [h4]> 
    15 Exercise 3    Solution rmd_markdown  <NA>          <rmd_mrkd [14]>

# as_tibble - hw01-student.Rmd

    # A tibble: 16 x 5
       sec_h3        sec_h4   type          label         ast            
       <chr>         <chr>    <chr>         <chr>         <rmd_ast>      
     1 <NA>          <NA>     rmd_yaml_list <NA>          <yaml>         
     2 Load packages <NA>     rmd_heading   <NA>          <heading [h3]> 
     3 Load packages <NA>     rmd_chunk     load-packages <chunk [r]>    
     4 Exercise 1    <NA>     rmd_heading   <NA>          <heading [h3]> 
     5 Exercise 1    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
     6 Exercise 1    Solution rmd_heading   <NA>          <heading [h4]> 
     7 Exercise 1    Solution rmd_markdown  <NA>          <rmd_mrkd [5]> 
     8 Exercise 2    <NA>     rmd_heading   <NA>          <heading [h3]> 
     9 Exercise 2    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
    10 Exercise 2    Solution rmd_heading   <NA>          <heading [h4]> 
    11 Exercise 2    Solution rmd_markdown  <NA>          <rmd_mrkd [19]>
    12 Exercise 3    <NA>     rmd_heading   <NA>          <heading [h3]> 
    13 Exercise 3    <NA>     rmd_markdown  <NA>          <rmd_mrkd [2]> 
    14 Exercise 3    Solution rmd_heading   <NA>          <heading [h4]> 
    15 Exercise 3    Solution rmd_chunk     plot-star     <chunk [r]>    
    16 Exercise 3    Solution rmd_chunk     cor-star      <chunk [r]>    

# as_tibble - empty_sections.Rmd

    # A tibble: 4 x 5
      sec_h1 sec_h2 type        label ast           
      <chr>  <chr>  <chr>       <chr> <rmd_ast>     
    1 H1-1   <NA>   rmd_heading <NA>  <heading [h1]>
    2 H1-1   H2-1   rmd_heading <NA>  <heading [h2]>
    3 H1-1   H2-2   rmd_heading <NA>  <heading [h2]>
    4 H1-2   <NA>   rmd_heading <NA>  <heading [h1]>

# as_tibble - reverse_sections.Rmd

    # A tibble: 5 x 6
      sec_h1 sec_h2 sec_h3      type          label ast           
      <chr>  <chr>  <chr>       <chr>         <chr> <rmd_ast>     
    1 <NA>   <NA>   <NA>        rmd_yaml_list <NA>  <yaml>        
    2 <NA>   <NA>   H3          rmd_heading   <NA>  <heading [h3]>
    3 <NA>   H2     <NA>        rmd_heading   <NA>  <heading [h2]>
    4 <NA>   H2     H3 - Part 2 rmd_heading   <NA>  <heading [h3]>
    5 H1     <NA>   <NA>        rmd_heading   <NA>  <heading [h1]>

