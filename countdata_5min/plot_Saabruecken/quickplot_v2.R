library(tidyverse)
library(reshape2)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min/plot")
# Read and preprocess the data
files <- list.files()
all_dfs <- list()

for (file in files) {
  if (!grepl(pattern = ".csv", file)) {
    next
  }
  
  df <- read_csv2(file)
  all_dfs[[file]] <- df
} #wow genius

combined_df <- bind_rows(all_dfs, .id = "source")
classes <- unique(combined_df$Class)

# Plot the data
for (class in classes) {
  df_melt <- melt(combined_df[combined_df$Class == class, ], 
                  id.vars = c("source", "t_start", "t_end", "Class"))
  
  ggplot(data = df_melt, aes(x = t_start, y = value, linetype = variable)) +
    geom_line() +
    scale_x_continuous(
      "Time",
      breaks = function(x) {
        c(min(df_melt$t_start), max(df_melt$t_start[df_melt$t_end == "t1_end"]),
          min(df_melt$t_start[df_melt$t_end == "t2_end"]), max(df_melt$t_start))
      },
      labels = function(x) {
        x
      }
    ) +
    theme_bw() +
    labs(title = paste("Time Series Plot for Class:", class))
}
