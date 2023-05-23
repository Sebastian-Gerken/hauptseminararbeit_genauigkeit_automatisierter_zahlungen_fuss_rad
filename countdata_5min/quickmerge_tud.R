library(tidyverse)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min")

folderlist <- list.dirs()
for (fi_index in 1:2){
  
  for (fo_index in 5:7){
    folder1 <- folderlist[fo_index]
    #folder2 <- folderlist[fo_index + 6]
    
    files1 <- list.files(folder1)
    #files2 <- list.files(folder2)
    
    file1 <- files1[fi_index]
    #file2 <- files2[fi_index]
    
    filedata1 <- str_split_1(file1, "-")
    #filedata2 <- str_split_1(file2, "-")
    #  if(filedata1[[1]] != filedata2[1]){
    #    stop("Files are not equal!")
    #  }
    
    df1 <- read_csv2(
      file.path(folder1, file1)
    )
    df1$...1 <- NULL
    df1$gt <- as.integer(df1$gt)
    df1$eval <- as.integer(df1$eval)
    
    #df2<- read_csv2(
    #  file.path(folder2, file2)
    #)
    #df2$...1 <- NULL
    #df2$gt <- as.integer(df2$gt)
    #df2$eval <- as.integer(df2$eval)
    #colnames(df2)[2:3] <- c("gt_o", "gt_s")
    
    #df_merged <- full_join(df1, df2, by = c("Class", "t_start", "t_end"))
    df_merged <- df1
    df_merged[is.na(df_merged)] <- 0
    
    if(fo_index == 5){
      data <- df_merged
    } else {
      data <- rbind.data.frame(data,df_merged)
    }

  }
  data <- data %>% arrange(t_start)
  write_csv2(data, paste0(filedata1[1], ".csv"))
}
