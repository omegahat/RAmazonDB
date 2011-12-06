library(RAmazonDBREST)

if(!is.null(getOption("AmazonAWS"))) {

  if(!('test_dtl3' %in% listDomains()))
     createDomain('test_dtl3')

  putAttributes("test_dtl3", it = c(foo = "abc", bar = 123))
  getAttributes("test_dtl3", "it")
}


