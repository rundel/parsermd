test_that("rmd_insert basic functionality works", {
  # Create simple test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Insert before first chunk
  new_node = rmd_markdown(lines = "Before chunk")
  result = rmd_insert(original_ast, "test1", nodes = new_node, location = "before")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      new_node,
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert after functionality works", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Insert after first chunk
  new_node = rmd_markdown(lines = "After chunk")
  result = rmd_insert(original_ast, "test1", nodes = new_node, location = "after")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      new_node,
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert works with multiple nodes as list", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1")
    )
  )
  
  # Insert multiple nodes
  new_nodes = list(
    rmd_markdown(lines = "First comment"),
    rmd_markdown(lines = "Second comment")
  )
  result = rmd_insert(original_ast, "test1", nodes = new_nodes, location = "after")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "First comment"),
      rmd_markdown(lines = "Second comment")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert works with rmd_ast as nodes input", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1")
    )
  )
  
  # Insert nodes from another AST
  new_ast = rmd_ast(
    nodes = list(
      rmd_markdown(lines = "From AST 1"),
      rmd_markdown(lines = "From AST 2")
    )
  )
  result = rmd_insert(original_ast, "test1", nodes = new_ast, location = "before")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "From AST 1"),
      rmd_markdown(lines = "From AST 2"),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert works with continuous range selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Insert before first node of range
  new_node = rmd_markdown(lines = "Before range")
  result = rmd_insert(original_ast, "test1":"test2", nodes = new_node, location = "before")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      new_node,
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert after works with continuous range selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Insert after last node of range
  new_node = rmd_markdown(lines = "After range")
  result = rmd_insert(original_ast, "test1":"test2", nodes = new_node, location = "after")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      new_node,
      rmd_markdown(lines = "Some text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert handles empty selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Select chunks that don't exist
  new_node = rmd_markdown(lines = "Should not be inserted")
  result = rmd_insert(original_ast, has_type("rmd_chunk"), nodes = new_node, location = "before")
  
  # Should be unchanged
  expect_equal(result, original_ast)
})

test_that("rmd_insert errors on discontinuous ranges by default", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  new_node = rmd_markdown(lines = "Insert")
  
  # Should provide helpful error message
  expect_snapshot_error(
    rmd_insert(original_ast, has_type("rmd_chunk"), nodes = new_node, location = "before")
  )
})

test_that("rmd_insert allows multiple discontinuous insertions", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text"),
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  new_node = rmd_markdown(lines = "Separator")
  result = rmd_insert(original_ast, has_type("rmd_chunk"), 
                     nodes = new_node, location = "before", allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      new_node,
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text"),
      new_node,
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert handles first position insertion", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Text")
    )
  )
  
  new_node = rmd_yaml(yaml = list(title = "Document"))
  result = rmd_insert(original_ast, 1, nodes = new_node, location = "before")
  
  expected_ast = rmd_ast(
    nodes = list(
      new_node,
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert handles last position insertion", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Text")
    )
  )
  
  new_node = rmd_markdown(lines = "Final comment")
  result = rmd_insert(original_ast, 2, nodes = new_node, location = "after")
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_markdown(lines = "Text"),
      new_node
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert works with type selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_heading(name = "Section", level = 2L),
      rmd_markdown(lines = "Text")
    )
  )
  
  # Note: The two headings form a continuous range, so insertion happens only once
  new_node = rmd_markdown(lines = "Before headings")
  result = rmd_insert(original_ast, has_type("rmd_heading"), 
                     nodes = new_node, location = "before", allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      new_node,
      rmd_heading(name = "Title", level = 1L),
      rmd_heading(name = "Section", level = 2L),
      rmd_markdown(lines = "Text")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert validates nodes argument", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L)
    )
  )
  
  # Invalid nodes type
  expect_snapshot_error(
    rmd_insert(original_ast, 1, nodes = "invalid", location = "before")
  )
  
  # List with invalid node
  expect_snapshot_error(
    rmd_insert(original_ast, 1, nodes = list(rmd_heading(name = "Valid", level = 1L), "invalid"), location = "before")
  )
})

