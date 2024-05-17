#!/bin/bash

set -e

SRC_DIRECTORY="$(pwd)"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"
RESULT_FILE="$REPORT_DIRECTORY/banditResult.json"
BANDIT_IMAGE="secfigo/bandit:latest"

# Create the report directory if it doesn't exist
mkdir -p "$REPORT_DIRECTORY"
chmod -R 755 "$REPORT_DIRECTORY"

# Pull the latest version of the Bandit Docker image
echo "Pulling the latest version of the Bandit Docker image..."
docker pull "$BANDIT_IMAGE"

# Run Bandit in a Docker container
echo "Running Bandit tests..."
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
