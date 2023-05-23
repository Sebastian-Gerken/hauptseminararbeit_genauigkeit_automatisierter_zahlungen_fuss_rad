setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min/valid_test_TUDcam")
library(tidyverse)
df1 <- read_delim("Nord-00_05_00-08_00_00-08_15_00.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

df2 <- read_delim("validate_Nord-00_05_00-08_00_00-08_15_00.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

df3 <- read_delim("cfboff_Nord-00_05_00-08_00_00-08_15_00.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

df1  == df2

df3 ==  df1

#Das ist gut weil mein python skript funktioniert aber schlecht weil die Daten schlecht sind!