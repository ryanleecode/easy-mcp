#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec "$SCRIPT_DIR/mcp-runner.sh" \
  "postgres" \
  "crystaldba/postgres-mcp" \
  "-e DATABASE_URI=\$TIMESCALE_DATABASE_URL" \
  "--access-mode=unrestricted" \
  "TIMESCALE_DATABASE_URL"
