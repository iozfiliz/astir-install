# Astir Installation Guide

This guide covers all installation methods for the Astir Desktop Client on Linux systems.

## Quick Start

For most users, the universal installer is the fastest way to get started:

```bash
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

## System Requirements

### Minimum Requirements
- **Operating System**: Linux (any modern distribution)
- **Architecture**: x86_64, ARM64, ARMv7, or ARMv6
- **RAM**: 512MB available
- **Disk Space**: 100MB for client + space for desktop images
- **Network**: Internet connection for initial setup and updates

### Required Software
- **Docker**: 20.10 or later (automatically checked during setup)
- **Solana Wallet**: Existing wallet required for authentication

### Supported Platforms

| Platform | Architecture | Binary Name | Package |
|----------|-------------|-------------|---------|
| Linux x86_64 | AMD64 | `astir-linux-amd64` | `astir_*_amd64.deb` |
| Linux ARM64 | ARM64 | `astir-linux-arm64` | `astir_*_arm64.deb` |
| Linux ARMv7 | ARM32v7 | `astir-linux-armv7` | `astir_*_armhf.deb` |
| Linux ARMv6 | ARM32v6 | `astir-linux-armv6` | `astir_*_armel.deb` |

## Installation Methods

### 1. Universal Installer (Recommended)

The universal installer automatically detects your system and installs the appropriate version.

#### Features
- ✅ Automatic architecture detection
- ✅ System requirements checking
- ✅ Docker dependency verification
- ✅ User directory setup
- ✅ Works on any Linux distribution

#### Installation
```bash
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

#### What it does
1. Detects your system architecture
2. Checks system requirements (Docker, etc.)
3. Downloads the latest binary for your system
4. Installs to `/usr/local/bin/astir`
5. Creates user configuration directories
6. Verifies the installation

#### Example Output
```
Astir Universal Installer
=========================

[INFO] Detected system: linux-amd64
[INFO] Checking system requirements...
[SUCCESS] Docker is available and running
[INFO] Fetching latest version...
[INFO] Latest version: v1.0.0
[INFO] Installing Astir for linux-amd64...
[INFO] Version: v1.0.0
[INFO] Downloading: astir-linux-amd64
[SUCCESS] Installed Astir v1.0.0 to /usr/local/bin/astir
[INFO] Creating user directories...
[SUCCESS] Created user directories in /home/user/.config/astir
[SUCCESS] Installation complete! 🚀

🎉 Astir is now installed!

Next steps:
1. Run 'astir --help' to see available commands
2. Run 'astir' to start the interactive mode
3. Import your Solana wallet when prompted
```

### 2. Debian/Ubuntu Package Installation

For Debian-based distributions, you can install using .deb packages.

#### Download and Install
```bash
# AMD64 (Intel/AMD 64-bit)
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir_latest_amd64.deb
sudo dpkg -i astir_latest_amd64.deb

# ARM64 (64-bit ARM)
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir_latest_arm64.deb
sudo dpkg -i astir_latest_arm64.deb

# ARMv7 (32-bit ARM)
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir_latest_armhf.deb
sudo dpkg -i astir_latest_armhf.deb
```

#### Install Dependencies
```bash
# If Docker is not installed
sudo apt update
sudo apt install docker.io

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in for group changes to take effect
```

#### Package Features
- ✅ Automatic dependency management
- ✅ System integration
- ✅ Clean uninstallation
- ✅ Post-installation setup

### 3. Manual Installation

For advanced users or custom setups.

#### Download Binary
```bash
# Get latest version info
LATEST_VERSION=$(curl -s https://api.github.com/repos/iozfiliz/astir-install/releases/latest | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)

# Download for your architecture
# AMD64
wget "https://github.com/iozfiliz/astir-install/releases/download/${LATEST_VERSION}/astir-linux-amd64"

# ARM64
wget "https://github.com/iozfiliz/astir-install/releases/download/${LATEST_VERSION}/astir-linux-arm64"

# ARMv7
wget "https://github.com/iozfiliz/astir-install/releases/download/${LATEST_VERSION}/astir-linux-armv7"

# ARMv6
wget "https://github.com/iozfiliz/astir-install/releases/download/${LATEST_VERSION}/astir-linux-armv6"
```

