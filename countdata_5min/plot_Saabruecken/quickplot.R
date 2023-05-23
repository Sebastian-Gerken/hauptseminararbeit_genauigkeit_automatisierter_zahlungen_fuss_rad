library(tidyverse)
library(chron)

setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min/plot")
files <- list.files()
for (file in files){
  if (! grepl(pattern = ".csv", file)){
    break
  }
  df <- read_csv2(file)
  classes <- unique(df$Class)
    for (class in classes) {
      df_melt <- melt(df, id.vars = c("t_start",  "t_end", "Class"))
      
      ggplot(data = df_melt[df_melt["Class"] == class,], aes(x = t_start, y = value, linetype = variable) ) +
        geom_line() +
        scale_x_continuous(
          breaks = c()
        )
        theme_bw()
      
      
    }
}

nrow(df_melt[df_melt$Class == "car", ])
