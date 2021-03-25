#' Iterating a bnr network
#'
#' @param adjm Adjacency matrix
#' @param singleparent Logical. If TRUE the focal individual connects to one
#' parent with probability pb. If FALSE the individual connects to two parents
#' each with probability pb. Default is TRUE.
#' @param pb Probability to connect to parent. Default is 1.
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' the parent
#' @return Returns an iterated version of the supplied adjacency matrix.
#' @examples
#' 1+1
#' @rdname iterate_bnr
#' @export
setGeneric("iterate_bnr", function(adjm, singleparent, pb, pn, pr) {standardGeneric("iterate_bnr")})

#' @rdname iterate_bnr
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix",
                      singleparent = "logical",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric"),
          definition = function(adjm, singleparent, pb, pn, pr){


           # REQUIRED NP or NPP argument to be handed over !!!

           n <- nrow(adjm)
           if(singleparent){
            np <- sample(n, 2, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, 1 parent
            inherit <- adjm[,np[2]]*(1-(runif(n)-pn > 0)) # socially inherited connections
            randconn <- (1 - adjm[,np[2]])*(1-(runif(n)-pr > 0)) # random connections
            newconn <- inherit + randconn #total connections
            newconn[np[2]] <- (1-(runif(1)-pb > 0)) #connect to parent
            adjm[,np[1]] <- newconn #replace the dead individual with the newborn
            adjm[np[1],] <- newconn #same
            adjm[np[1],np[1]] <- 0 #set self-link equal to zero
           } else {
            npp <- sample(n, 3, replace = FALSE) #sample a death and a birth, without replacement; 1 newborn, and 2 parents
            pp <- (adjm[,npp[2]] | adjm[,npp[3]])*1 #parental connections
            inherit <- pp*(1-(runif(n)-pn > 0)) #socially inherited connections
            randconn <- (1 - pp)*(1-(runif(n)-pr > 0)) #random connections
            newconn <- inherit + randconn #total connections
            newconn[npp[2:3]] <- (1-(runif(2)-pb > 0)) #connect to parents
            adjm[,npp[1]] <- newconn #replace the dead individual with the newborn
            adjm[npp[1],] <- newconn #same
            adjm[npp[1],npp[1]] <- 0 #set self-link equal to zero
           }

           return(adjm)
          })

#' @rdname iterate_bnr
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix", singleparent = "missing", pb = "numeric", pn = "numeric", pr = "numeric"),
          definition = function(adjm, singleparent, pb, pn, pr){
           iterate_bnr(adjm = adjm, singleparent = TRUE, pb = pb, pn = pn, pr = pr)
          })

#' @rdname iterate_bnr
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix", singleparent = "logical", pb = "missing", pn = "numeric", pr = "numeric"),
          definition = function(adjm, singleparent, pb, pn, pr){
           iterate_bnr(adjm = adjm, singleparent = singleparent, pb = 1, pn = pn, pr = pr)
          })

#' @rdname iterate_bnr
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix", singleparent = "missing", pb = "missing", pn = "numeric", pr = "numeric"),
          definition = function(adjm, singleparent, pb, pn, pr){
           iterate_bnr(adjm = adjm, singleparent = TRUE, pb = 1, pn = pn, pr = pr)
          })

