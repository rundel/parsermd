test_that("vec_grepl", {
  x = c("ABC", "abc", "123", "@#$")
  patterns = c("[A-Z]+", "[a-z]+", "[0-9]+", "[^A-Za-z0-9]+")

  expect_equal(vec_grepl(patterns, x), c(TRUE, TRUE, TRUE, TRUE))

  expect_equal(vec_grepl(patterns[1], x[1]), TRUE)
  expect_equal(vec_grepl(patterns[1], x), c(TRUE, FALSE, FALSE, FALSE))
  expect_equal(vec_grepl(patterns, x[1]), c(TRUE, FALSE, FALSE, FALSE))

  expect_error(vec_grepl(patterns[1:2], x))
  expect_error(vec_grepl(patterns, x[1:2]))
})
test_that("subset_match", {
  x = c("A", "B", "C")

  expect_true(  subset_match(x, c("A", "B", "C")) )

  expect_true(  subset_match(x, c("A", "B")) )
  expect_true(  subset_match(x, c("B", "C")) )

  expect_false( subset_match(x, c("A", "C")) )
  expect_false( subset_match(x, c("B", "A")) )
  expect_false( subset_match(x, c("C", "A")) )

  expect_true(  subset_match(x, "A") )
  expect_true(  subset_match(x, "B") )
  expect_true(  subset_match(x, "C") )
})

test_that("right_side_match", {
  x = c("A", "B", "C")
  regex = c("A", "B", "C")

  expect_true(right_side_match(x, regex))
  expect_true(right_side_match(x, regex[2:3]))
  expect_true(right_side_match(x, regex[3]))

  expect_false(right_side_match(x, regex[1]))
  expect_false(right_side_match(x, regex[2]))
  expect_false(right_side_match(x, regex[1:2]))
})

test_that("parent_match", {
  secs = list(
    c("A"),
    c("A", "B"),
    c("A", "B", "C")
  )

  regex = c("A", "B", "C")

  expect_equal( parent_match(secs, regex = c("A", "B", "C")), c(TRUE,  TRUE,  TRUE) )
  expect_equal( parent_match(secs, regex = c("B", "C")),      c(FALSE, TRUE,  TRUE) )
  expect_equal( parent_match(secs, regex = c("C")),           c(FALSE, FALSE, TRUE) )

  expect_false( parent_match(secs, regex = character()) )
})
