select =
  #
  # x = select("SELECT mpg FROM dtl_mtcars WHERE cyl > 4")
  #
function(cmd, auth = getOption("AmazonAWS"), 
         .opts = getDefaultS3CurlOptions())
{  
  args = c(Action = "Select",
           SelectExpression = cmd)

  txt = makeRequest(args,  auth, .opts = .opts)

  getItemsFromResponse(txt)

#  readAttributeFromXML(txt)
}

getItemsFromResponse =
function(txt)
{
  if(length(txt) == 0)
     stop("No response")
  
  if(is.character(txt))
     txt = xmlParse(txt)

  top = xmlRoot(txt)[[1]]


  d = xmlApply(top, itemValues)
  ids = names(d) = xmlApply(top, function(x) xmlValue(x[["Name"]]))


  as.data.frame(do.call("rbind", d))
}

itemValues =
function(x)
{
  structure(sapply(xmlChildren(x)[-1],
                    function(x)
                       xmlValue(x[["Value"]])),
            names = sapply(xmlChildren(x)[-1],
                            function(x)
                              xmlValue(x[["Name"]])))
}
