setGeneric("iterate_bnr", function(adjm, singleparent, pb, pn, pr) {standardGeneric("iterate_bnr")})
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix",
                      singleparent = "logical",
                      pb = "numeric",
                      pr = "numeric"),
          definition = function(adjm, singleparent, pb, pn, pr){


           REQUIRED NP or NPP argument to be handed over !!!

           size <- nrow(adjm)
           if(singleparent){
            np <- sample(size, 2, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, 1 parent
            inherit <- adjm[,np[2]]*(1-(runif(size)-pn > 0)) # socially inherited connections
            randconn <- (1 - adjm[,np[2]])*(1-(runif(size)-pr > 0)) # random connections
            newconn <- inherit + randconn #total connections
            newconn[np[2]] <- (1-(runif(1)-pb > 0)) #connect to parent
            adjm[,np[1]] <- newconn #replace the dead individual with the newborn
            adjm[np[1],] <- newconn #same
            adjm[np[1],np[1]] <- 0 #set self-link equal to zero
           } else {
            npp <- sample(size, 3, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, and 2 parents
            pp <- (adjm[,npp[2]] | adjm[,npp[3]])*1 #parental connections
            inherit <- pp*(1-(runif(size)-pn > 0)) #socially inherited connections
            randconn <- (1 - pp)*(1-(runif(size)-pr > 0)) #random connections
            newconn <- inherit + randconn #total connections
            newconn[npp[2:3]] <- (1-(runif(2)-pb > 0)) #connect to parents
            adjm[,npp[1]] <- newconn #replace the dead individual with the newborn
            adjm[npp[1],] <- newconn #same
            adjm[npp[1],npp[1]] <- 0 #set self-link equal to zero
           }

           return(adjm)
          })

# adjm <- make_bnr(size = 100, pb = 1, pn = .2, pr = .001, singleparent = F)
# # adjm2 <- iterate_bnr(adjm = adjm, singleparent = F, pb = 1, pn = .2, pr = .001); image(adjm-adjm2)
# net <- as.undirected(graph_from_adjacency_matrix(adjm))
# plot(net, vertex.label=NA, vertex.size=3)
