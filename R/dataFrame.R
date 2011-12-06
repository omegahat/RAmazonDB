
makeDataFrameTable = 
# Take a data frame and make an item for each row
  #
  # Use batch put attributes mechanism
  #
function(data, domain, auth = getOption("AmazonAWS"), ids = rownames(data))
{
  if(!existsDomain(domain))
    createDomain(domain, auth)
  
  mapply(function(i, id) {
            putAttributes(domain, name = id, .objs = list(data[i,]), auth = auth)

         }, seq(along = seq_len(nrow(data))), ids)
}
