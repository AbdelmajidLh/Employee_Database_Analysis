### 5. Module d'analyse exploratoire (exploratory_analysis.R)

source("scripts/utils/packages.R")

log_info("Chargement du module d'analyse exploratoire")

explore_salaries <- function(db_path) {
  salaries <- read_from_sqlite(db_path, "salaries")
  
  log_info("Génération de l'histogramme des salaires")
  p <- ggplot(salaries, aes(x = salary)) +
    geom_histogram(bins = 30, fill = "orange", alpha = 0.7) +
    labs(title = "Répartition des salaires", x = "Salaire", y = "Nombre d'employés")
  
  ggsave("res/salary_histogram.png", p, width = 15, height = 4, dpi = 300, units = "in")
  log_info("Histogramme sauvegardé sous data/salary_histogram.png")
}