# Astir Install Repository Structure

This repository contains the public distribution infrastructure for Astir Desktop Client.

## Repository Purpose

This repository serves as the **public distribution point** for Astir while keeping the main source code private. It contains:

- ✅ Installation scripts
- ✅ Documentation  
- ✅ CI/CD for automated releases
- ✅ Binary distribution via GitHub Releases
- ❌ Source code (kept private)

## Directory Structure

```
astir-install/
├── README.md                     # Main repository documentation
├── install.sh                    # Universal installer script
├── uninstall.sh                  # Uninstaller script
├── REPOSITORY_STRUCTURE.md       # This file
├── .github/
│   └── workflows/
│       └── release.yml           # GitHub Actions for automated releases
├── docs/
│   └── installation.md          # Detailed installation guide
└── scripts/
    └── detect-arch.sh            # Architecture detection utility
```

## GitHub Releases Structure

Releases are automatically created by GitHub Actions and contain:

```
Release v1.0.0/
├── astir-linux-amd64             # Binary for x86_64
├── astir-linux-arm64             # Binary for ARM64
├── astir-linux-armv7             # Binary for ARMv7
├── astir-linux-armv6             # Binary for ARMv6
├── astir_1.0.0_amd64.deb         # Debian package for x86_64
├── astir_1.0.0_arm64.deb         # Debian package for ARM64
├── astir_1.0.0_armhf.deb         # Debian package for ARMv7
├── astir_1.0.0_armel.deb         # Debian package for ARMv6
└── checksums.txt                 # SHA256 checksums for all files
```

## Workflow Overview

### 1. Development Workflow
1. **Development** happens in private repository (`iozfiliz/desktop-orchestrator`)
2. **Testing** occurs in private repository
3. **Release preparation** involves tagging in private repository

### 2. Release Workflow
1. **Manual trigger** of GitHub Actions workflow in this repository
2. **Source checkout** from private repository using access token
3. **Multi-architecture builds** for all supported platforms
4. **Package creation** (.deb files for different architectures)
5. **Release creation** with all binaries and packages
6. **Automatic publishing** to GitHub Releases

### 3. Distribution Workflow
1. **Users discover** Astir via this public repository
2. **Installation** via universal installer or direct downloads
3. **Updates** checked against GitHub Releases API
4. **Documentation** available in this repository

## Key Features

### Multi-Architecture Support
- **x86_64** (Intel/AMD 64-bit)
- **ARM64** (64-bit ARM, Apple Silicon, AWS Graviton)
- **ARMv7** (32-bit ARM, Raspberry Pi 3/4)
- **ARMv6** (Raspberry Pi Zero, Pi 1)

### Installation Methods
- **Universal Installer**: One-command installation
- **Debian Packages**: Native package management
- **Manual Installation**: Direct binary download

### Security Features
- **Checksums**: SHA256 verification for all downloads
- **HTTPS**: All downloads over encrypted connections
- **Signature verification**: Future GPG signing support
- **Source verification**: Builds from tagged source commits

## GitHub Actions Configuration

### Required Secrets

The GitHub Actions workflow requires these secrets:

1. **`SOURCE_REPO_TOKEN`**: Personal Access Token with access to private repository
   - Scope: `repo` (full repository access)
   - Used to: Checkout source code from private repository

### Workflow Inputs

The release workflow accepts these inputs:

- **`version`**: Release version (e.g., `v1.0.0`)
- **`source_repo`**: Source repository (e.g., `iozfiliz/desktop-orchestrator`)  
- **`source_ref`**: Source branch/tag (e.g., `main`, `v1.0.0`)

### Workflow Steps

1. **Multi-arch builds**: Build binaries for all supported architectures
2. **Package creation**: Create .deb packages for each architecture
3. **Asset preparation**: Collect all binaries and packages
4. **Checksum generation**: Create SHA256 checksums
5. **Release creation**: Publish GitHub release with all assets

## Usage Examples

### For End Users

**Quick Installation:**
```bash
curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
```

**Manual Download:**
```bash
wget https://github.com/iozfiliz/astir-install/releases/latest/download/astir-linux-amd64
```

### For Maintainers

**Trigger Release:**
1. Go to GitHub Actions in this repository
2. Select "Build and Release" workflow
3. Click "Run workflow"
4. Enter version, source repo, and source ref
5. Click "Run workflow" button

**Update Documentation:**
1. Clone this repository
2. Update relevant files
3. Commit and push changes
4. Documentation is immediately available

## Security Considerations

### Source Code Protection
- Main source code remains in private repository
- Only installer scripts and documentation are public
- Binary builds happen in GitHub's secure environment
- Source access requires authentication token

### Download Security
- All downloads served via GitHub's CDN
- HTTPS encryption for all transfers
- SHA256 checksums for integrity verification
- Future: GPG signatures for authenticity

### Update Security
- Client checks updates via GitHub Releases API
- Version verification prevents downgrade attacks
- TLS connections for all update checks
- User confirmation required for updates

## Maintenance

### Regular Tasks
- **Monitor releases**: Ensure automated releases work correctly
- **Update documentation**: Keep installation guides current
- **Review security**: Monitor for security issues
- **Test installation**: Verify installers work on different systems

### Occasional Tasks
- **Rotate tokens**: Update access tokens periodically
- **Update workflows**: Improve CI/CD processes
- **Add platforms**: Support new architectures
- **Security audits**: Review security practices

## Migration Notes

This repository represents a **GitHub-first distribution strategy**:

- **Phase 1**: GitHub Releases as primary distribution (current)
- **Phase 2**: Optional custom domain (get.astir.dev) redirecting to GitHub
- **Phase 3**: Possible migration to custom CDN if needed

The architecture supports easy migration while maintaining compatibility:
- Installer URLs can be redirected
- API endpoints can be proxied
- Download URLs remain stable
- User experience remains consistent

## Contributing

### Public Contributions
- **Documentation improvements**: Always welcome
- **Installation script fixes**: Bug fixes and improvements
- **Platform support**: Help with new architectures
- **Issue reports**: Bug reports and feature requests

### Private Contributions
- **Core development**: Happens in private repository
- **Security fixes**: Coordinated via private channels
- **Feature development**: Private repository workflow

### Contribution Process
1. **Public issues**: File in this repository for installer/docs
2. **Private issues**: Coordinate via private channels
3. **Pull requests**: Welcome for public components
4. **Testing**: Help test on different platforms

## Support

- **Installation Issues**: File issues in this repository
- **Client Issues**: Contact via private channels
- **Documentation**: Improve via pull requests
- **Feature Requests**: Discuss in repository issues

---

This repository structure ensures secure, scalable distribution while maintaining the proprietary nature of the core Astir client software.