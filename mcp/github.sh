#!/bin/bash

# GitHub MCP Server startup script
# This script handles Doppler secret injection and Docker execution

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# MCP GitHub server Docker image
MCP_PACKAGE="ghcr.io/github/github-mcp-server"

# Kill any existing github-mcp containers (cleanup zombies)
echo "Cleaning up existing github-mcp containers..."
docker ps -q --filter ancestor="$MCP_PACKAGE" | xargs -r docker kill

# Docker command for GitHub MCP server
DOCKER_CMD="docker run --rm -i -e GITHUB_PERSONAL_ACCESS_TOKEN=\$GITHUB_PERSONAL_ACCESS_TOKEN $MCP_PACKAGE"

# Execute with Doppler for secret injection
exec doppler run \
  --scope="$SCRIPT_DIR" \
  --only-secrets=GITHUB_PERSONAL_ACCESS_TOKEN \
  --command="$DOCKER_CMD" 
