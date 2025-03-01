# Vérifier et activer {renv} en premier
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
} else {
  if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv", ask = FALSE)
  }
  renv::init(restart = FALSE)  # Initialiser renv seulement si nécessaire
}

# Vérifier si renv est bien activé avant la restauration
if ("renv" %in% installed.packages()[, "Package"]) {
  suppressMessages(renv::restore(prompt = FALSE))
}

# Liste des packages requis
required_packages <- c("readr", "dplyr", "logger", "DBI", "RSQLite", "ggplot2")

# Fonction pour installer les packages manquants
install_missing_packages <- function(packages) {
  missing_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(missing_packages) > 0) {
    install.packages(missing_packages, dependencies = TRUE, quiet = TRUE, ask = FALSE)
  }
}

# Installer les packages nécessaires
install_missing_packages(required_packages)

# Charger les bibliothèques
lapply(required_packages, library, character.only = TRUE)
