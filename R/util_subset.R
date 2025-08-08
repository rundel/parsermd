#' @export
`[.rmd_ast` = function(x, i, j) {
  if (!missing(j))
    stop("incorrect number of dimensions", call. = FALSE)

  rmd_ast(x@nodes[i])
}

#' @export
`[[.rmd_ast` = function (x, i, j) {
  if (!missing(j))
    stop("incorrect number of dimensions", call. = FALSE)

  x@nodes[[i]]
}

# Vectorized grepl
vec_grepl = function(patterns, x) {
  purrr::map2_lgl(patterns, x, grepl)
}

# Find matching subsets of length(regex) in x
subset_match = function(x, regex, func = any) {
  if (length(x) < length(regex))
    return(FALSE)

  width = length(regex)
  subsets = purrr::map(seq_len(length(x)-width+1),  ~x[.x:(.x+width-1)])
  matches = purrr::map_lgl(subsets, ~ all(vec_grepl(regex, .x)))

  if (!is.null(func))
    func(matches)
  else
    matches
}


# If section is [A, B ,C] then [C] or [B, C] should match
right_side_match = function(x, regex) {
  # When matching parents we only match the right side
  n = length(x)
  m = length(regex)

  if (m > n)
    return(FALSE)

  if (m < n)
    x = x[-seq_len(n-m)]

  all(vec_grepl(patterns = regex, x = x))
}

parent_match = function(secs, regex) {
  if (length(regex) == 0)
    return(FALSE)

  # Generate parent patterns
  # [A, B, C] has possible parents [A,B,C], [A,B], [A]
  subsets = purrr::map(seq_len(length(regex)), ~ regex[1:.x])

  # For each section check if one of the parent patterns match
  purrr::map_lgl(
    secs,
    function(sec) {
      any(
        purrr::map_lgl(subsets, right_side_match, x = sec)
      )
    }
  )
}


