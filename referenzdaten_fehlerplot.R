#Skript liest outputdaten von auswertung.ipynb ein
#und
library(tidyverse)
library(gridExtra)
setwd("./auswertung_output")
rm(list = ls())
dirlist <- list.dirs()
dirlist <- subset(dirlist, grepl("Saarbruecken", dirlist))
dirlist2 <- subset(dirlist, grepl("count", dirlist))
dirlist3 <- subset(dirlist, grepl("gtval", dirlist))

for (dir in dirlist2){

  filelist <- list.files(path = dir, pattern = ".csv")
  #
  for (file in filelist){
    name <- str_split_1(file, pattern = "-")
    time <- name[3]
    dir2 <- subset(dirlist3, grepl(gsub("_", "-", time), dirlist3))
    filelist2 <- list.files(path = dir2, pattern = ".csv")
    file2 <- subset(filelist2, grepl(file, filelist2))
    #
    df1 <- read_csv2(file.path(dir, file))
    df2 <- read_csv2(file.path(dir2, file2))
    df1$gt <- as.numeric(df1$gt)
    df2$gt <- as.numeric(df2$gt)
    df_difference <- data.frame(
      "Zählquerschnitt" = name[1],
      "Zeit" = gsub("_", ":", time),
      "Referenz" = sum(df1$gt),
      "Referenz_alternativ" = sum(df2$gt),
      "Differenz" = sum(df1$gt) - sum(df2$gt),
      "Differenz_relativ" = 1 - abs(sum(df2$gt) / sum(df1$gt))
    )
    #
    if (exists("df_summary")){
      df_summary <- rbind(df_summary, df_difference)
    } else {
      df_summary <-  df_difference
    }
  }
}

df_summary$Differenz_relativ <- round(df_summary$Differenz_relativ, 2)
df_summary$Zeit
view(df_summary)

pdf("tb_referezfehler.pdf", width = 8, height = 4)
grid.table(df_summary)
dev.off()