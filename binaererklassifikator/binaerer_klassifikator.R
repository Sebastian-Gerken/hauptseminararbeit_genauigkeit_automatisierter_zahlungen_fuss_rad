#Skript zur Auswertung der Werte des Binären Klassifikators

library(tidyverse)
library(lubridate)

rm(list = ls())

localdirs <- dir("./") #Angabe des Ornders mit den Daten
print(localdirs)
dirnames <- list.dirs( localdirs[as.numeric(readline("Orner Auswählen: "))] )
save_dir <- paste0(dirnames[1], "_processed")
fclasses <- c("person", "bicycle", "car", "truck", "bus")

for (fclass in fclasses){
  
  save_path <- file.path(save_dir, fclass)
  if (dir.exists(save_path)){
    unlink(save_path, recursive = T)
    dir.create(save_path, recursive = T)
  } else {
    dir.create(save_path, recursive = T)
  }
  
  for (n in 2:length(dirnames)){
    #gateloop
    gatename <- gsub(paste0(dirnames[1], "/"), "", dirnames[n])
    filenames <- list.files(path = dirnames[n])
    
    df2 <- NULL # initialize df2
    
    for  (i in 1:length(filenames)){
      #read all csv files into aggregated df
      key <- unlist(strsplit(filenames[i], split = "-"))[2]
      key <- unlist(strsplit(key, "_"))
      h <- as.numeric(key[1])
      m <- as.numeric(key[2])
      s <- as.numeric(key[3])
      interval <- as.POSIXct(sprintf("%02d:%02d:%02d", h, m, s), format = "%H:%M:%S", tz = "UTC")
      
      df <- read_delim(file.path(dirnames[n], filenames[i]), delim = ";") # specify the delimiter if it's not a comma
      df <- df[df$Class == fclass,]
      if (nrow(df) == 0){
        next
      }
      df <- mutate(df, S = rp / (rp + fn))
      df <- mutate(df, G = rp / (rp + fp))
      df <- mutate(df, F1 = 2 * G * S / (G + S) )
      df <- cbind(df, t_int = interval)
      if (is.null(df2)){
        df2 <- df
      } else {
        df2 <- rbind(df2, df)
      }
      
      #if (is.null(df2)){
      #  next
      #}
      
      if(nrow(df2) == length(filenames)){
      #sens plot
      ggplot(data = df2, aes(t_int, S)) +
        geom_point() +
        # geom_smooth(method = "lm", formula = y ~ log2(x)) +
        theme_bw() +
        ggtitle(paste("Sensitivität",gatename, fclass )) +
        scale_y_continuous(limits = c(0.0, 1)) +
        scale_x_datetime(labels = scales::time_format("%M:%S")) +
        xlab("Zeitinterval [MM:SS]") + 
        ylab("Sensitivität S")
      
      ggsave(paste0(save_path,"/",gatename,"_S_", fclass, ".jpg"),device = "jpg" , width = 4, height = 4)
      
      #Genauigkeitsplot
      ggplot(data = df2, aes(t_int, G)) +
        geom_point() +
        #geom_smooth(method = "lm", formula = y ~ log2(x)) +
        theme_bw() +
        ggtitle(paste("Relevanz",gatename, fclass )) +
        scale_y_continuous(limits = c(0.0, 1)) +
        scale_x_datetime(labels = scales::time_format("%M:%S")) +
        xlab("Zeitinterval [MM:SS]") + 
        ylab("Sensitivität S")
      
      ggsave(paste0(save_path,"/",gatename, "_R_",fclass, ".jpg"),device = "jpg" , width = 4, height = 4)
      
      sensgen_plot <- ggplot(data = df2,  aes(G, S, label  = paste(format(as.POSIXct(t_int), "%M"), ":", format(as.POSIXct(t_int), "%S"))  )) +
        geom_point() +
        geom_vline(xintercept = 1, color = "black") +
        geom_hline(yintercept = 1, color = "black") +
        geom_abline(slope = 1, intercept = 0, color = "red") +
        #geom_text(size = 4) +
        ggtitle(paste("Sensitivität zu Relevanz" , gatename, fclass)) +
        xlab("Relevanz") +
        ylab("Sensitivität") +
        scale_y_continuous(limits = c(0.0, 1)) +
        scale_x_continuous(limits = c(0.0, 1)) +
        theme_bw()
      ggsave(paste0(save_path, "/", gatename, "_S2P_", fclass, ".jpg"), sensgen_plot, device = "jpg", width = 4, height = 4)
      
      write_csv2(df2, paste0(save_path,"/",gatename,"_", fclass, ".csv"))
      }
    }
    
  }
}
