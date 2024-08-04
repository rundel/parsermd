fenced_div_depth = function(x) {
  checkmate::assert_class(x, "rmd_fenced_div")

  if (length(x$content) == 0)
    return(1)

  max(purrr::map_int(
    x$content,
    function(y) {
      if (inherits(y, "rmd_fenced_div")) {
        fenced_div_depth(y)
      } else {
        0
      }
    }
  )) + 1
}

