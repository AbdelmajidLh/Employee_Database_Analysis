### 7. Script principal (main.R)
# importer les packags
source("scripts/utils/packages.R")
#source("scripts/utils/renv.R")


# Création du dossier logs si inexistant
if (!dir.exists("logs")) {
  dir.create("logs")
}

dir.create("logs", showWarnings = FALSE)
log_file <- "logs/pipeline.log"
file.remove(log_file)  # Supprime le fichier log existant pour chaque nouvelle exécution
log_appender(appender_file(log_file))

# activer l'environnement
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
} else {
  stop("Erreur : renv/activate.R est manquant. Exécutez renv::init() en local")
}




log_info("Démarrage du script principal")

# Charger les modules
source("scripts/load_data.R")
source("scripts/store_data.R")
source("scripts/read_database.R")
source("scripts/exploratory_analysis.R")
source("scripts/store_results.R")

# Définition des chemins
db_path <- "data/employees_db.sqlite"

# Exécution du pipeline
log_info("1. Chargement des fichiers CSV")
csv_data <- read_csv_files("data/")

log_info("2. Stockage des données dans SQLite")
save_to_sqlite(csv_data, db_path)

log_info("3. Lecture de la base de données")
employees_data <- read_from_sqlite(db_path, "employees")
salaries_data <- read_from_sqlite(db_path, "salaries")

# Fusion des employés avec leurs salaires
employees_data <- employees_data %>%
  left_join(salaries_data, by = "emp_no")

# Vérification après jointure
if (!"salary" %in% colnames(employees_data)) {
  stop("Erreur : La colonne salary n'est pas présente après la jointure.")
}

log_info("4. Analyse exploratoire")
explore_salaries(db_path)

log_info("5. Sauvegarde des résultats")
salary_summary <- employees_data %>%
  group_by(sex) %>%
  summarise(avg_salary = mean(salary, na.rm = TRUE))

save_analysis_results(salary_summary, "data/results_db.sqlite", "salary_summary")

log_info("Pipeline exécuté avec succès")


log_info("SessionInfo()")
sessionInfo()

