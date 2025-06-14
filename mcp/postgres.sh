#!/bin/bash

# PostgreSQL MCP Server startup script
# This script handles Doppler secret injection and Deno execution

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Environment variables that Deno needs access to
ALLOWED_ENV="USER,PG*,NODE_PG_FORCE_NATIVE,TIMESCALE_DATABASE_URL"

# MCP PostgreSQL server package
MCP_PACKAGE="npm:@modelcontextprotocol/server-postgres"

# Deno command with permissions
DENO_CMD="deno run --quiet --allow-net --allow-env=\"$ALLOWED_ENV\" $MCP_PACKAGE \$TIMESCALE_DATABASE_URL"

# Execute with Doppler for secret injection
exec doppler run \
  --scope="$SCRIPT_DIR" \
  --only-secrets=TIMESCALE_DATABASE_URL \
  --command="$DENO_CMD"
