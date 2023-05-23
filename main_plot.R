library(tidyverse)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung")
mainfolder <- "countdata"
folderlist <- list.dirs(mainfolder)
for (folder in 11:16){
  rm(files)
  files <- list.files(folder)
  
  for(file in files){
    filedata <- strsplit(file, "-")
    gate  <- filedata[1]
    df1 <- read_delim(file.path(folder, file))
    names(df1)[1] <- "gate"
    df1[[gate]] <- gate
  }
}