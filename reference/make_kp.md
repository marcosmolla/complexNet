# Generating a kp network

This function ...

## Usage

``` r
make_kp(n, np, pb, k, p)

# S4 method for class 'numeric,numeric,numeric,numeric,numeric'
make_kp(n, np, pb, k, p)

# S4 method for class 'numeric,numeric,missing,numeric,numeric'
make_kp(n, np, pb, k, p)
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

- k:

  Degree (number of connections a new individual will form)

- p:

  Maximum proportion of k that will be connections to neighbours of the
  parent. The complimentary k\*(1-p) connections will be formed with
  random other individuals

## Value

Returns an unweighed (binary) adjacency matrix, where each cell
represents the presence (1) or absence (0) of an interaction between the
row and the column individual.

## Details

It is important to note that ... P is a maximum value, say an individual
wants to have 10 connections and P=0.5, i.e. it wants 5 connections to
the neighbours of its parent but the parent only has 4 then it will only
inherit those 4.

## Examples

``` r
make_kp(n = 10, np = c(0,0), pb = 1, k = 4, p = .5)
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    1    1    0    1    0    0    0    1     0
#>  [2,]    1    0    0    1    0    0    1    0    1     1
#>  [3,]    1    0    0    0    1    1    0    1    1     1
#>  [4,]    0    1    0    0    0    1    1    1    1     0
#>  [5,]    1    0    1    0    0    0    1    1    1     0
#>  [6,]    0    0    1    1    0    0    1    1    0     0
#>  [7,]    0    1    0    1    1    1    0    1    0     0
#>  [8,]    0    0    1    1    1    1    1    0    1     0
#>  [9,]    1    1    1    1    1    0    0    1    0     1
#> [10,]    0    1    1    0    0    0    0    0    1     0
```
