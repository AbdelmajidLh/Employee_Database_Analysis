### 7. Script principal (main.R)
# Création du dossier logs si inexistant
if (!dir.exists("logs")) {
  dir.create("logs")
}

# Définition d'un seul fichier log par exécution
log_file <- "logs/pipeline.log"

source("scripts/utils/packages.R")
source("scripts/utils/renv.R")

# Définition d'un seul fichier log par exécution
dir.create("logs", showWarnings = FALSE)
log_file <- "logs/pipeline.log"
file.remove(log_file)  # Supprime le fichier log existant pour chaque nouvelle exécution
log_appender(appender_file(log_file))


log_info("Démarrage du script principal")

# Gestion de l'environnement virtuel avec renv
#if (!file.exists("renv.lock")) {
#  renv::init()
#} else {
#  renv::restore()
#}

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
