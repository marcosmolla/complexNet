# Dynamic network updating, takes adj.matrix (ADJM), probabilities to connecto to parent(s), neighbours, and randoms (PB, PN, PR), the index of the parent (if NULL, default, NPARENT number of individuals are randomly choosen as parent), number of parents (NPARENT, default is 1)


#' Dynamic networks updating for Pb, Pn, Pr networks
#'
#' `make_bnr()` returns an adjacency matrix.
#'
#' This function will ...
#'
#' @param n Number of vertices (population size)
#' @param pb Probability to connect to parent (default is 1)
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' the parent
#' @param singleparent Logical. If TRUE the focal individual connects to one
#' parent with probability pb. If FALSE the individual connects to two parents
#' each with probability pb. Default is TRUE.
#' @return Function returns an adjacncy-matrix.
#' @examples
#' make_bnr(n = 100, pb = 1, pn = .2, pr = .01, singleparent = TRUE)
#' @export

setGeneric("make_bnr", function(n, pb, pn, pr, singleparent) {standardGeneric("make_bnr")})
setMethod(f="make_bnr",
          signature=c(n = "numeric",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric",
                      singleparent = "logical"),
          definition = function(n, pb, pn, pr, singleparent){

           adjm <- init_graph(n = n, deg = 4) # initiate graph
           for(I in 1:(10*n)){
            adjm <- iterate_bnr(adjm, singleparent, pb, pn, pr) # iterate
           }
           return(adjm)
          })

setMethod(f="make_bnr",
          signature=c(n = "numeric", pb = "missing", pn = "numeric", pr = "numeric", singleparent = "logical"),
          definition = function(n, pb, pn, pr, singleparent){
           warning("Using default value pb = 1.")
           make_bnr(n = n, pb = 1, pn = pn, pr = pr, singleparent = singleparent)
          })

setMethod(f="make_bnr",
          signature=c(n = "numeric", pb = "numeric", pn = "numeric", pr = "numeric", singleparent = "missing"),
          definition = function(n, pb, pn, pr, singleparent){
           warning("Using default value singleparent = TRUE.")
           make_bnr(n = n, pb = pb, pn = pn, pr = pr, singleparent = TRUE)
          })

setMethod(f="make_bnr",
          signature=c(n = "numeric", pb = "missing", pn = "numeric", pr = "numeric", singleparent = "missing"),
          definition = function(n, pb, pn, pr, singleparent){
           warning("Using default value pb = 1, and singleparent = TRUE.")
           make_bnr(n = n, pb = 1, pn = pn, pr = pr, singleparent = TRUE)
          })

# grid <- expand.grid(PN=10^seq(-2,0,.5), PR=10^seq(-4,-2,.5), PB=1)
# par(mfrow=c(5,5), mar=c(1,1,1,1))
# for(r in 1:nrow(grid)){
#  adjm <- make_bnr(n = 100, pb = grid[r, "PB"], pn = grid[r, "PN"], pr = grid[r, "PR"], singleparent = F)
#  net <- as.undirected(graph_from_adjacency_matrix(adjm))
#  plot(net, vertex.label=NA, vertex.size=3, main=paste("pn =", round(grid[r, "PN"],3), "and pr =", round(grid[r, "PR"], 4)))
# }
