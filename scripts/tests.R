### 7. Tests unitaires

library(testthat)

log_info("Exécution des tests unitaires")

test_that("Lecture des fichiers CSV fonctionne", {
  csv_data <- read_csv_files("data/")
  expect_type(csv_data, "list")
  expect_true(all(sapply(csv_data, is.data.frame)))
})

test_that("Lecture de la base SQLite fonctionne", {
  data <- read_from_sqlite("res/employees_db.sqlite", "employees")
  expect_true(is.data.frame(data))
  expect_true(nrow(data) > 0)
})

log_info("Tests unitaires terminés avec succès")
