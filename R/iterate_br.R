setGeneric("iterate_br", function(adjm, singleparent, pb, pr) {standardGeneric("iterate_br")})
setMethod(f="iterate_br",
          signature=c(adjm = "matrix",
                      singleparent = "logical",
                      pb = "numeric",
                      pr = "numeric"),
          definition = function(adjm, singleparent, pb, pr){

           size <- nrow(adjm)
           if(singleparent){
            np <- sample(size, 2, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, 1 parent
            newconn <- (1-(runif(size)-pr > 0)) # random connections
            newconn[np[2]] <- (1-(runif(1)-pb > 0)) #connect to parent
            adjm[,np[1]] <- newconn #replace the dead individual with the newborn
            adjm[np[1],] <- newconn #same
            adjm[np[1],np[1]] <- 0 #set self-link equal to zero
           } else {
            npp <- sample(size, 3, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, and 2 parents
            newconn <- (1-(runif(size)-pr > 0)) #random connections
            newconn[npp[2:3]] <- (1-(runif(2)-pb > 0)) #connect to parents
            adjm[,npp[1]] <- newconn #replace the dead individual with the newborn
            adjm[npp[1],] <- newconn #same
            adjm[npp[1],npp[1]] <- 0 #set self-link equal to zero
           }

           return(adjm)
          })

# adjm <- make_br(size = 100, pb = 1, pr = .01, singleparent = F)
# # adjm2 <- iterate_br(adjm = adjm, singleparent = F, pb = 1, pr = .2); image(adjm-adjm2)
# net <- as.undirected(graph_from_adjacency_matrix(adjm))
# plot(net, vertex.label=NA, vertex.size=3)
