# Initialising a random graph

init_graph takes number of nodes (n) and average degree (deg) to
generate a random graph.

## Usage

``` r
init_graph(n, deg)

# S4 method for class 'numeric,numeric'
init_graph(n, deg)
```

## Arguments

- n:

  Number of nodes in the network

- deg:

  Average degree in the network

## Value

Returns an unweighted (binary) adjacency matrix, where each cell
represents the presence (1) or absence (0) of an interaction between the
row and the column individual.

## Examples

``` r
init_graph(n = 10, deg = 4)
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    0    1    1    0    0    1    0    0     1
#>  [2,]    0    0    1    0    0    0    1    0    1     1
#>  [3,]    1    1    0    0    0    1    0    0    0     1
#>  [4,]    1    0    0    0    0    0    1    1    0     1
#>  [5,]    0    0    0    0    0    0    1    0    0     0
#>  [6,]    0    0    1    0    0    0    0    0    0     0
#>  [7,]    1    1    0    1    1    0    0    0    1     0
#>  [8,]    0    0    0    1    0    0    0    0    1     1
#>  [9,]    0    1    0    0    0    0    1    1    0     0
#> [10,]    1    1    1    1    0    0    0    1    0     0
```