#### Install Binary
```bash
# Make executable
chmod +x astir-linux-*

# Install to system (choose your architecture)
sudo mv astir-linux-amd64 /usr/local/bin/astir

# Or install to user directory
mkdir -p ~/bin
mv astir-linux-amd64 ~/bin/astir
export PATH="$HOME/bin:$PATH"
```

#### Create User Directories
```bash
mkdir -p ~/.config/astir/{wallets,certs,images,logs}
```

#### Verify Installation
```bash
astir --version
```

## First Run Setup

After installation, run Astir for the first time:

```bash
astir
```

The setup wizard will guide you through:

### Step 1: System Requirements Check
- ✅ Docker installation verification
- ✅ Docker daemon status check
- 🔄 Desktop image download (if needed)

### Step 2: Wallet Import
- Import your existing Solana wallet
- 24-word mnemonic phrase required
- Wallet stored encrypted locally

### Step 3: Connection Test
- Test connection to orchestrator
- Verify wallet authentication
- Confirm service availability

## Configuration

After setup, your configuration will be stored at:

```
~/.config/astir/
├── config.json          # Main configuration
├── wallets/              # Encrypted wallet data
├── certs/                # TLS certificates
├── images/               # Cached desktop images
└── logs/                 # Application logs
```

### Configuration File
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

### Docker Issues

#### Docker not installed
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install docker.io

# CentOS/RHEL
sudo yum install docker

# Or use Docker's official installer
curl -fsSL https://get.docker.com | sudo sh
```

#### Docker daemon not running
```bash
# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Check status
sudo systemctl status docker
```

#### Permission denied (Docker)
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or restart session
newgrp docker

# Test
docker --version
```

### Download Issues

#### Slow download or timeouts
```bash
# Try different download method
# If curl fails, try wget
wget https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh
bash install.sh

# Or download binary directly
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir-linux-amd64
```

#### Checksum verification
```bash
# Download checksums
wget https://github.com/iozfiliz/astir-install/releases/latest/download/checksums.txt

# Verify your download
sha256sum -c checksums.txt
```

### Architecture Detection Issues

If the installer doesn't detect your architecture correctly:

```bash
# Check your architecture
uname -m

# Download specific binary manually
# x86_64 → astir-linux-amd64
# aarch64 → astir-linux-arm64
# armv7l → astir-linux-armv7
# armv6l → astir-linux-armv6
```

### Network Issues

#### Firewall blocking connections
```bash
# Check if port 50051 is accessible
telnet production.astir.dev 50051

# Or use netcat
nc -zv production.astir.dev 50051
```

#### Proxy environments
```bash
# Set proxy environment variables if needed
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080

# Then run installer
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

## Updating

### Automatic Updates
Astir checks for updates automatically on startup. If updates are available, you'll see a notification.

### Manual Update
```bash
# Check for updates
astir update --check

# Update to latest version
astir update

# Or re-run installer (always safe)
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

## Uninstallation

### Using Uninstaller (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/uninstall.sh | bash
```

### Manual Removal
```bash
# Remove binary
sudo rm -f /usr/local/bin/astir

# Remove user data (optional)
rm -rf ~/.config/astir

# Remove package (if installed via .deb)
sudo dpkg -r astir
```

## Support

- **Documentation**: [GitHub Repository](https://github.com/iozfiliz/astir-install)
- **Issues**: [Report Problems](https://github.com/iozfiliz/astir-install/issues)
- **Releases**: [View Releases](https://github.com/iozfiliz/astir-install/releases)

## Security

- All downloads use HTTPS
- Checksums provided for verification
- Wallet data encrypted locally
- No private keys transmitted
- TLS for all orchestrator connections