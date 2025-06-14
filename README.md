# Easy MCP

A streamlined setup for Model Context Protocol (MCP) servers with secure secret management via Doppler.

## Overview

This project provides easy-to-use MCP server configurations with secure secret injection using Doppler, ensuring sensitive credentials never touch your local environment.

## Prerequisites

### Required Tools
- [Doppler CLI](https://docs.doppler.com/docs/install-cli) - For secure secret management
- [Deno](https://deno.land/manual/getting_started/installation) - JavaScript/TypeScript runtime
- [Docker](https://docs.docker.com/get-docker/) - Container runtime

### Installation Commands
```bash
# Install Doppler CLI (macOS)
brew install doppler

# Install Deno
curl -fsSL https://deno.land/install.sh | sh

# Install Docker
# Follow instructions at: https://docs.docker.com/get-docker/
```

## Setup

### 1. Clone and Navigate
```bash
git clone <your-repo-url>
cd easy-mcp
```

### 2. Configure Doppler Secrets
Set up your secrets in Doppler for the project scope:

```bash
# Set up Doppler project (if not already done)
doppler setup

# Add your required secrets
doppler secrets set SECRET_NAME="your-secret-value"
```

### 3. Make Scripts Executable
```bash
chmod +x mcp/*.sh
```

### 4. Test Server Connections
```bash
# Test your configured servers
./mcp/your-server.sh
```

## MCP Configuration

The project includes a `.cursor/mcp.json` configuration file for Cursor IDE integration. Configure your servers as needed in this file.

## Security

### Secret Management
- All sensitive credentials are managed through Doppler
- Secrets are never exposed in scripts or configuration files
- Each server only receives the secrets it needs (`--only-secrets` flag)
- Secrets are injected at runtime, not stored locally

### Permissions
- Deno runs with minimal permissions (`--allow-net`, `--allow-env`)
- Docker containers run with `--rm` flag for automatic cleanup
- Environment variable access is restricted to necessary variables only

## Troubleshooting

### Common Issues

**Doppler not found**
```bash
# Ensure Doppler CLI is installed and authenticated
doppler --version
doppler auth login
```

**Deno permissions error**
```bash
# Verify Deno installation
deno --version
```

**Docker container fails to start**
```bash
# Verify Docker is running
docker --version
docker ps
```

### Debug Mode
For debugging, you can run commands manually by examining the shell scripts in the `mcp/` directory.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with your MCP client
5. Submit a pull request

## License

MIT License - Copyright 2025 Ryan Lee (ryanleecode)

## Links

- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [Doppler Documentation](https://docs.doppler.com/)
