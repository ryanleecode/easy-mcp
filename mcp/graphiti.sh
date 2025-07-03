#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec "$SCRIPT_DIR/mcp-runner.sh" \
  "graphiti" \
  "zepai/knowledge-graph-mcp:latest" \
  "-e NEO4J_URI=\$NEO4J_URI -e NEO4J_USER=\$NEO4J_USER -e NEO4J_PASSWORD=\$NEO4J_PASSWORD -e OPENAI_API_KEY=\$OPENAI_API_KEY -e MODEL_NAME=\$MODEL_NAME" \
  "uv run graphiti_mcp_server.py --transport stdio --group-id cursor" \
  "NEO4J_URI,NEO4J_USER,NEO4J_PASSWORD,OPENAI_API_KEY" 
