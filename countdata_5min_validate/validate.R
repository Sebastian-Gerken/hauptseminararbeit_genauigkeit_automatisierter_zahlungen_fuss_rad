setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min_validate")
library(readr)
df1 <- read_delim("1count_TUDCam01_2022-09-20_08-00-00/Nord-00_05_00-08_00_00-08_15_00.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

df2 <- read_delim("count_TUDCam01_2022-09-20_08-00-00/Nord-00_05_00-08_00_00-08_15_00.csv", 
                                              delim = ";", escape_double = FALSE, trim_ws = TRUE)
df1 == df2
