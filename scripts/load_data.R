### 2. Module de chargement des fichiers CSV (load_data.R)

source("scripts/utils/packages.R")

log_info("Chargement du module de lecture des CSV")

read_csv_files <- function(directory) {
  log_info("Lecture des fichiers CSV dans le répertoire: {directory}")
  files <- list.files(directory, pattern = "\\.csv$", full.names = TRUE)
  
  if (length(files) == 0) {
    log_error("Aucun fichier CSV trouvé dans le répertoire {directory}")
    stop("Aucun fichier CSV trouvé.")
  }
  
  data_list <- lapply(files, read_csv)
  names(data_list) <- gsub(".csv", "", basename(files))
  
  log_info("Fichiers CSV chargés: {paste(names(data_list), collapse = ', ')}")
  return(data_list)
}