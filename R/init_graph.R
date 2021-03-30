#' @title
#' Initialising a random graph
#' @description
#' init_graph takes number of nodes (n) and average degree (deg) to generate a random graph.
#'
#' @param n Number of nodes in the network
#' @param deg Average degree in the network
#' @return Returns an unweighted (binary) adjacency matrix, where each cell represents the presence (1) or absence (0) of an interaction between the row and the column individual.
#' @examples
#' init_graph(n = 10, deg = 4)
#' @rdname init_graph
#' @export
setGeneric("init_graph", function(n, deg) {standardGeneric("init_graph")})

#' @rdname init_graph
setMethod(f="init_graph",
          signature=c(n = "numeric",
                      deg = "numeric"),
          definition = function(n, deg){
           P <- (deg*n)/(n^2) # connection probability
           ADJM <- matrix(0,nrow=n,ncol=n)# Set adjacency matrix
           diag <- lower.tri(ADJM, diag = FALSE) # Select one half of the matrix
           npairs <- sum(diag) # Number of pairs without diagonal (using only one matrix traingle)
           ADJM[diag] <- runif(n = npairs, min = 0, max = 1) <= P;
           ADJM <- ADJM + t(ADJM); # Populate other half of the matrix
           return(ADJM)
          })
