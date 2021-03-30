#' @title Dynamic networks updating for Pb, Pn, Pr networks
#' @description This function takes adj.matrix (ADJM), probabilities to connect to parent(s), neighbours, and randoms (PB, PN, PR), the index of the parent (if NULL, default, NPARENT number of individuals are randomly chosen as parent), number of parents (NPARENT, default is 1).
#'
#' @details It is important to note that, although all three parameters (PB, PN, PR) are probabilities, i.e. values between 0 and 1, the same value (say 0.2) means something different for each of them. This is because, PB is the probability to connect to the parent(s), i.e. 1 or two individuals. In contrast, PN and PR are the probabilities to connect to neighbours of the parent(s) or to random other individuals. In the case of a small social neighbourhood of the parent(s) a PR of 0.2 would mean to connect to a large amount of individuals in the remaining network. Therefore, it is important to keep in mind that the value of both (or all three) values is important and not the individual one in isolation.
#' @param n Number of vertices (population size)
#' @param np numeric vector setting ids for the newborn (i.e. which individual will be replaced with a new one) and a parent(s). Length 2 or 3. If you want to randomly select an id for the newborn (first value) and parents (second and third value), simply use c(0,0) or c(0,0,0).
#' @param pb Probability to connect to parent (default is 1)
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' the parent
#' @return Returns an unweighted (binary) adjacency matrix, where each cell represents the presence (1) or absence (0) of an interaction between the row and the column individual.
#' @examples
#' make_bnr(n = 10, np = c(0,0), pb = 1, pn = .2, pr = .01)
#' @rdname make_bnr
#' @export
setGeneric("make_bnr", function(n, np, pb, pn, pr) {standardGeneric("make_bnr")})

#' @rdname make_bnr
setMethod(f="make_bnr",
          signature=c(n = "numeric",
                      np = "numeric",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric"),
          definition = function(n, np, pb, pn, pr){

           adjm <- init_graph(n = n, deg = 4) # initiate graph
           for(I in 1:(10*n)){
            adjm <- iterate_bnr(adjm, np, pb, pn, pr) # iterate
           }
           return(adjm)
          })

#' @rdname make_bnr
setMethod(f="make_bnr",
          signature=c(n = "numeric", np = "numeric", pb = "missing", pn = "numeric", pr = "numeric"),
          definition = function(n, np, pb, pn, pr){
           warning("pb not provided. Using default value pb = 1.")
           make_bnr(n = n, np = np, pb = 1, pn = pn, pr = pr)
          })

# grid <- expand.grid(PN=10^seq(-2,0,.5), PR=10^seq(-4,-2,.5), PB=1)
# par(mfrow=c(5,5), mar=c(1,1,1,1))
# for(r in 1:nrow(grid)){
#  adjm <- make_bnr(n = 100, pb = grid[r, "PB"], pn = grid[r, "PN"], pr = grid[r, "PR"], singleparent = F)
#  net <- as.undirected(graph_from_adjacency_matrix(adjm))
#  plot(net, vertex.label=NA, vertex.size=3, main=paste("pn =", round(grid[r, "PN"],3), "and pr =", round(grid[r, "PR"], 4)))
# }
