\name{createDomain}
\Rdversion{1.1}
\alias{createDomain}
\alias{listDomains}
\alias{deleteDomain}
\alias{existsDomain}
\alias{domainMetadata}
\title{Create, delete and list domains in the AmazonDB}
\description{
  These functions allow an R user to create a new
  domain within the AmazonDB; delete an existing
  domain; query what domains the user owns
  and whether a particular one exists;
  retrieve information about a domain, e.g. when it was created, etc.
}
\usage{
createDomain(name, key = getOption("AmazonAWS"), ...)
}
\arguments{
  \item{name}{the name of the domain}
  \item{key}{the private/secret authorization key for Amazon Web
    Services (AWS). This must be a character vector whose value is the
    secret key and whose name is the public identifier for the user.
    This is usually set as an R option named 'AmazonAWS'. (The same key
    can be used for  all Amazon Web Services, 
    but you do have to explicitly sign up for each service. }
  \item{\dots}{additional argments that are passed to
    \code{\link[RCurl]{curlPerform}} controlling how the HTTP request is performed.}
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
}
\examples{

if(!is.null(getOption("AmazonAWS"))) {
listDomains()

createDomain('test_dtl2')
'test_dtl2' %in% listDomains()
existsDomain('test_dtl2')

deleteDomain('test_dtl2')
}
}
\keyword{programming}
\keyword{data}
