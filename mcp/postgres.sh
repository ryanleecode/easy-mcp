#!/bin/bash

# PostgreSQL MCP Server startup script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# MCP PostgreSQL server Docker image
MCP_PACKAGE="crystaldba/postgres-mcp"

# Kill any existing postgres-mcp containers (cleanup zombies)
echo "Cleaning up existing postgres-mcp containers..."
docker ps -q --filter ancestor="$MCP_PACKAGE" | xargs -r docker kill

EXEC_CMD="docker run -i --rm -e DATABASE_URI=\$TIMESCALE_DATABASE_URL $MCP_PACKAGE --access-mode=unrestricted"

exec doppler run \
  --scope="$SCRIPT_DIR" \
  --only-secrets=TIMESCALE_DATABASE_URL \
  --command="$EXEC_CMD"
