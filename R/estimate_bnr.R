estimate_bnr <- function(size, avg_degree, avg_path, transitivity, avg_cluste_size){
 # pre-calculate
 return(TRUE)
}
estimate_bnr(size = 100, avg_degree = 5, avg_path = 3, transitivity = .2, avg_cluste_size = 100)

# maybe call it reverse_lookup or
library(igraph)
grid <- expand.grid(N = 100, PB = seq(0,1,.1), PR = seq(0,1,.1))
do.call("rbind",
lapply(1:nrow(grid), function(i){
 adjm <- make_br(size = grid[i,"N"], pb = grid[i,"PB"], pr = grid[i,"PR"], singleparent = TRUE)
 net <- graph_from_adjacency_matrix(adjm)
 data.frame(
  pb = grid[i,"PB"],
  pr = grid[i,"PR"],
  size = grid[i,"N"],
  degree = mean(degree(net)),
  path = average.path.length(net),
  transitivity = transitivity(net)
 )
})) -> res

head(res)
res[is.nan(res$path),"path"] <- 0
res[is.nan(res$transitivity),"transitivity"] <- 0
head(res)

# 101: given N = 100, degree = 177, path = 1.103, transitivity = 0.896
# what was pb pr?


aim <- c(100, 177.48, 1.103, 0.896)
sub <- apply(res, 1, function(x){
 sum(abs(x[-c(1,2)] - aim))
})
which.min(sub)


unlist(lapply(1:nrow(res), function(j){
aim <- res[j, -c(1,2)] + c(0, 0.001*sample(c(1,-1), size =3, replace = T))
sub <- apply(res, 1, function(x){
 sum(abs(x[-c(1,2)] - aim))
})
which.min(sub) == j}))


