library(tidyverse)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung")
df1 = read_csv2(file.choose())
df2 = read_csv2(file.choose())
df3 = read_csv2(file.choose())


#
T  <- 900 #T in seconds!!!
t <- NULL
t = as.numeric(df1$t_int)
t = t - 1682294400 #bad hack ...
#sepciali
s_i <- function(T, t){
  s <- (T / t) - 1
  return(s)
}
s <- mapply(s_i, T, t)
s = s/T
s = abs(s-1)
####GGF Probleme mit der Normierung von S


matrix = cbind(df1$F1, df2$F1, df3$F1, s)
matrix = cor(matrix)
print(matrix)


ggplot() +
  geom_line(aes(x = df1$t_int, y = df1$F1), color = "red" ) +
  geom_line(aes(x = df2$t_int, y = df2$F1), color = "blue" ) +
  geom_line(aes(x = df3$t_int, y = df3$F1), color = "green" ) +
  geom_line(aes(x = df3$t_int, y = s), color = "black" ) +
  theme_bw() +
  xlab("Zeitintervalle in [hh:mm]") +
  ylab("F1 score und Fehelerpotenzial")

ggsave("Korrelation_Haltelinie_Car.png")

