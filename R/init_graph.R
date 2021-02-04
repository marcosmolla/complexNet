# Random Graph Generation, takes number of nodes (size), average degree (deg)
setGeneric("init_graph", function(size, deg) {standardGeneric("init_graph")})
setMethod(f="init_graph",
          signature=c(size = "numeric",
                      deg = "numeric"),
          definition = function(size, deg){
           P <- (deg*size)/(size^2) # connection probability
           ADJM <- matrix(0,nrow=size,ncol=size)# Set adjacency matrix
           diag <- lower.tri(ADJM, diag = FALSE) # Select one half of the matrix
           npairs <- sum(diag) # Number of pairs without diagonal (using only one matrix traingle)
           ADJM[diag] <- runif(n = npairs, min = 0, max = 1) <= P;
           ADJM <- ADJM + t(ADJM); # Populate other half of the matrix
           return(ADJM)
          })
