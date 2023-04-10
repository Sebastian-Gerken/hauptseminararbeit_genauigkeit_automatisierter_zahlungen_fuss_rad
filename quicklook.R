library(tidyverse)
library(chron)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung")

dir_path <- "export/FG1/"
filenames <- list.files(path = dir_path)

df_intervall
strsplit(filenames[1], split = "_")

for  (i in 1:length(filenames)){
  key <- unlist(strsplit(filenames[i], split = "_"))
  h <- as.numeric(gsub("i", "", key[2]))
  m <- as.numeric(key[3])
  s <- as.numeric(unlist(strsplit(key[4], split = "-"))[1])
  interval <-  times(sprintf("%02d:%02d:%02d", h, m, s))
  
  df <- read_delim( file.path(dir_path, filenames[i]) )
  df <- df[df$Class == "person",]
  df <- mutate(df, S = rp / (rp + fn))
  df <- mutate(df, G = rp / (rp + fp))
  df <- cbind(df, t_int = interval)
  if (i == 1){
    df2 <- df
    next
  }
  df2 <- rbind(df2, df)
  
}

plot(x = 1:nrow(df2), df2$S)
