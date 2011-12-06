AWSDate =
function(when = Sys.time()) 
{     # different from RAmazonS3
  format(when, "%Y-%m-%dT%H:%M:%S%Z") # -08:00")
}

userAgent =
function(version = TRUE)
{
   if(is.logical(version))
     version = if(version)
                  R.version.string
               else
                  ""

   sprintf("RAmazonDB, %s", version)
}

