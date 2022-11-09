## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(complexNet)

## -----------------------------------------------------------------------------
# All parameters provided, but random offspring and parent
adjm <- make_bnr(n = 100, np = c(0,0), pb = 1, pn = .2, pr = .01)

# All parameters provided, offspring (here 2) and parent (here 5) id provided as well
adjm <- make_bnr(n = 100, np = c(2,5), pb = 1, pn = .2, pr = .01)

# pb ommitted, replaced by default value
adjm <- make_bnr(n = 100, np = c(0,0), pn = .2, pr = .01)

# Two parent example, with random offspring and parents
adjm <- make_bnr(n = 100, np = c(0,0,0), pb = 1, pn = .2, pr = .01)

