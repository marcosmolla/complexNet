#' @title Generating a kp network
#' @description This function ...
#'
#' @details It is important to note that ... P is a maximum value, say an individual wants to have 10 connections and P=0.5, i.e. it wants 5 connections to the neighbours of its parent but the parent only has 4 then it will only inherit those 4.
#' @param n Number of vertices (population size)
#' @param np numeric vector setting ids for the newborn (i.e. which individual will be replaced with a new one) and a parent(s). Length 2 or 3. If you want to randomly select an id for the newborn (first value) and parents (second and third value), simply use c(0,0) or c(0,0,0).
#' @param pb Probability to connect to parent (default is 1)
#' @param k Degree (number of connections a new individual will form)
#' @param p Maximum proportion of k that will be connections to neighbours of the parent. The complimentary k*(1-p) connections will be formed with random other individuals
#' @return Returns an unweighed (binary) adjacency matrix, where each cell represents the presence (1) or absence (0) of an interaction between the row and the column individual.
#' @examples
#' make_kp(n = 10, np = c(0,0), pb = 1, k = 4, p = .5)
#' @importFrom methods setGeneric setMethod
#' @rdname make_kp
#' @export
setGeneric("make_kp", function(n, np, pb, k, p) {standardGeneric("make_kp")})

#' @rdname make_kp
setMethod(f="make_kp",
          signature=c(n  = "numeric",
                      np = "numeric",
                      pb = "numeric",
                      k  = "numeric",
                      p  = "numeric"),
          definition = function(n, np, pb, k, p){

           adjm <- init_graph(n = n, deg = 4) # initiate graph
           for(I in 1:(10*n)){
            adjm <- iterate_kp(adjm, np, pb, k, p) # iterate
           }
           return(adjm)
          })

#' @rdname make_kp
setMethod(f="make_kp",
          signature=c(n = "numeric", np = "numeric", pb = "missing", k = "numeric", p = "numeric"),
          definition = function(n, np, pb, k, p){
           warning("pb not provided. Using default value pb = 1.")
           make_kp(n = n, np = np, pb = 1, k = k, p = p)
          })

# grid <- expand.grid(K=c(4,6,10,18), P=rev(c(0,.75,.85,.95,1)), PB=1)
# par(mfrow=c(5,4), mar=c(1,1,1,1))
# for(r in 1:nrow(grid)){
#  adjm <- make_kp(n = 100, np = c(0,0), pb = grid[r, "PB"], k = grid[r, "K"], p = grid[r, "P"])
#  net <- as.undirected(graph_from_adjacency_matrix(adjm))
#  plot(net, vertex.label=NA, vertex.size=3, main=paste("K =", round(grid[r, "K"],3), "and p =", round(grid[r, "P"], 4)))
# }
