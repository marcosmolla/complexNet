# Expected average degree of BNR networks

Calculates the expected average degree of a BNR network (single parent
only) based on the approximation by Ilany and Akcay, 2016 (see details).

## Usage

``` r
avg_degree_bnr(n, pb, pn, pr)

# S4 method for class 'numeric,numeric,numeric,numeric'
avg_degree_bnr(n, pb, pn, pr)
```

## Arguments

- n:

  Number of nodes in the network

- pb:

  Probability to connect to parent (default is 1)

- pn:

  Probability to connect to neighbour of parent(s)

- pr:

  Probability to connect to individuals that are not connected to

## Value

Returns the expected average degree of a BNR network as a numeric value.
This value is an analytic result and not a numeric approximation
(compare examples below).

## Details

The expected average degree \\\bar{d}\\ is calculated as \$\$ \bar{d} =
\frac{(N-1)(p_b + (N-2)p_r)}{N-1-(N-2)(p_n - p_r)} \$\$

## References

Ilany, A., and Akçay, E. (2016). Personality and Social Networks: A
Generative Model Approach. Integrative and Comparative Biology, 56(6),
1197–1205. [doi:10.1093/icb/icw068](https://doi.org/10.1093/icb/icw068)

## Examples

``` r
# Expected degree
avg_degree_bnr(n = 100, pb = 1, pn = .2, pr = .02)
#> [1] 3.60177
# Compare to simulated network with identical parameters
adjm <- make_bnr(n = 100, np = c(0,0), pb = 1, pn = .2, pr = .02)
mean(adjm) * 100
#> [1] 3.56
```
