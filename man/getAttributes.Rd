\name{getAttributes}
\Rdversion{1.1}
\alias{putAttributes}
\alias{getAttributes}
\alias{deleteAttributes}
\title{set, query or remove items and attributes in an AmazonDB domain}
\description{
  These functions allow us to populate and manage data within an
  AmazonDB domain.
  \code{putAttributes} allows us to put named elements in a vector
  as attributes of an item in an AmazonDB domain.
  The idea is that we have an R object which is a list or vector
  with named components. We map these elements to attributes
  within an item in the database.
  
  At present, the values are converted to strings.
  There is no support for numbers, etc.
  We will build this in later as a higher-level layer
  with the database tables having their own meta-data
  giving the R types.
  
}
\usage{
getAttributes(domain, name, auth = getOption("AmazonAWS"),
               .opts = getDefaultS3CurlOptions())
putAttributes(domain, ..., name = names(.objs)[1],
               auth = getOption("AmazonAWS"),
               .objs = list(...),
                .opts = getDefaultS3CurlOptions())
}
\arguments{
  \item{domain}{the domain in which the operations act}
  \item{name}{the name of the item being manipulated.}
  \item{auth}{the authorization key and identifier for the operation.}
  \item{\dots}{\code{name = object} pairs which are mapped to
    items int the AmazonDB domain.  }
  \item{.objs}{an alternative way to specify the collection of R objects
       to upload. This allows them to be specified as a single object, a list.}
  \item{.opts}{a list of options passed to
    \code{\link[RCurl]{curlPerform}} to control how the HTTP request is performed.}
}
\value{
  getAttributes returns a vector or list of the values
  for the different attributes within the name.
  This is typically a character vector.
}
\references{
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

