library(tidyverse)
setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung")
T  <- 900 #T in seconds!!!
t <- NULL
##loops all seconds and tests if the 
for (i in 1:(T)){
  if ((T) %% i == 0){
    t <- c(t,  i)
  }
}

#sepciali


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

#read files
df <- read_delim("Saarbruecken_gt2gt_eval2022-10-17_13-15-00_processed/person/FG1_person.csv", 
                 delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ","), 
                 trim_ws = TRUE)
t_2 <- c(10, 20, 30, 50, 60,  90, 100, 150, 180, 300, 450, 900)

df$s_i <- mapply(s_i,T, t_2)
#plot(x = t_2, y = s,   xlab = "Intervall in s", ylab = "Anzahl an Schnittpunkt")

ggplot(data = df, aes(x = s_i, y = S)) +
  geom_point() + 
  stat_smooth(method = "lm", formula = y ~ poly(x, 2), se = F, color = "black") +
  theme_bw() +
  ggtitle("Sensitivity vs. points of failiure") +
  ylab("sensitivity")+
  xlab("Number of points of failiure")


##linear model
# Fit the model
model_lm <- lm(S ~ s_i, data = df)
# Summarize the model
summary(model_lm)

#logistical model
model_glm <- glm(S ~ s_i, data = df, family = poisson)


newdata <- data.frame(
  s_i = seq(min(df$s_i),
  max(df$s_i),
  length.out = 100))
newdata$S <- predict(model, newdata, type = "response")

ggplot() +
  geom_line(data = newdata, aes(x = s_i , y = S), color = "red") +
  geom_point(data = df, aes(x = s_i, y = S), alpha = 0.5) +
  labs(x = "Independent Variable 1", y = "Predicted Probability of Dependent Variable", title = "Logistic Regression Plot")

ks.test(df$S, df$s_i, "pexp")

