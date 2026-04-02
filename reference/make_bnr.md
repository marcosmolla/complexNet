# Generating a Pb, Pn, Pr network

This function takes adj.matrix (ADJM), probabilities to connect to
parent(s), neighbours, and randoms (PB, PN, PR), the index of the parent
(if NULL, default, NPARENT number of individuals are randomly chosen as
parent), number of parents (NPARENT, default is 1).

## Usage

``` r
make_bnr(n, np, pb, pn, pr)

# S4 method for class 'numeric,numeric,numeric,numeric,numeric'
make_bnr(n, np, pb, pn, pr)

# S4 method for class 'numeric,numeric,missing,numeric,numeric'
make_bnr(n, np, pb, pn, pr)
```

## Arguments

- n:

  Number of vertices (population size)

- np:

  numeric vector setting ids for the newborn (i.e. which individual will
  be replaced with a new one) and a parent(s). Length 2 or 3. If you
  want to randomly select an id for the newborn (first value) and
  parents (second and third value), simply use c(0,0) or c(0,0,0).

- pb:

  Probability to connect to parent (default is 1)

- pn:

  Probability to connect to neighbour of parent(s)

- pr:

  Probability to connect to individuals that are not connected to the
  parent

## Value

Returns an unweighted (binary) adjacency matrix, where each cell
represents the presence (1) or absence (0) of an interaction between the
row and the column individual.

## Details

It is important to note that, although all three parameters (PB, PN, PR)
are probabilities, i.e. values between 0 and 1, the same value (say 0.2)
means something different for each of them. This is because, PB is the
probability to connect to the parent(s), i.e. 1 or two individuals. In
contrast, PN and PR are the probabilities to connect to neighbours of
the parent(s) or to random other individuals. In the case of a small
social neighbourhood of the parent(s) a PR of 0.2 would mean to connect
to a large amount of individuals in the remaining network. Therefore, it
is important to keep in mind that the value of both (or all three)
values is important and not the individual one in isolation.

## Examples

``` r
make_bnr(n = 10, np = c(0,0), pb = 1, pn = .2, pr = .01)
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    0    0    0    0    0    0    0    0     1
#>  [2,]    0    0    0    0    0    1    1    0    0     1
#>  [3,]    0    0    0    1    0    0    0    0    0     0
#>  [4,]    0    0    1    0    0    0    0    0    0     0
#>  [5,]    0    0    0    0    0    0    0    1    0     0
#>  [6,]    0    1    0    0    0    0    0    0    0     0
#>  [7,]    0    1    0    0    0    0    0    0    0     0
#>  [8,]    0    0    0    0    1    0    0    0    0     0
#>  [9,]    0    0    0    0    0    0    0    0    0     1
#> [10,]    1    1    0    0    0    0    0    0    1     0
```
