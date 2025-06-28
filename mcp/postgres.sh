#!/bin/bash

# PostgreSQL MCP Server startup script
# This script uses the common MCP runner with PostgreSQL-specific configuration

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call common MCP runner with PostgreSQL-specific parameters
exec "$SCRIPT_DIR/mcp-runner.sh" \
  "postgres" \
  "crystaldba/postgres-mcp" \
  "-e DATABASE_URI=\$TIMESCALE_DATABASE_URL" \
  "--access-mode=unrestricted" \
  "TIMESCALE_DATABASE_URL"
