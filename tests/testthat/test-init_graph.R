library(testthat)
library(complexNet)

test_that("init_graph returns symmetric adjacency matrix", {
  # ACT
  adj <- init_graph(n = 10, deg = 4)
  # ASSERT
  expect_true(is.matrix(adj))
  expect_equal(nrow(adj), 10)
  expect_equal(adj, t(adj))
  expect_true(all(adj %in% c(0, 1)))
})
