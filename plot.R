#Skript zum Plotten der Ergebnisse
library(tidyverse)
library(reshape2)
library(lubridate)
library(knitr)
library(gridExtra)
library(writexl)
library(magrittr)
#<<< Hier zu bearbeitenden Ordner auswählen >>>
setwd("./auswertung_output/plot_saarbruecken")
# Read and preprocess the data
files <- list.files(pattern = ".csv")
all_dfs <- list()
count_csv <- 0

for (file in files) {
  df <- read_csv2(file)
  all_dfs[[file]] <- df
  rm(df)
  count_csv <- count_csv + 1
}

combined_df <- bind_rows(all_dfs, .id = "source")

# Set the gap size between the two time intervals
gap_size <- 5 * 3600  # 5 minutes
#transform valuenames
translate <- c("gt" = "Referenz",
               "eval" = "Detektor",
               "gt_o" = "Referenz 1. Zählung",
               "gt_s" = "Referenz alternativ"  )

metastats <- data.frame("Zählstelle" = NULL,
                        "Klasse"  = NULL,
                        "Referenz" = NULL,
                        "Detektor" = NULL,
                        "mAE" = NULL,
                        "mSE" = NULL)

classes <- unique(combined_df$Class)
gates <- unique(combined_df$source)

if (count_csv == 4){
  #Einstellung Saarbruecken
  timelable <- c("13:15", "13:20", "13:25", "18:30", "18:35", "18:40", "18:45", "18:50", "18:55", "19:00")
  pcol = c("#C76158", "#346399", "#4FD1B1", "#69BD67")
  p2col = c("#C76158", "#4FD1B1", "#69BD67")
  df_relative <- combined_df %>%
  mutate(
    Detektor = (eval - gt) / gt,
    "Referenz 1. Zählung" = (gt_o - gt) / gt,
    "Referenz alternativ" = (gt_s - gt) / gt,
    t_end = NULL,
    gt_o = NULL,
    gt_s = NULL,
    eval = NULL
  )
} else {
  #Einstellung 
  timelable <- c("08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30", "08:35", "08:40", "08:45")
  pcol = c("#C76158", "#346399")
  p2col = c("#C76158")
  df_relative <- combined_df %>%
    mutate(
      Detektor = (eval - gt) / gt,
      t_end = NULL,
      gt_o = NULL,
      gt_s = NULL,
      eval = NULL
    )
}