test_that("rmd_insert validates location argument", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L)
    )
  )
  
  new_node = rmd_markdown(lines = "Test")
  
  # Invalid location
  expect_snapshot_error(
    rmd_insert(original_ast, 1, nodes = new_node, location = "invalid")
  )
})

test_that("rmd_insert validates allow_multiple argument", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L)
    )
  )
  
  new_node = rmd_markdown(lines = "Test")
  
  # Invalid allow_multiple
  expect_snapshot_error(
    rmd_insert(original_ast, 1, nodes = new_node, location = "before", allow_multiple = "invalid")
  )
})

test_that("rmd_insert handles unsupported types", {
  expect_snapshot_error(
    rmd_insert("not_rmd_object", nodes = rmd_markdown(lines = "test"), location = "before")
  )
  
  expect_snapshot_error(
    rmd_insert(list(nodes = "invalid"), nodes = rmd_markdown(lines = "test"), location = "before")
  )
})

test_that("normalize_nodes helper function works", {
  # Single node
  single = rmd_markdown(lines = "test")
  expect_equal(normalize_nodes(single), list(single))
  
  # List of nodes
  nodes_list = list(
    rmd_markdown(lines = "test1"),
    rmd_markdown(lines = "test2")
  )
  expect_equal(normalize_nodes(nodes_list), nodes_list)
  
  # rmd_ast object
  ast = rmd_ast(nodes = nodes_list)
  expect_equal(normalize_nodes(ast), nodes_list)
  
  # Invalid input
  expect_snapshot_error(normalize_nodes("invalid"))
  expect_snapshot_error(normalize_nodes(list(rmd_markdown(lines = "valid"), "invalid")))
})

test_that("rmd_insert works with complex discontinuous selection", {
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),       # 1
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"), # 2
      rmd_markdown(lines = "Text 1"),                # 3
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"), # 4
      rmd_markdown(lines = "Text 2"),                # 5
      rmd_chunk(engine = "r", label = "test3", code = "3 + 3")  # 6
    )
  )
  
  # Insert before chunks at positions 2, 4, 6
  new_node = rmd_markdown(lines = "Before chunk")
  result = rmd_insert(original_ast, has_type("rmd_chunk"), 
                     nodes = new_node, location = "before", allow_multiple = TRUE)
  
  expected_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      new_node,
      rmd_chunk(engine = "r", label = "test1", code = "1 + 1"),
      rmd_markdown(lines = "Text 1"),
      new_node,
      rmd_chunk(engine = "r", label = "test2", code = "2 + 2"),
      rmd_markdown(lines = "Text 2"),
      new_node,
      rmd_chunk(engine = "r", label = "test3", code = "3 + 3")
    )
  )
  
  expect_equal(result, expected_ast)
})

test_that("rmd_insert preserves original object structure", {
  # Create test AST
  original_ast = rmd_ast(
    nodes = list(
      rmd_heading(name = "Title", level = 1L),
      rmd_chunk(engine = "r", label = "test", code = "1 + 1"),
      rmd_markdown(lines = "Some text")
    )
  )
  
  # Insert new node
  new_node = rmd_markdown(lines = "Inserted")
  result = rmd_insert(original_ast, "test", nodes = new_node, location = "after")
  
  # Should have one more node
  expect_equal(length(result), length(original_ast) + 1)
  
  # Original nodes should be preserved (except for the insertion)
  expect_equal(result@nodes[[1]], original_ast@nodes[[1]]) # heading
  expect_equal(result@nodes[[2]], original_ast@nodes[[2]]) # chunk
  expect_equal(result@nodes[[3]], new_node)               # inserted
  expect_equal(result@nodes[[4]], original_ast@nodes[[3]]) # markdown
})