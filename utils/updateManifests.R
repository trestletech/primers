# Make sure our library is current
renv::restore()

files <- list.files()
files <- files[files != "renv"]

allRMDs <- list.files(files, "*.Rmd", recursive=TRUE, ignore.case=TRUE, full.names=TRUE)
allDirs <- unique(dirname(allRMDs))

wd <- getwd()
on.exit({ setwd(wd) }, add=TRUE)

i <- 0
lapply(allDirs, function(dir){
  i <<- i + 1
  print(dir)
  cat(i, " of ", length(allDirs), "\n")
  setwd(dir)
  Sys.sleep(5)
  tryCatch({
    rsconnect::writeManifest()
  }, error = function(e){
    print("ERROR")
    print(e)
  })
  setwd(wd)
})
