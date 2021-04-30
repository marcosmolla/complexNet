#' @title
#' Expected average degree of BNR networks
#' @description
#' Calculates the expected average degree of a BNR network (single parent only) based on the approximation by Ilany and Akcay, 2016 (see details).
#'
#' @param n Number of nodes in the network
#' @param pb Probability to connect to parent (default is 1)
#' @param pn Probability to connect to neighbour of parent(s)
#' @param pr Probability to connect to individuals that are not connected to
#' @examples
#' # Expected degree
#' avg_degree_bnr(n = 100, pb = 1, pn = .2, pr = .02)
#' # Compare to simulated network with identical parameters
#' adjm <- make_bnr(n = 100, np = c(0,0), pb = 1, pn = .2, pr = .02)
#' mean(adjm) * 100
#' @details The expected average degree \eqn{\bar{d}} is calculated as \deqn{ \bar{d} = \frac{(N-1)(p_b + (N-2)p_r)}{N-1-(N-2)(p_n - p_r)} }
#' @return Returns the expected average degree of a BNR network as a numeric value. This value is an analytic result and not a numeric approximation (compare examples below).
#' @references Ilany, A., and Akçay, E. (2016). Personality and Social Networks: A Generative Model Approach. Integrative and Comparative Biology, 56(6), 1197–1205. \doi{10.1093/icb/icw068}
#' @rdname avg_degree_bnr
#' @export
setGeneric("avg_degree_bnr", function(n, pb, pn, pr) {standardGeneric("avg_degree_bnr")})

#' @rdname avg_degree_bnr
setMethod(f="avg_degree_bnr",
          signature=c(n = "numeric",
                      pb = "numeric",
                      pn = "numeric",
                      pr = "numeric"),
          definition = function(n, pb, pn, pr){
           d <- ((n-1)*(pb+(n-2)*pr)) / (n-1-(n-2)*(pn-pr))
           return(d)
          })
