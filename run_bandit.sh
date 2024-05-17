#!/bin/bash

#!/bin/sh
set -e

SRC_DIRECTORY="$(pwd)"
# Définition des chemins
SRC_DIRECTORY="/var/lib/jenkins/workspace/TP8PIPELINE"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"
IGNORE_FILE="$SRC_DIRECTORY/bandit.ignore"
RESULT_FILE="$REPORT_DIRECTORY/banditResult.json"
BANDIT_IMAGE="secfigo/bandit:latest"

# Create the report directory if it doesn't exist
mkdir -p "$REPORT_DIRECTORY"
chmod -R 755 "$REPORT_DIRECTORY"
# Vérification et création du répertoire de rapport s'il n'existe pas
if [ ! -d "$REPORT_DIRECTORY" ]; then
    echo "Création du répertoire de rapport..."
    mkdir -p "$REPORT_DIRECTORY"
    chmod -R 777 "$REPORT_DIRECTORY"
fi

# Vérification et création du fichier .bandit.ignore s'il n'existe pas
if [ ! -f "$IGNORE_FILE" ]; then
    echo "Création du fichier bandit.ignore..."
    touch "$IGNORE_FILE"
    chmod 666 "$IGNORE_FILE"
fi

# Pull the latest version of the Bandit Docker image
echo "Pulling the latest version of the Bandit Docker image..."
docker pull "$BANDIT_IMAGE"
# Pull de la dernière version de l'image Docker Bandit
echo "Téléchargement de la dernière version de l'image Docker Bandit..."
docker pull secfigo/bandit:latest

# Run Bandit in a Docker container
echo "Running Bandit tests..."
# Exécution de Bandit avec le chemin correct vers le répertoire de rapport
echo "Exécution des tests Bandit..."
docker run --rm \
    --volume "$SRC_DIRECTORY":/src \
    --volume "$REPORT_DIRECTORY":/report \
    "$BANDIT_IMAGE" bandit -r -f json -o "$RESULT_FILE" /src

# Check if Bandit command was successful
if [ $? -eq 0 ]; then
    echo "Bandit tests completed successfully."
else
    echo "Bandit tests failed."
    exit 1
fi
    secfigo/bandit:latest -r -f json -o "$RESULT_FILE" /src/
