# Iterating a kp network

Iterating a kp network

## Usage

``` r
iterate_kp(adjm, np, pb, k, p)

# S4 method for class 'matrix,numeric,numeric,numeric,numeric'
iterate_kp(adjm, np, pb, k, p)
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

- k:

  Degree (number of connections a new individual will form)

- p:

  Maximum proportion of k that will be connections to neighbours of the
  parent. The complimentary k\*(1-p) connections will be formed with
  random other individuals

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
k <- 4
p <- 0.2
# Generate a network based on these parameters
adjm_t0 <- make_kp(n = 100, np=c(0,0), pb = pb, k = k, p = p)
# Iterate the network
adjm_t1 <- iterate_kp(adjm = adjm_t0, np=c(0,0), pb = pb, k = k, p = p)
```
