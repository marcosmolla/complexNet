library(testthat)
library(complexNet)

test_that("avg_degree_bnr returns analytic values for sample grid", {
  cases <- expand.grid(n = c(10, 100), pb = c(0, .5, 1), pn = c(0, .5, 1), pr = c(0, .01, .1))
  expected <- with(cases, ((n - 1) * (pb + (n - 2) * pr)) / (n - 1 - (n - 2) * (pn - pr)))
  actual <- mapply(avg_degree_bnr, cases$n, cases$pb, cases$pn, cases$pr)
  expect_equal(actual, expected, tolerance = 1e-8)
})
