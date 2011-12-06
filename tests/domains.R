library(RAmazonDBREST)

if(!is.null(getOption("AmazonAWS"))) {

  listDomains()

  createDomain('test_dtl2')
  'test_dtl2' %in% listDomains()
  deleteDomain('test_dtl2')
}

