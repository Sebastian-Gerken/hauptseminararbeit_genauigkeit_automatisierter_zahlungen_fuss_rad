library(tidyverse)
library(reshape2)
library(data.table)

df_gt <- read_csv(file.choose())
df_eval <- read_csv(file.choose())


ggplot(data = df_gt[df_gt$Class == "Person",  ]) +
  #geom_point(aes(X,Y)) +
  #scale_x_continuous(limits = c(0, 799), expand = c(0, 0)) +
  #scale_y_continuous(limits = c(0, 599), expand = c(0, 0)) + 
  geom_raster(aes(X,Y), interpolate = T)


ggplot(df_eval[ df_eval$Class == "person",] , aes(X, Y)) +
  geom_density2d_filled() +
  scale_x_continuous(limits = c(0, 799), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 599), expand = c(0, 0)) +
  theme_classic()

ggplot(df_eval, aes(X, Y)) +
  stat_bin2d(bins = bins_count)

diff <- plt_eval$data$c - plt_gt$data

ggplot(plt_eval$data, aes(X, Y)) +
  geom_tile(aes(fill = diff), colour = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white")



