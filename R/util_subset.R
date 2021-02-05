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


node_subset = function(secs, names, types, sec_ref, type_ref, name_ref, inc_parents) {
  subset = TRUE
  parent_nodes = FALSE

  if (!is.null(sec_ref)) {
    regex = utils::glob2rx(sec_ref)
    matching = purrr::map_lgl(secs, subset_match, regex = regex)

    if (any(matching) & inc_parents)
      parent_nodes = (parent_match(secs, regex) & types == "rmd_heading")

    subset = subset & matching
  }

  if (!is.null(type_ref))
    subset = subset & (types %in% type_ref)

  if (!is.null(name_ref))
    subset = subset & grepl(utils::glob2rx(name_ref), names)

  subset | parent_nodes
}


comb_subset = function(ast, sec_refs = NULL, type_refs = NULL, name_refs = NULL,
                       inc_parents = !is.null(sec_refs), combine = NULL) {

  checkmate::check_class(ast, "rmd_ast")
  checkmate::check_function(combine, null.ok = TRUE)

  if (!is.list(sec_refs))
    sec_refs = list(sec_refs)

  if (is.null(type_refs)) # so the map2 below works correctly
    type_refs = list(NULL)

  if (is.null(name_refs)) # so the map2 below works correctly
    name_refs = list(NULL)

  subset = purrr::pmap(
    list(sec_refs, type_refs, name_refs),
    node_subset,
    secs = rmd_node_sections(ast, drop_na = TRUE),
    types = rmd_node_type(ast),
    names = rmd_node_label(ast),
    inc_parents = inc_parents
  )

  if (!is.null(combine))
    subset = purrr::reduce(subset, combine)

  subset
}
