### 6. Stockage des résultats d'analyse (store_results.R)

source("scripts/utils/packages.R")

save_analysis_results <- function(result, db_path, table_name) {
  con <- dbConnect(SQLite(), db_path)
  log_info("Stockage des résultats dans {table_name}")
  
  dbWriteTable(con, table_name, result, overwrite = TRUE, row.names = FALSE)
  dbDisconnect(con)
}