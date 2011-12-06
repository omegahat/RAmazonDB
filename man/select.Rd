\name{select}
\Rdversion{1.1}
\alias{select}
\title{Perform a database query}
\description{
  This function (will) allows an R user to perform an
  SQL-based query on an AmazonDB domain,
  e.g. \code{SELECT x, y FROM domain WHERE z > '2'}.
}
\usage{
select(cmd, auth = getOption("AmazonAWS"), .opts = getDefaultS3CurlOptions())
}
\arguments{
  \item{cmd}{the SELECT command}
  \item{auth}{the AWS authorization key and identifier for the AWS request}
  \item{.opts}{ a list of options passed to
    \code{\link[RCurl]{curlPerform}}   that controls the HTTP request in the REST operation.}
}
\value{
  This returns a data frame corresponding to the
  attributes that are selected. The values are factors.
}
\references{
  \url{http://docs.amazonwebservices.com/AmazonSimpleDB/latest/DeveloperGuide/}
}
\author{
Duncan Temple Lang
}

\seealso{

}
\examples{
}

\keyword{programming}
\keyword{data}

