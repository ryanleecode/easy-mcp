#!/bin/bash

# Common MCP Server Runner
# This script provides shared functionality for running MCP servers with Docker and Doppler

# Usage: mcp-runner.sh <service_name> <docker_image> <docker_args> <app_args> <secret1,secret2,...>
# Example: mcp-runner.sh "github" "ghcr.io/github/github-mcp-server" "-e GITHUB_PERSONAL_ACCESS_TOKEN=\$GITHUB_PERSONAL_ACCESS_TOKEN" "" "GITHUB_PERSONAL_ACCESS_TOKEN"

set -euo pipefail

# Check arguments
if [ $# -ne 5 ]; then
    echo "Usage: $0 <service_name> <docker_image> <docker_args> <app_args> <secrets_csv>"
    echo "Example: $0 github ghcr.io/github/github-mcp-server \"-e GITHUB_PERSONAL_ACCESS_TOKEN=\\\$GITHUB_PERSONAL_ACCESS_TOKEN\" \"\" \"GITHUB_PERSONAL_ACCESS_TOKEN\""
    exit 1
fi

SERVICE_NAME="$1"
DOCKER_IMAGE="$2"
DOCKER_ARGS="$3"
APP_ARGS="$4"
SECRETS_CSV="$5"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Convert CSV secrets to array
IFS=',' read -ra SECRETS_ARRAY <<< "$SECRETS_CSV"

# Kill containers from previous runs by reading all cidfiles
echo "Cleaning up containers from previous runs for $SERVICE_NAME..."
for cidfile in "$SCRIPT_DIR"/."$SERVICE_NAME"-mcp-current-*.tmp; do
    if [ -f "$cidfile" ]; then
        container_id=$(cat "$cidfile" 2>/dev/null)
        if [ -n "$container_id" ]; then
            echo "Stopping container: $container_id"
            docker kill "$container_id" 2>/dev/null || true
        fi
        rm -f "$cidfile"
    fi
done

# Start container in interactive mode and capture ID via cidfile
CIDFILE="$SCRIPT_DIR/.$SERVICE_NAME-mcp-current-$$.tmp"
EXEC_CMD="docker run -i --rm --cidfile=$CIDFILE $DOCKER_ARGS $DOCKER_IMAGE $APP_ARGS"

echo "Starting new $SERVICE_NAME-mcp container..."

# Build Doppler command with only the required secrets
DOPPLER_SECRETS=""
for secret in "${SECRETS_ARRAY[@]}"; do
    if [ -n "$DOPPLER_SECRETS" ]; then
        DOPPLER_SECRETS="$DOPPLER_SECRETS,$secret"
    else
        DOPPLER_SECRETS="$secret"
    fi
done

# Execute with or without Doppler based on whether secrets are needed
if [ -n "$DOPPLER_SECRETS" ]; then
    # Execute with Doppler for secret injection
    exec doppler run \
      --scope="$SCRIPT_DIR" \
      --only-secrets="$DOPPLER_SECRETS" \
      --command="$EXEC_CMD"
else
    # Execute directly without Doppler when no secrets are needed
    exec $EXEC_CMD
fi 
