#!/bin/sh
set +e

SRC_DIRECTORY="$(pwd)"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"
BANDIT_IMAGE="secfigo/bandit:latest"

if [ ! -d "$REPORT_DIRECTORY" ]; then
    echo "Initially creating persistent directories"
    mkdir -p "$REPORT_DIRECTORY"
    chmod -R 755 "$REPORT_DIRECTORY"
fi

# Pull the latest version of the Bandit Docker image
echo "Pulling the latest version of the Bandit Docker image..."
docker pull "$BANDIT_IMAGE"

# Check if the Docker image was downloaded successfully
if [ $? -eq 0 ]; then
    # Run Bandit in a Docker container
    echo "Running Bandit tests..."
    docker run --rm \
        --volume "$SRC_DIRECTORY":/src \
        --volume "$REPORT_DIRECTORY":/report \
        "$BANDIT_IMAGE"
else
    echo "Failed to download the Bandit Docker image."
    exit 1
fi
