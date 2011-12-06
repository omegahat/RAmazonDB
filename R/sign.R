
StringToSign =
function(header, path = "/", auth = getOption("AmazonAWS"), verb = "GET", host = "sdb.amazonaws.com",
          time = AWSDate(), useHTTPS = FALSE)
{
  if(is.null(auth))
     stop("No (NULL) authorization. Set the AmazonAWS R option.")
  
   header['Timestamp'] = time
   header['SignatureVersion'] = 2
   header['SignatureMethod'] = 'HmacSHA256'
   header['Version'] = '2007-11-07'  # 2009-04-15'
   header['AWSAccessKeyId'] = names(auth)
   
   o = order(names(header))
   header = header[o]

   i = match('AWSAccessKeyId', names(header))
   
   header = structure(awsEncode(header), names = names(header))    # Was awsEncode() not encodeSig()

   sig = sprintf("%s\n%s%s\n%s\nAWSAccessKeyId=%s&%s",
                   verb,
                   tolower(host),
                   if(useHTTPS) ':443' else '',
                   path,
                   names(auth),
                   paste(names(header[-i]), header[-i], sep = "=", collapse = '&')
                )
   tmp = signString(sig, auth)
   header['Signature'] =  encodeSig(tmp)  # curlEscape(tmp)

   header
}


characterEncoding =
  c('%' = '%25',
    '&' = '%26',
    ',' = '%2C',
    '=' = '%3D',
    '+' = '%2B',
    '$' = '%24',
#    '/' = '%2F',
    '?' = '%3F',
    '#' = '%23',
    '[' = '%5B',
    ']' = '%5D',
    "=" = "%3D",
    '"' = "%22",
    '@' = "%40",
    '!' = "%21",
    '*' = "%2A",
    "'" = "%27",
    "(" = "%28",
    ")" = "%29",    
    ";" = "%3B",
    " " = "%20",
    ">" = "%3E",
    "<" = "%3C",                
    ":" = "%3A")
  

awsEncode =
function(x, encoding = characterEncoding[c(":", " ", "'", ">", ",")], useTable = TRUE)
{
if(useTable) {  
 
  for(i in names(encoding)) 
     x = gsub(i, encoding[i], x, fixed = TRUE)

} else {
  x = gsub(":", "%3A", x)
  x = gsub(" ", "%20", x)
  x = gsub("'", "%27", x)
  x = gsub(">", "%3E", x)
  x = gsub("<", "%3C", x)
  x = gsub(',', '%2C', x)
}
  x
}


encodeSig =
  #
  # quote the contents/characters of the signature
  #
function(val, m = characterEncoding)
{
 if(TRUE) {
    l = strsplit(val, "") # [[1]]
    sapply(l, function(x) {
                i = match(x, names(m))
                x[ !is.na(i) ] = m[ i[!is.na(i)] ]
                paste(x, collapse = "")
              })
 } else {
    for(i in names(m))
        val = gsub(i, m[i], val, fixed = TRUE)
     val    
 }
 
}


signString =
  # tmp = "GET\nsdb.amazonaws.com:443\n/\nAWSAccessKeyId=AKIAJIIXP355JMT6HQEA&Action=ListDomains&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2009-09-20T19%3A28%3A26&Version=2007-11-07"
  # signString(tmp, 'tb...')
function(str, key, base64 = TRUE, python = TRUE)
{
   python.exe = getOption("python")
   if(is.null(python.exe))
      python.exe = "perl"
  
   if(is.character(python)) {
     python.exe = python
     python = TRUE
   }
  
 
      # for python, write the string to a temporary file and then call sha256.py
    f = tempfile()
    cat(str, file = f)
    script = system.file("sha256.py", package = "RAmazonDB")
    return(system(sprintf("%s %s '%s' '%s'", python.exe, script, key, f), intern = TRUE))
}
