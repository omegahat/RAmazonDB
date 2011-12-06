\name{RAmazonDB-package}
\Rdversion{1.1}
\alias{RAmazonDB-package}
\alias{RAmazonDB}
\docType{package}
\title{Interface to Amazon's SimpleDB}
\description{
This is an R package that provides an
interface to (some of) Amazon's SimpleDB engine
to create, populate, access and generally manipulate
databases.

The way to use this package is to set the R option \code{AmazonAWS} with
a value that is a named character vector of the form
\code{"aws-id" = "aws key"}.
You can do this in your \code{.Rprofile} file that is read at
startup.  Make certain that it cannot be read by other users
on your system as the key is secret.
}

\details{
\tabular{ll}{
Version: \tab 0.1-0\cr
Package: \tab RAmazonDB\cr
License: \tab BSD\cr
Imports: \tab XML, RCurl\cr
Built: \tab R 2.10.0; ; 2009-09-20 23:40:49 UTC; unix\cr
}

}
\author{
Duncan Temple Lang

Maintainer: Duncan Temple Lang <duncan@r-project.org>
}
\references{
  \url{http://docs.amazonwebservices.com/AmazonSimpleDB/latest/DeveloperGuide/}  
}
\keyword{ package }
\seealso{
 \code{RAmazonS3}
}
\examples{
}