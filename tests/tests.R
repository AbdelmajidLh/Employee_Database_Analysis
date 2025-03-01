### 7. Tests unitaires (tests.R)
# Charger toutes les fonctions définies dans le dossier "scripts"
scripts_files <- list.files("scripts", pattern = "\\.R$", full.names = TRUE)
lapply(scripts_files, source)

library(logger)
library(testthat)

log_info("Exécution des tests unitaires")

test_that("Lecture des fichiers CSV fonctionne", {
  csv_data <- read_csv_files("data/")
  expect_type(csv_data, "list")
  expect_true(all(sapply(csv_data, is.data.frame)))
})

test_that("Stockage en base SQLite fonctionne", {
  db_path <- "data/employees_db.sqlite"
  csv_data <- read_csv_files("data/")
  save_to_sqlite(csv_data, db_path)
  
  con <- dbConnect(SQLite(), db_path)
  tables <- dbListTables(con)
  dbDisconnect(con)
  
  expect_true(length(tables) > 0)
})

test_that("Lecture de la base SQLite fonctionne", {
  data <- read_from_sqlite("data/employees_db.sqlite", "employees")
  expect_true(is.data.frame(data))
  expect_true(nrow(data) > 0)
})

test_that("Jointure employees-salaries fonctionne", {
  employees_data <- read_from_sqlite("data/employees_db.sqlite", "employees")
  salaries_data <- read_from_sqlite("data/employees_db.sqlite", "salaries")
  merged_data <- employees_data %>% left_join(salaries_data, by = "emp_no")
  
  expect_true("salary" %in% colnames(merged_data))
  expect_true(nrow(merged_data) > 0)
})

log_info("Tests unitaires terminés avec succès")