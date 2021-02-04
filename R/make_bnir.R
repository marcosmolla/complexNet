# setGeneric("make_bnir", function(size, pb, pr, singleparent, niter) {standardGeneric("make_bnir")})
# setMethod(f="make_bnir",
#           signature=c(size = "numeric",
#                       pb = "numeric",
#                       pr = "numeric",
#                       singleparent = "logical",
#                       niter = "numeric"),
#           definition = function(size, pb = 1, pr, singleparent = TRUE, niter){
#            print("This is pbpnpr!")
#            # (1+(n*(i-1))):(n*i)
#           })
#
