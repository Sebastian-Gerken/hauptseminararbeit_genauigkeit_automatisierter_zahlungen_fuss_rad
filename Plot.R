library(tidyverse)
library(reshape2)
library(data.table)

df_gt <- read_csv("data/gt_data/TUDCam01_FR20_2022_09_20_08-00-00.csv")
df_eval <- read_csv("data/otv_data/TUDCam01_FR20_2022-09-20_08-00-00_events.csv")


df_count <- as.data.table(empty)
df_gt$Class
ggplot(data = df_gt[df_gt$Class == "Person",  ]) +
  geom_point(aes(X,Y)) +
  scale_x_continuous(limits = c(0, 799), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 599), expand = c(0, 0))


bins_count = 10
df_eval[df_eval$Class == "",]

ggplot(df_eval[ df_eval$Class == "person",] , aes(X, Y)) +
  geom_density2d() +
  scale_x_continuous(limits = c(0, 799), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 599), expand = c(0, 0)) +
  theme_classic()

plt_eval <- ggplot(df_eval, aes(X, Y)) +
  stat_bin2d(bins = bins_count)

diff <- plt_eval$data$c - plt_gt$data

ggplot(plt_eval$data, aes(X, Y)) +
  geom_tile(aes(fill = diff), colour = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white")