# Plot the data
for (class in classes) {
  df_melt <- melt(combined_df[combined_df$Class == class, ], 
                  id.vars = c("source", "t_start", "t_end", "Class"))
  
  df_melt <- df_melt %>%
    mutate(t_start = as.POSIXct(t_start, format = "%Y-%m-%d %H:%M:%S"),
           t_end = as.POSIXct(t_start, format = "%Y-%m-%d %H:%M:%S"),
           adjusted_time = ifelse(t_start < as.POSIXct("1970-01-01 15:00:00"),
                                  t_start + gap_size, t_start))
  df_melt <- df_melt %>%
    mutate(adjusted_time = as.POSIXct(adjusted_time, origin = "1970-01-01", tz = "UTC"))
  
  df_melt$variable <- ifelse( df_melt$variable %in% names(translate),
                              translate[df_melt$variable], NA)
  
  #2. Tablle
  df_rel_melt <- melt(df_relative[df_relative$Class  == class,], id.vars =  c("source","gt", "t_start", "Class"))
  
  gates <- unique(df_melt$source)
  
  df_rel_melt <- df_rel_melt %>%
    mutate(t_start = as.POSIXct(t_start, format = "%Y-%m-%d %H:%M:%S"),
           adjusted_time = ifelse(t_start < as.POSIXct("1970-01-01 15:00:00"),
                                  t_start + gap_size, t_start))
  df_rel_melt <- df_rel_melt %>%
    mutate(adjusted_time = as.POSIXct(adjusted_time, origin = "1970-01-01", tz = "UTC"))
  
  for (gate in gates) {
    gatename <- gsub(".csv", "",  gate)
    
    dir.create(gatename, recursive = TRUE, showWarnings = FALSE)
    
    #metastats Befüllung
    df_meta_subset <- combined_df[combined_df$Class == class  & combined_df$source == gate,]
    
    if (count_csv == 4){
      #Einstellungen Saarbrücken
      df_meta_subset <- df_meta_subset %>%
        mutate(
          error_abs = abs(gt - eval),
          error_sqr = (gt - eval)^2,
          gt_o_error_abs = abs(gt - gt_o),
          gt_o_error_sqr = (gt - gt_o)^2,
          gt_s_error_abs = abs(gt - gt_s),
          gt_s_error_sqr = (gt - gt_s)^2
        )
      df_meta_fill <- data.frame(
        "Zählquerschnitt" = gatename,
        "Klasse"  = class,
        "Referenz" = sum(df_meta_subset$gt),
        "Detektor" = sum(df_meta_subset$eval),
        "ori.Zählung" = sum(df_meta_subset$gt_o),
        "alt.Zählung" = sum(df_meta_subset$gt_s),
        "mAE" = sum(df_meta_subset$error_abs) / nrow(df_meta_subset),
        "mSE" = sum(df_meta_subset$error_sqr) / nrow(df_meta_subset),
        "mAE_Referenz_1.Zählung" = sum(df_meta_subset$gt_o_error_abs) / nrow(df_meta_subset),
        "mSE_Referenz_1.Zählung" = sum(df_meta_subset$gt_o_error_sqr) / nrow(df_meta_subset),
        "mAE_Referenz_alternativ" = sum(df_meta_subset$gt_s_error_abs) / nrow(df_meta_subset),
        "mSE_Referenz_alternativ" = sum(df_meta_subset$gt_s_error_sqr) / nrow(df_meta_subset)
      )

    } else {
      #Einstellungen Augustusbruecke
      df_meta_subset <- df_meta_subset %>%
        mutate(
          error_abs = abs(gt - eval),
          error_sqr = (gt - eval)^2
        )
      df_meta_fill <- data.frame(
        "Zählstelle" = gatename,
        "Klasse"  = class,
        "Referenz" = sum(df_meta_subset$gt),
        "Detektor" = sum(df_meta_subset$eval),
        "mAE" = sum(df_meta_subset$error_abs) / nrow(df_meta_subset),
        "mSE" = sum(df_meta_subset$error_sqr) / nrow(df_meta_subset)
      )
    }

    if (exists("metastats")){
      metastats <- rbind(metastats, df_meta_fill)
    } else {
      metastats <-  df_meta_fill
    }

    if (max(df_melt[df_melt$source == gate, "value"]) < 10){
      next
    }
    
    t_break_1 <- min(df_melt$adjusted_time) + 60 * 12.5
    t_break_2 <- t_break_1 + 15 * 60
      
    p <- ggplot(data = df_melt[df_melt$source == gate, ], aes(x = adjusted_time, y = value)) +
      geom_line(aes(linetype = variable, color = variable), size = 0.75) +
      geom_point(aes(shape = variable, color = variable), shape = 0, size = 2) +
      scale_x_datetime(
        "Zeit [hh:mm]",
        date_breaks = "5 min",
        labels = timelable,
        minor_breaks = NULL,
      ) +
      scale_y_continuous(
        paste("Anzahl:", class),
        limits  = c(0, NA)
      ) +
      geom_vline(xintercept =  c(t_break_1, t_break_2), linetype = 2, color = "#999999" ) +
      guides(shape = FALSE, linetype = FALSE) + # Legenden für shape und linetype entfernen
      scale_color_manual(values = pcol , name = "") + # Name der Legende auf "" setzen
      scale_linetype_manual(values = c(4, 1,  2, 2)) +
      theme_light() +
      theme(legend.position = "bottom", legend.justification = "center", legend.box = "horizontal")
    
    
    ggsave(paste0(gatename, "/", gatename, "_", class, "_abs", ".pdf"),device = "pdf", width = 6, height = 5)
    ggsave(paste0(gatename, "/", gatename, "_", class, "_abs", ".jpg"),device = "jpg", width = 6, height = 5)
    
    # 2. plot
    df_rel_melt_subset <- df_rel_melt[df_rel_melt$source == gate, ]
    #minmax y range calculation
    minmax <- max(abs(df_rel_melt_subset$value))
    minmax_step <- 0.1
    minmax <- ceiling(minmax / minmax_step) * minmax_step
    
    p2 <- ggplot(data = df_rel_melt_subset , aes( x = adjusted_time, y = value )) +
      geom_line(aes(linetype = variable, color = variable), size = 0.75) +
      geom_point(aes(shape = variable, color = variable), shape = 0, size = 2) +
      scale_x_datetime(
        "Zeit [hh:mm]",
        date_breaks = "5 min",
        labels = timelable,
        minor_breaks = NULL,
      ) +
      scale_y_continuous(
        paste("Relative Abweichung:", class),
        n.breaks = 10,
        limits = c( minmax * -1, minmax),
        minor_breaks = NULL,
        ) +
      geom_vline(xintercept =  c(t_break_1, t_break_2), linetype = 2, color = "#999999" ) +
      geom_hline(yintercept = 0, linetype = 1) +
      guides(shape = FALSE, linetype = FALSE) +
      scale_color_manual(values = p2col, name = "") +
      theme_light() +
      theme(legend.position = "bottom", legend.justification = "center", legend.box = "horizontal")
    
    ggsave(paste0(gatename, "/", gatename, "_", class, "_rel", ".pdf"),device = "pdf", width = 6, height = 5)
    ggsave(paste0(gatename, "/", gatename, "_", class, "_rel", ".jpg"),device = "jpg", width = 6, height = 5)
    
    print(paste(gate, class))
  }
}

