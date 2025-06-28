#!/bin/bash

# GitHub MCP Server startup script
# This script uses the common MCP runner with GitHub-specific configuration

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call common MCP runner with GitHub-specific parameters
exec "$SCRIPT_DIR/mcp-runner.sh" \
  "github" \
  "ghcr.io/github/github-mcp-server" \
  "-e GITHUB_PERSONAL_ACCESS_TOKEN=\$GITHUB_PERSONAL_ACCESS_TOKEN" \
  "" \
  "GITHUB_PERSONAL_ACCESS_TOKEN" 
