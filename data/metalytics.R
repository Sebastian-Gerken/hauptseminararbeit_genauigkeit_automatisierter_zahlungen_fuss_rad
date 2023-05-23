setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/data")
library(tidyverse)
dirs <- list.dirs()

dir_gt  <-  dirs[2]
dir_eval <- dirs[4]

Referenz <- read_csv(file.choose())

Detektor <- read_csv(file.choose())

print( paste("Referenz: " ,nrow(Referenz)))

print( paste("Detektor: " ,
             nrow(Detektor) - sum(Detektor$Class == "bicycle" | Detektor$Class == "motorcycle" ),
             "Referenz: " ,nrow(Referenz)
             ))
