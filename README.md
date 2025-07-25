# Astir Desktop Client

**Desktop-as-a-Service Client for Linux**

Astir provides seamless access to cloud-based desktop environments with full SSH access, editing tools, and development capabilities.

## Quick Installation

### Universal Installer (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

### Debian Package

```bash
# Download and install
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir_latest_amd64.deb
sudo dpkg -i astir_latest_amd64.deb
```

### Manual Installation

```bash
# Download binary for your architecture
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir-linux-amd64
chmod +x astir-linux-amd64
sudo mv astir-linux-amd64 /usr/local/bin/astir
```

## Supported Platforms

- **Linux x86_64** (Intel/AMD 64-bit)
- **Linux ARM64** (64-bit ARM, Apple Silicon, AWS Graviton)
- **Linux ARMv7** (32-bit ARM, Raspberry Pi 3/4)
- **Linux ARMv6** (Raspberry Pi Zero, Pi 1)

## Features

- 🚀 **One-command setup** - Get started in under 2 minutes
- 🔐 **Solana wallet authentication** - Secure blockchain-based access
- 🐳 **Docker-based environments** - Consistent, isolated desktop sessions
- 🔄 **Automatic updates** - Stay current with latest features
- 📦 **Multiple install methods** - Universal installer, packages, or manual
- 🛠️ **Full development environment** - SSH access, editing tools, development stack

## Getting Started

After installation, run:

```bash
astir
```

The first-run setup wizard will guide you through:

1. **System Requirements Check** - Verify Docker and dependencies
2. **Wallet Import** - Connect your existing Solana wallet
3. **Connection Test** - Verify orchestrator connectivity

## Requirements

- **Linux** (any modern distribution)
- **Docker** 20.10+ (will be checked during setup)
- **Solana Wallet** (existing wallet required for authentication)

## Update

```bash
# Check for updates
astir update --check

# Update to latest version
astir update

# Or re-run the installer
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

## Uninstall

```bash
# Using the uninstaller
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/uninstall.sh | bash

# Or manual removal
sudo rm -f /usr/local/bin/astir
rm -rf ~/.config/astir
```

## Architecture Detection

The installer automatically detects your system architecture:

```bash
# Detected architectures:
# x86_64    → astir-linux-amd64
# aarch64   → astir-linux-arm64
# armv7l    → astir-linux-armv7
# armv6l    → astir-linux-armv6
```

## Configuration

Default configuration location: `~/.config/astir/config.json`

```json
{
  "orchestrator_address": "production.astir.dev:50051",
  "max_containers": 10,
  "wallet_address": "your-wallet-address",
  "auto_update_enabled": true,
  "setup_completed": true
}
```

## Troubleshooting

### Common Issues

**Docker not running:**
```bash
# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

**Permission denied:**
```bash
# Make sure Docker daemon is accessible
docker --version
docker info
```

**Update issues:**
```bash
# Check system status
astir doctor

# Force reinstall
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

### Get Help

- **Documentation**: [View installation guide](docs/installation.md)
- **Issues**: [Report problems](https://github.com/iozfiliz/astir-install/issues)
- **Updates**: [View releases](https://github.com/iozfiliz/astir-install/releases)

## Security

- All connections use TLS encryption
- Wallet authentication via cryptographic signatures
- No private keys stored on client
- Open source installer and documentation
- Automated security updates

## License

The installer and documentation are open source. The Astir client binary is proprietary software.

---

**Made with ❤️ for the development community**