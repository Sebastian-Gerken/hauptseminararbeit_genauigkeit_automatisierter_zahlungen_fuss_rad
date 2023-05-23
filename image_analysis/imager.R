setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/image_analysis")
library(imager)
library(tidyverse)
library(reshape2)


video <- load.video(file.choose())






filelist <- list.files(pattern = ".png")
all_img <- data.frame()
for (filename in filelist){
  img <- load.image(filename)
  img$value

  all_img$value <-
  all_img$filename <- filename
  
}


img1 <- as.data.frame(img1)
p <- ggplot(data = img1) +
  geom_histogram( aes(x = value), binwidth = 0.1)
print(p)