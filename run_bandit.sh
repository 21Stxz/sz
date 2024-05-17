#!/bin/sh
set -e

# Définition des chemins
SRC_DIRECTORY="/var/lib/jenkins/workspace/TP8PIPELINE"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"
IGNORE_FILE="$SRC_DIRECTORY/bandit.ignore"
RESULT_FILE="$REPORT_DIRECTORY/banditResult.json"

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

# Pull de la dernière version de l'image Docker Bandit
echo "Téléchargement de la dernière version de l'image Docker Bandit..."
docker pull secfigo/bandit:latest

# Exécution de Bandit avec le chemin correct vers le répertoire de rapport
echo "Exécution des tests Bandit..."
docker run --rm \
    --volume "$SRC_DIRECTORY":/src \
    --volume "$REPORT_DIRECTORY":/report \
    secfigo/bandit:latest bandit -r -f json -o "$RESULT_FILE" /src/
#!/bin/sh
set -e

# Définition des chemins
SRC_DIRECTORY="/var/lib/jenkins/workspace/TP8PIPELINE"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"
IGNORE_FILE="$SRC_DIRECTORY/bandit.ignore"
RESULT_FILE="$REPORT_DIRECTORY/banditResult.json"

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

# Pull de la dernière version de l'image Docker Bandit
echo "Téléchargement de la dernière version de l'image Docker Bandit..."
docker pull secfigo/bandit:latest

# Exécution de Bandit avec le chemin correct vers le répertoire de rapport
echo "Exécution des tests Bandit..."
docker run --rm \
    --volume "$SRC_DIRECTORY":/src \
    --volume "$REPORT_DIRECTORY":/report \
    secfigo/bandit:latest bandit -r -f json -o "$RESULT_FILE" /src/
    
