# setGeneric("make_br", function(size, pb, pr, singleparent) {standardGeneric("make_br")})
# setMethod(f="make_br",
#           signature=c(size = "numeric",
#                       pb = "numeric",
#                       pr = "numeric",
#                       singleparent = "logical"),
#           definition = function(size, pb, pr, singleparent){
#            # print("This is pbpr!")
#
#            adjm <- init_graph(size = size, deg = 4) # initiate graph
#            for(I in 1:(10*size)){
#              adjm <- iterate_br(adjm, singleparent, pb, pr) # iterate
#            }
#            return(adjm)
#           })
