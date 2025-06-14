#!/bin/bash

# @21st-dev/magic MCP Server startup script
# This script handles Doppler secret injection and Docker execution

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Docker command for magic MCP server (using metorial containerized version)
DOCKER_CMD="docker run --rm -i ghcr.io/metorial/mcp-container--21st-dev--magic-mcp--magic-mcp \"npm run start --api-key \$TWENTY_FIRST_API_KEY\""

# Execute with Doppler for secret injection
exec doppler run \
  --scope="$SCRIPT_DIR" \
  --only-secrets=TWENTY_FIRST_API_KEY \
  --command="$DOCKER_CMD" 
