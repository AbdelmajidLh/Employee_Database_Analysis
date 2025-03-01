# Utiliser une image R avec tidyverse
FROM rocker/tidyverse:latest

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers essentiels AVANT l'installation de `renv`
COPY renv.lock /app/

# Installer les dépendances avec `renv`
RUN R -e "install.packages('renv', repos='https://cran.rstudio.com/')"
RUN R -e "renv::restore(prompt = FALSE)"

# Copier les fichiers restants après `renv::restore()`
COPY . /app

# Corriger les permissions si nécessaire
RUN chmod -R 755 /app

# Exécuter le script principal
CMD ["Rscript", "main.R"]
