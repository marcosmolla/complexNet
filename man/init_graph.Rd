% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/init_graph.R
\name{init_graph}
\alias{init_graph}
\alias{init_graph,numeric,numeric-method}
\title{Initialising a random graph}
\usage{
init_graph(n, deg)

\S4method{init_graph}{numeric,numeric}(n, deg)
}
\arguments{
\item{n}{Number of nodes in the network}

\item{deg}{Average degree in the network}
}
\value{
Returns an unweighted (binary) adjacency matrix, where each cell represents the presence (1) or absence (0) of an interaction between the row and the column individual.
}
\description{
init_graph takes number of nodes (n) and average degree (deg) to generate a random graph.
}
\examples{
init_graph(n = 10, deg = 4)
}
