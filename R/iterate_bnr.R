#' @title Iterating a bnr network
#'
#' @param adjm Adjacency matrix
#' @param np numeric vector setting ids for the newborn (i.e. which individual will be replaced with a new one) and a parent(s). Length 2 or 3. If you want to randomly select an id for the newborn (first value) and parents (second and third value), simply use c(0,0) or c(0,0,0). For one parent, the focal individual connects to this parent with probability pb. For two parent values, the individual connects to two parents each with probability pb.
#' @param pb Probability to connect to parent. Default is 1.
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' the parent
#' @return Returns an iterated version of the supplied adjacency matrix as a numeric matrix.
#' @details If you just want to iterate the graph you can use \code{np=c(0,0)} or \code{np=c(0,0,0)}. However, the function does not return the ids of the newborn and the parent(s). If you want to keep track of the ids that are changed, you should provide these as an input to the function.
#' @examples
#' # Set up linking parameters:
#' pb <- 1
#' pn <- 0.2
#' pr <- 0.01
#' # Generate a network based on these parameters
#' adjm_t0 <- make_bnr(n = 100, np=c(0,0), pb = pb, pn = pn, pr = pr)
#' # Iterate the network
#' adjm_t1 <- iterate_bnr(adjm = adjm_t0, np=c(0,0), pb = pb, pn = pn, pr = pr)
#' @rdname iterate_bnr
#' @export
setGeneric("iterate_bnr", function(adjm, np, pb, pn, pr) {standardGeneric("iterate_bnr")})

#' @rdname iterate_bnr
setMethod(f="iterate_bnr",
          signature=c(adjm = "matrix",
                      np = "numeric",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric"),
          definition = function(adjm, np, pb, pn, pr){

          if(!length(np)%in%c(2,3))
           stop("np must be a numeric vector of length 2, or 3. see ?iterate_bnr")

           n <- nrow(adjm)

           if(sum(np)==0){
            # choose random ids for offspring and parent
            if(length(np)==2){
              # sample a death and a birth, without replacement; 1 newborn, 1 parent
              np <- sample(n, 2, replace = FALSE)
             }
            if(length(np)==3){
             # sample a death and a birth, without replacement; 1 newborn, and 2 parents
             np <- sample(n, 3, replace = FALSE)
            }
           }

           if(length(np)==2){
            inherit <- adjm[,np[2]]*(1-(runif(n)-pn > 0)) # socially inherited connections
            randconn <- (1 - adjm[,np[2]])*(1-(runif(n)-pr > 0)) # random connections
            newconn <- inherit + randconn # total connections
            newconn[np[2]] <- (1-(runif(1)-pb > 0)) # connect to parent
           } else {
            pp <- (adjm[,np[2]] | adjm[,np[3]])*1 # parental connections
            inherit <- pp*(1-(runif(n)-pn > 0)) # socially inherited connections
            randconn <- (1 - pp)*(1-(runif(n)-pr > 0)) # random connections
            newconn <- inherit + randconn # total connections
            newconn[np[2:3]] <- (1-(runif(2)-pb > 0)) # connect to parents
           }
            adjm[,np[1]] <- newconn # replace the dead individual with the newborn
            adjm[np[1],] <- newconn # same
            adjm[np[1],np[1]] <- 0 # set self-link equal to zero

           return(adjm)
          })

