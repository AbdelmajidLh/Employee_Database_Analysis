# Utiliser une image de base R avec tidyverse pour inclure les packages de data science
FROM rocker/tidyverse:latest

# Définir le répertoire de travail
WORKDIR /app

# Copier tous les fichiers du projet dans le conteneur
COPY . /app

# Installer les dépendances R avec renv
RUN R -e "install.packages('renv')"
RUN R -e "renv::restore()"

# Exécuter le script principal
CMD ["Rscript", "main.R"]
