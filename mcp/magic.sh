#!/bin/bash

# @21st-dev/magic MCP Server startup script
# This script uses the common MCP runner with Magic-specific configuration

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call common MCP runner with Magic-specific parameters
exec "$SCRIPT_DIR/mcp-runner.sh" \
  "magic" \
  "ghcr.io/metorial/mcp-container--21st-dev--magic-mcp--magic-mcp" \
  "" \
  "npm run start --api-key \$TWENTY_FIRST_API_KEY" \
  "TWENTY_FIRST_API_KEY" 
