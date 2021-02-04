# Dynamic network updating, takes adj.matrix (ADJM), probabilities to connecto to parent(s), neighbours, and randoms (PB, PN, PR), the index of the parent (if NULL, default, NPARENT number of individuals are randomly choosen as parent), number of parents (NPARENT, default is 1)


#' Dynamic networks updating for Pb, Pn, Pr networks
#'
#' `make_bnr()` returns an adjacency matrix.
#'
#' This function will ...
#'
#' @param size Number of vertices (population size)
#' @param pb Probability to connect to parent
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' the parent
#' @param singleparent Logical. If TRUE the focal individual connects to one
#' parent with probability pb. If FALSE the individual connects to two parents
#' each with probability pb.
#' @return If all inputs are integer and logical, then the output
#'   will be an integer. If integer overflow
#'   (<http://en.wikipedia.org/wiki/Integer_overflow>) occurs, the output
#'   will be NA with a warning. Otherwise it will be a length-one numeric or
#'   complex vector.
#'
#'   Zero-length vectors have sum 0 by definition. See
#'   <http://en.wikipedia.org/wiki/Empty_sum> for more details.
#' @examples
#' make_bnr(size = 100, pb = 1, pn = .2, pr = .001, singleparent = F)
setGeneric("make_bnr", function(size, pb, pn, pr, singleparent) {standardGeneric("make_bnr")})
setMethod(f="make_bnr",
          signature=c(size = "numeric",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric",
                      singleparent = "logical"),
          definition = function(size, pb = 1, pn, pr, singleparent = TRUE){
           print("This is pbpnpr!")

           adjm <- init_graph(size = size, deg = 4) # initiate graph
           for(I in 1:(10*size)){
            adjm <- iterate_bnr(adjm, singleparent, pb, pn, pr) # iterate
           }
           return(adjm)
          })

# grid <- expand.grid(PN=10^seq(-2,0,.5), PR=10^seq(-4,-2,.5), PB=1)
# par(mfrow=c(5,5), mar=c(1,1,1,1))
# for(r in 1:nrow(grid)){
#  adjm <- make_bnr(size = 100, pb = grid[r, "PB"], pn = grid[r, "PN"], pr = grid[r, "PR"], singleparent = F)
#  net <- as.undirected(graph_from_adjacency_matrix(adjm))
#  plot(net, vertex.label=NA, vertex.size=3, main=paste("pn =", round(grid[r, "PN"],3), "and pr =", round(grid[r, "PR"], 4)))
# }
