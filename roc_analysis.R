library(pROC)

set.seed(1234)
actuals <- factor(sample(c(0, 1), 100, replace = TRUE))
scores <- runif(100)

# Berechnen Sie die ROC-Kurve
roc_obj <- roc(actuals, scores)

# Plotten Sie die ROC-Kurve
plot(roc_obj)
