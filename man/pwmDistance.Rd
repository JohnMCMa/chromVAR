% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pwm_dist.R
\name{pwmDistance}
\alias{pwmDistance}
\title{pwmDistance}
\usage{
pwmDistance(x, y = NULL, min_overlap = 5)
}
\arguments{
\item{x}{list of pwms or pfms, see Details}

\item{y}{list of pwms or pfms, see Details}

\item{min_overlap}{minimum number of basepairs overlapping between motifs}
}
\value{
a list with three matrices- 'dist' has the distance between each
 pair of motifs, 'strand' has the strand of the motif for the match, and 
 'offset' has the offset between the motifs.
}
\description{
computes distance between every pwm in a list or between pwms in one list
with pwms in another
}
\details{
The format of x and y should be a 
\code{\link[TFBSTools]{PWMatrixList}} 
or \code{\link[TFBSTools]{PFMatrixList}} or a list of matrices with rows 
corresponding to "A","C","G","T" and columns summing to 1.
}
\examples{

motifs <- getJasparMotifs()
library(TFBSTools)
pwm_dists <- pwmDistance(toPWM(motifs[[1]]), toPWM(motifs[[2]]))
}
