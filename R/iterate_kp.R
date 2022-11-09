#' @title Iterating a kp network
#'
#' @param adjm Adjacency matrix
#' @param np numeric vector setting ids for the newborn (i.e. which individual will be replaced with a new one) and a parent(s). Length 2 or 3. If you want to randomly select an id for the newborn (first value) and parents (second and third value), simply use c(0,0) or c(0,0,0). For one parent, the focal individual connects to this parent with probability pb. For two parent values, the individual connects to two parents each with probability pb.
#' @param pb Probability to connect to parent. Default is 1.
#' @param k Degree (number of connections a new individual will form)
#' @param p Maximum proportion of k that will be connections to neighbours of the parent. The complimentary k*(1-p) connections will be formed with random other individuals
#' @return Returns an iterated version of the supplied adjacency matrix as a numeric matrix.
#' @details If you just want to iterate the graph you can use \code{np=c(0,0)} or \code{np=c(0,0,0)}. However, the function does not return the ids of the newborn and the parent(s). If you want to keep track of the ids that are changed, you should provide these as an input to the function.
#' @examples
#' # Set up linking parameters:
#' pb <- 1
#' k <- 4
#' p <- 0.2
#' # Generate a network based on these parameters
#' adjm_t0 <- make_kp(n = 100, np=c(0,0), pb = pb, k = k, p = p)
#' # Iterate the network
#' adjm_t1 <- iterate_kp(adjm = adjm_t0, np=c(0,0), pb = pb, k = k, p = p)
#' @importFrom methods setGeneric setMethod
#' @rdname iterate_kp
#' @export
setGeneric("iterate_kp", function(adjm, np, pb, k, p) {standardGeneric("iterate_kp")})

#' @rdname iterate_kp
setMethod(f="iterate_kp",
          signature=c(adjm = "matrix",
                      np = "numeric",
                      pb = "numeric",
                      k = "numeric",
                      p = "numeric"),
          definition = function(adjm, np, pb, k, p){

           if(!length(np)%in%c(2,3))
            stop("np must be a numeric vector of length 2, or 3. see ?iterate_kp")

           if(k<(length(np)-1))
            stop(paste("To run this simulation with ",length(np)-1," parent/s, degree k needs to be at least ",length(np)-1," (currently k = ",k,").",sep=""))

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

           # reset new individual's connections
           adjm[,np[1]] <- 0
           adjm[np[1],] <- 0

           # calcualte number of parents to connect to and find their neighbours
           if(length(np)==2){
            parentNeibs <- which(x = adjm[,np[2]]==1)
            parentconn <- np[2][runif(1)<pb]
           } else {
            parentNeibs <- which((adjm[,np[2]] | adjm[,np[3]]))
            parentconn <- np[2:3][runif(2)<pb]
           }

           # individual forms connections based on goal k minus connections to parent, such that final degree is no larger than k
           K <- k-length(parentconn)
           # number of inherited and random links
           nInherit <- round(K*p)
           nRandom <- ifelse(test = (K-nInherit) > 0,yes = K-nInherit, no = 0)

           nInheritReal <- ifelse(test = nInherit>length(parentNeibs), yes = length(parentNeibs), no = nInherit)
           inherit <- sample(x = parentNeibs, size = nInheritReal, replace = F)

           # select randoms among all individuals that are not np or parental connections
           rands <- (1:n)[-c(np,parentNeibs)]
           nRandomReal <- ifelse(test = nRandom>length(rands), yes = length(rands), no = nRandom)
           randconn <- sample(x = rands, size = nRandomReal, replace = F)

           newconn <- c(inherit, randconn, parentconn) # total connections

           adjm[newconn,np[1]] <- 1 # replace the dead individual with the newborn
           adjm[np[1],newconn] <- 1 # same
           adjm[np[1],np[1]]   <- 0 # set self-link equal to zero

           return(adjm)
          })

