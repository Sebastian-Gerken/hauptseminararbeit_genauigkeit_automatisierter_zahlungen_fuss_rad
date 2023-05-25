#Skript zum Visualisieren der Schnittpunkte

library(tidyverse)
setwd()
T  <- 900 #T in Sekunden!!!
t <- NULL
for (i in 1:(T)){
  if ((T) %% i == 0){
    t <- c(t,  i)
  }
}
s_i <- function(T, t){
  s <- (T / t) - 1
  return(s)
}

s <- mapply(s_i, T, t)

ggplot() +
  geom_line(aes(x = t,y = s)) +
  #geom_point(aes(x = t,  y= s)) +
  xlab("Intervalllänge t in s") +
  ylab("Anzahl an Schnittpunkten n") +
  theme_classic()
ggsave("schnittpunkte.pdf", device = "pdf")

plot(x = t, y = s,   xlab = "Intervalllänge in s", ylab = "Anzahl an Schnittpunkten")
