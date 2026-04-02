# Iterating a bnr network

Iterating a bnr network

## Usage

``` r
iterate_bnr(adjm, np, pb, pn, pr)

# S4 method for class 'matrix,numeric,numeric,numeric,numeric'
iterate_bnr(adjm, np, pb, pn, pr)
```

## Arguments

- adjm:

  Adjacency matrix

- np:

  numeric vector setting ids for the newborn (i.e. which individual will
  be replaced with a new one) and a parent(s). Length 2 or 3. If you
  want to randomly select an id for the newborn (first value) and
  parents (second and third value), simply use c(0,0) or c(0,0,0). For
  one parent, the focal individual connects to this parent with
  probability pb. For two parent values, the individual connects to two
  parents each with probability pb.

- pb:

  Probability to connect to parent. Default is 1.

- pn:

  Probability to connect to neighbour of parent(s)

- pr:

  Probability to connect to individuals that are not connected to the
  parent

## Value

Returns an iterated version of the supplied adjacency matrix as a
numeric matrix.

## Details

If you just want to iterate the graph you can use `np=c(0,0)` or
`np=c(0,0,0)`. However, the function does not return the ids of the
newborn and the parent(s). If you want to keep track of the ids that are
changed, you should provide these as an input to the function.

## Examples

``` r
# Set up linking parameters:
pb <- 1
pn <- 0.2
pr <- 0.01
# Generate a network based on these parameters
adjm_t0 <- make_bnr(n = 100, np=c(0,0), pb = pb, pn = pn, pr = pr)
# Iterate the network
adjm_t1 <- iterate_bnr(adjm = adjm_t0, np=c(0,0), pb = pb, pn = pn, pr = pr)
```
