### 4. Module de lecture des données depuis SQLite (read_database.R)

source("scripts/utils/packages.R")

log_info("Chargement du module de lecture depuis SQLite")

read_from_sqlite <- function(db_path, table_name) {
  con <- dbConnect(SQLite(), db_path)
  log_info("Lecture de la table: {table_name}")
  
  data <- dbReadTable(con, table_name)
  dbDisconnect(con)
  
  return(data)
}