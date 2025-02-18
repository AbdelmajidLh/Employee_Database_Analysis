### 3. Module de stockage dans SQLite (store_data.R)

source("scripts/utils/packages.R")

log_info("Chargement du module de stockage en base de données SQLite")

save_to_sqlite <- function(data_list, db_path) {
  con <- dbConnect(SQLite(), db_path)
  log_info("Connexion à la base SQLite: {db_path}")
  
  for (name in names(data_list)) {
    log_info("Stockage de la table: {name}")
    dbWriteTable(con, name, data_list[[name]], overwrite = TRUE, row.names = FALSE)
  }
  
  dbDisconnect(con)
  log_info("Données stockées avec succès dans {db_path}")
}