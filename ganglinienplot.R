#Skriptsammlung zur generierung von Ganglinien
#Diese Skript wurde für die Auswertung nicht verwendet
library(tidyverse)
df_gt <- read_csv("./data/gt_data/Saarbruecken_OTCamera04_FR20_2022-10-17_13-15-00_v5.csv")
df_eval <- read_csv("./data/otv_data/Saarbruecken_OTCamera04_FR20_2022-10-17_13-15-00_events.csv")

df_gt <- df_gt %>% mutate(across(c("SectionID", "Class"), as.factor))
df_eval <- df_eval %>% mutate(across(c("SectionID", "Class"), as.factor))

break_time <- "10 s"
df_gt_count <- df_gt %>%
  group_by(interval = cut(DateTime, breaks = break_time), Class) %>%
  summarise( count = n() )

df_eval_count <- df_eval %>%
  group_by(interval = cut(DateTime, breaks = break_time), Class) %>%
  summarise( count = n() )

df_gt_count_class <- df_gt_count[df_gt_count$Class == "Pkw ohne Anhänger", ]
df_eval_count_class <- df_eval_count[df_eval_count$Class == "car", ]

ggplot() +
  geom_line(data  = df_eval_count_class,aes(x = as.POSIXct(interval), y =count), alpha = 1,fill = "blue",   color = "black", linetype = 4) +
  geom_line(data  = df_gt_count_class,aes(x = as.POSIXct(interval), y =count),alpha = 0.5, fill = "red") +
  coord_cartesian(ylim = c(0, NA)) +
  theme_bw()
