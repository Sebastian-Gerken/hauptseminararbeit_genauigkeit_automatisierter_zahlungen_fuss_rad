setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/countdata_5min_validate")
library(tidyverse)

df_reference <- read_csv("TUDCam01_FR20_2022-09-20_08-00-00_events_2.csv")

df_original <- read_csv("TUDCam01_FR20_2022-09-20_08-00-00_events.csv")