metastats <- metastats %>%
  mutate(
    Referenz = as.numeric(Referenz), # convert Referenz to numeric if it's not already numeric
    Detektor = as.numeric(Detektor), # convert Detektor to numeric if it's not already numeric
    mSE = as.numeric(mSE), # convert Detektor to numeric if it's not already numeric
    "mSE/Referenz" = ifelse( !is.na(Referenz) & Referenz != 0, mSE / Referenz, NA ) ,
    Accuracy = ifelse(!is.na(Referenz) & Referenz != 0, (1 - abs((Referenz - Detektor) / Referenz) ) * 100, NA),
    
  )





metastats <- metastats %>% 
  mutate_if(is.numeric, ~ round(., digits = 2))



custom_theme <- ttheme_minimal(
  core = list(fg_params = list(hjust = 0, x = 0.05, just = "left"),
              bg_params = list(fill = c("grey95", "grey90"), just = "left", col = "grey100")),
  colhead = list(fg_params = list(hjust = 0, x = 0.05, just = "center"),
                 bg_params = list(fill = "grey80", col = "grey100")),
  rowhead = list(fg_params = list(hjust = 0, x = 0, just = "left"))
)




for (class in classes){

  metasubset <- metastats[metastats$Klasse == class,]
  if (count_csv == 4){
    metasubset <- metasubset %>% select(-mAE_Referenz_1.Zählung, 
                                        -mSE_Referenz_1.Zählung, 
                                        -mAE_Referenz_alternativ, 
                                        -mSE_Referenz_alternativ,
                                        -ori.Zählung,
                                        -alt.Zählung)
  }

  metasubset <- metasubset %>%
    mutate(across(where(is.numeric), ~format(., decimal.mark = ",")))

  pdf(paste0("stats_",class ,".pdf"), width = 7.6, height = 1.6)
  grid.table(metasubset, theme = custom_theme, rows = NULL)
  dev.off()

}

metastats <- metastats %>%
  mutate(
    "ori.Acc" =  ifelse(!is.na(Referenz) & Referenz != 0, (1 - abs((Referenz - ori.Zählung) / Referenz) ) * 100, NA),
    "alt.Acc" =  ifelse(!is.na(Referenz) & Referenz != 0, (1 - abs((Referenz - alt.Zählung) / Referenz) ) * 100, NA)
  )


#metastats <- metastats %>%
#  mutate(across(where(is.numeric), ~format(., decimal.mark = ",")))

meta_gouped <- metastats %>%
  group_by(Klasse) %>%
  summarise(
    mAE_Det = weighted.mean(mAE, Referenz),
    "mSE/Det" = weighted.mean(`mSE/Referenz`, Referenz),
    "mSE" = weighted.mean(mSE, Referenz),
    Referenz = sum(Referenz),
    Detektor = sum(Detektor),
    ori.Zählung = sum(ori.Zählung),
    alt.Zählung = sum(alt.Zählung),
    
  )



pdf("metastats.pdf", width = 16, height = 6)
grid.table(metastats)
dev.off()