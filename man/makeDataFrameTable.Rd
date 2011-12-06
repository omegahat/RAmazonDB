\name{makeDataFrameTable}
\Rdversion{1.1}
\alias{makeDataFrameTable}
\title{Upload rows of a data frame as items in an AmazonDB domain}
\description{
 This function maps rows/observations in a data frame to 
}
\usage{
makeDataFrameTable(data, domain, auth = getOption("AmazonAWS"), ids = rownames(data))
}

\arguments{
  \item{data}{the data frame to upload}
  \item{domain}{the domain in which to insert the new items}
  \item{auth}{the authorization for the request. See \code{\link{createDomain}}.}
  \item{ids}{names for the new items in the AmazonDB domain. These
    default to the row names. But this parameter allows one to specify
    different values, or to easily prefix the row names.}
}
\value{

}
\references{
  \url{http://docs.amazonwebservices.com/AmazonSimpleDB/latest/DeveloperGuide/}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{createDomain}}
  \code{\link{existsDomain}}
}
\examples{
\dontrun{
  makeDataFrameTable(mtcars, 'dtl_mtcars')
}
}

\keyword{programming}

