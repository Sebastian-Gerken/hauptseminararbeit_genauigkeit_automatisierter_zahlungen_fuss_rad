library(tidyverse)
library(lubridate)

setwd("C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung")

localdirs <- dir()
print(localdirs)
dirnames <- list.dirs(
  localdirs[as.numeric(readline("Choose dirctorynumber: "))]
  )
save_dir <- paste0(dirnames[1], "_processed")
fclasses <- c("person", "bicycle", "car", "truck", "bus")

process_data <- function(df, interval) {
  df <- df %>% 
    mutate(S = rp / (rp + fn),
           G = rp / (rp + fp),
           F1 = 2 * G * S / (G + S),
           t_int = interval)
  return(df)
}

create_plot <- function(data, x_var, y_var, title, x_label, y_label) {
  plot <- ggplot(data, aes_string(x_var, y_var)) +
    geom_point() +
    theme_bw() +
    ggtitle(title) +
    scale_y_continuous(limits = c(0.0, 1)) +
    scale_x_datetime(labels = scales::time_format("%M:%S")) +
    xlab(x_label) +
    ylab(y_label)
  return(plot)
}

for (fclass in fclasses) {
  
  save_path <- file.path(save_dir, fclass)
  dir.create(save_path, showWarnings = FALSE)
  
  for (n in 2:length(dirnames)) {
    gatename <- gsub(paste0(dirnames[1], "/"), "", dirnames[n])
    filenames <- list.files(path = dirnames[n])
    
    df2 <- NULL
    
    for (filename in filenames) {
      key <- unlist(strsplit(filename, split = "-"))[2] %>%
        strsplit("_") %>%
        unlist() %>%
        as.numeric()
      interval <- as.POSIXct(
        sprintf(
          "%02d:%02d:%02d", key[1], key[2], key[3]
          ), format = "%H:%M:%S", tz = "UTC")
      
      df <- read_delim(file.path(dirnames[n], filename), delim = ";") %>%
        filter(Class == fclass) %>%
        process_data(interval)
      
      if (nrow(df) == 0) {
        next
      }
      
      df2 <- rbind(df2, df)
      
      
      if(nrow(df2) == length(filenames)){
        
        sens_plot <- create_plot(df2, "t_int", "S", paste("Sensitivität", gatename, fclass), "Zeitinterval [mm:ss]", "Sensitivität")
        ggsave(paste0(save_path, "/", gatename, "_S_", fclass, ".jpg"), sens_plot, device = "jpg", width = 4, height = 4)
        
        gen_plot <- create_plot(df2, "t_int", "G", paste("Genauigkeit", gatename, fclass), "Zeitinterval [mm:ss]", "Genauigkeit")
        ggsave(paste0(save_path, "/", gatename, "_G_", fclass, ".jpg"), gen_plot, device = "jpg", width = 4, height = 4)
        
        sensgen_plot <- ggplot() +
          geom_path(aes(df2$G, df2$S))
        ggsave(paste0(save_path, "/", gatename, "_S2G_", fclass, ".jpg"), sensgen_plot, device = "jpg", width = 4, height = 4)
        
        write_csv2(df2, paste0(save_path, "/", gatename, "_", fclass, ".csv"))
        
      }
      
    }
    
  }
  
}
