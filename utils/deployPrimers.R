
source("utils/listPrimers.R", local=TRUE)

wd <- getwd()
on.exit({ setwd(wd) }, add=TRUE)

library(connectapi)

# CONNECT_SERVER and CONNECT_API_KEY must be set as env vars
client <- connect()

i <- 0
lapply(allDirs, function(dir){
  i <<- i + 1
  print(dir)
  cat(i, " of ", length(allDirs), "\n")
  setwd(dir)
  tryCatch({
    bundle <- bundle_dir(".")
    content <- client %>%
      deploy(bundle, name = basename(dir)) %>%
      poll_task() %>%
      set_vanity_url(basename(dir))
  }, error = function(e){
    print("ERROR")
    print(e)
  })
  setwd(wd)
})
