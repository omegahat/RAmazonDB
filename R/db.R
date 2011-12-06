

createDomain =
function(name, key = getOption("AmazonAWS"), ...)
{
  args = c(Action = 'CreateDomain',
           DomainName = name)

  h = StringToSign(args, "/", key)

  .opts = list(ssl.verifypeer = FALSE, followlocation = TRUE, ...)
  if(FALSE) {
     getForm('http://sdb.amazonaws.com', .params = h, .opts = .opts)
   } else {
     uri = 'http://sdb.amazonaws.com'

         # merge into makeRequest()
     args = paste(names(h), h, sep = "=", collapse = "&")
     uri = paste(uri, args, sep = "?")
     txt = getURLContent(uri, .opts = .opts)
     getResponseMetaData(txt)
   }
}

deleteDomain =
function(name, key = getOption("AmazonAWS"), ..., .opts = list(...))
{
  args = c(Action = 'DeleteDomain',
           DomainName = name)

  h = StringToSign(args, "/", key)

  args = paste(names(h), h, sep = "=", collapse = "&")
  uri = paste(uri, args, sep = "?")
  txt = getURLContent(uri, .opts = .opts)
  getResponseMetaData(txt)
}

listDomains =
function(key = getOption("AmazonAWS"), ..., .opts = list(...), time = AWSDate())
{
     uri = 'http://sdb.amazonaws.com'
     args = c(Action = 'ListDomains')
       
     txt = makeRequest(args, key)

     processResultAsVector(txt)
}

existsDomain =
function(name, key = getOption("AmazonAWS"), domains = listDomains(key))
  name %in% key

domainMetadata =
function(name, key = getOption("AmazonAWS"), ..., .opts = list(...), time = AWSDate())
{
     uri = 'http://sdb.amazonaws.com'
     args = c(Action = 'DomainMetadata',
              DomainName = name)
       
     txt = makeRequest(args, key)

     doc = xmlParse(txt)
     xmlToList(xmlRoot(doc)[[1]])
}


processResultAsVector =
function(txt, nodeName = "ListDomainsResult")
{
   doc = xmlParse(txt)
   node = xmlRoot(doc)[[nodeName]]
   xmlSApply(node, xmlValue)
}

getResponseMetaData =
function(doc)
{
  if(is.character(doc))
     doc = xmlParse(doc, asText = TRUE)
  
  node = xmlRoot(doc)[["ResponseMetadata"]]
  xmlToList(node)
}





