putAttributes =

   # putAttributes("test_dtl3", it = c(foo = "abc", bar = 123))
  
function(domain, ..., name = names(.objs)[1],
         auth = getOption("AmazonAWS"), .objs = list(...),
         .opts = getDefaultS3CurlOptions())
{
  if(length(.objs) > 1) {
    return(mapply(function(id, dom, obj) {
                    putAttributes(dom, obj, name = id, auth = auth, .opts = .opts)
                  }, names(.objs), rep(domain, length = length(.objs)), .objs))
           
  }

  args = c(Action = "PutAttributes",
           DomainName = domain,
           ItemName = name)

  obj = .objs[[1]]
  tmp = mapply(function(i, val, id) {
                 structure(c(id, val), names = paste(sprintf("Attribute.%d", i), c("Name", "Value"), sep = "."))
              },
               seq(along = obj) - 1L, obj, names(obj), SIMPLIFY = FALSE)


  args = c(args, structure(unlist(tmp), names = sapply(tmp, names)))

  txt = makeRequest(args,  auth, 'http://sdb.amazonaws.com', .opts)
  ans = getResponseMetaData(txt)
  name
}


getAttributes =
  #
  # getAttributes("test_dtl3", "it")
  #
function(domain, name, auth = getOption("AmazonAWS"), 
         .opts = getDefaultS3CurlOptions())
{  
  args = c(Action = "GetAttributes",
           DomainName = domain,
           ItemName = name)
  txt = makeRequest(args,  auth, uri = 'http://sdb.amazonaws.com', .opts)  

  readAttributeFromXML(txt)
}

deleteAttributes =
  #
  # deleteAttributes("test_dtl3", 'it')
  #
function(domain, name, ..., .fields = list(...), auth = getOption("AmazonAWS"), 
         .opts = getDefaultS3CurlOptions())
{  
  args = c(Action = "DeleteAttributes",
           DomainName = domain,
           ItemName = name)

  if(length(.fields) == 0) {
     val = getAttributes(domain, name, auth = auth, .opts = .opts)
     .fields = names(val)
  }
  
  ids = sprintf("Attribute.%d.Name", seq(along = .fields) - 1L)
  args[ ids ] = unlist(.fields)

  txt = makeRequest(args,  auth, uri = 'http://sdb.amazonaws.com', .opts)  

  getResponseMetaData(txt)
}





readAttributeFromXML =
function(txt)
{
    if(is.character(txt))
      txt = xmlParse(txt)

    node = xmlRoot(txt)[["GetAttributesResult"]]
    if(xmlSize(node) == 0)
      return(NULL)
    
    structure(xmlSApply(node, function(x) xmlValue(x[["Value"]])),
                  names = xmlSApply(node, function(x) xmlValue(x[["Name"]])))
}

makeRequest =
function(args, key = getOption("AmazonAWS"), uri = 'http://sdb.amazonaws.com', .opts = getDefaultS3CurlOptions())
{
  h = StringToSign(args, "/", key)

  args = paste(names(h), h, sep = "=", collapse = "&")
  uri = paste(uri, args, sep = "?")
  getURLContent(uri, .opts = .opts)
}

getDefaultS3CurlOptions =
function()
{
  list(ssl.verifypeer = FALSE, followlocation = TRUE, 
        httpheader =  "User-Agent: R and RAmazonDB")
}
