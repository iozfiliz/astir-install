# Release Instructions for Astir

This document explains how to create a new release of Astir Desktop Client.

## Prerequisites

### 1. GitHub Repository Setup
- ✅ Public repository: `iozfiliz/astir-install` (this repo)
- ✅ Private repository: `iozfiliz/desktop-orchestrator` (source code)
- ✅ GitHub Actions enabled on public repository

### 2. Required Secrets
In the `astir-install` repository, configure these secrets:

**Settings → Secrets and variables → Actions → New repository secret**

- **`SOURCE_REPO_TOKEN`**: Personal Access Token for accessing private repository
  - Go to GitHub Settings → Developer settings → Personal access tokens
  - Generate token with `repo` scope
  - Add token as secret in public repository

## Release Process

### Step 1: Prepare Source Code
In your **private repository** (`desktop-orchestrator`):

1. **Complete development** and testing
2. **Update version** in `client/cmd/client/main.go`:
   ```go
   var (
       version = "1.0.1"  // Update this
   )
   ```
3. **Commit changes**:
   ```bash
   git add .
   git commit -m "bump version to v1.0.1"
   ```
4. **Create and push tag**:
   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```

### Step 2: Trigger Release Build
In the **public repository** (`astir-install`):

1. **Go to GitHub Actions**:
   - Navigate to: https://github.com/iozfiliz/astir-install/actions
   - Click on "Build and Release" workflow

2. **Run workflow**:
   - Click "Run workflow" button
   - Fill in the form:
     - **Use workflow from**: `main`
     - **Release version**: `v1.0.1`
     - **Source repository**: `iozfiliz/desktop-orchestrator`  
     - **Source branch/tag**: `v1.0.1`
   - Click "Run workflow"

3. **Monitor progress**:
   - Watch the workflow execution
   - Check for any errors in build logs
   - Verify all jobs complete successfully

### Step 3: Verify Release
After workflow completes:

1. **Check GitHub Releases**:
   - Go to: https://github.com/iozfiliz/astir-install/releases
   - Verify new release `v1.0.1` is created
   - Check all files are present:
     - `astir-linux-amd64`
     - `astir-linux-arm64`
     - `astir-linux-armv7`
     - `astir-linux-armv6`
     - `astir_1.0.1_amd64.deb`
     - `astir_1.0.1_arm64.deb`
     - `astir_1.0.1_armhf.deb`
     - `astir_1.0.1_armel.deb`
     - `checksums.txt`

2. **Test installation**:
   ```bash
   # Test universal installer
   curl -sSL https://raw.githubusercontent.com/iozfiliz/astir-install/main/install.sh | bash
   
   # Verify version
   astir --version
   ```

3. **Test update mechanism**:
   ```bash
   # Existing users should see update notification
   astir  # Should show update available
   ```

## Quick Release Command Reference

```bash
# In private repository (desktop-orchestrator)
git add .
git commit -m "bump version to v1.0.1"
git tag v1.0.1
git push origin v1.0.1

# Then trigger GitHub Actions workflow in astir-install repository
# via web interface with:
# - version: v1.0.1
# - source_repo: iozfiliz/desktop-orchestrator
# - source_ref: v1.0.1
```

## Troubleshooting

### Build Failures

**Error: Failed to checkout source repository**
- Check `SOURCE_REPO_TOKEN` secret is set correctly
- Verify token has `repo` scope
- Ensure token hasn't expired

**Error: Tag not found**
- Verify tag exists in private repository: `git tag -l`
- Ensure tag was pushed: `git push origin --tags`
- Check source_ref matches exact tag name

**Error: Build failed for architecture**
- Check Go build errors in workflow logs
- Verify code compiles locally for that architecture
- Check for architecture-specific dependencies

### Release Issues

**Missing files in release**
- Check workflow completed all jobs successfully
- Verify artifact upload/download steps worked
- Look for errors in package creation steps

**Wrong version in binary**
- Verify version was updated in main.go
- Check LDFLAGS in build process
- Ensure correct source ref was used

### Installation Issues

**Installer fails to download**
- Verify release assets are public
- Check asset names match expected patterns
- Test download URLs manually

**Version mismatch**
- Clear any cached downloads
- Verify GitHub Releases API returns correct version
- Check client update logic

## Version Strategy

### Semantic Versioning
Use semantic versioning (semver): `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes (rare)
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

### Examples
- `v1.0.0` → `v1.0.1` (bug fix)
- `v1.0.1` → `v1.1.0` (new feature)
- `v1.1.0` → `v2.0.0` (breaking change)

### Pre-releases
For testing: `v1.1.0-beta.1`, `v1.1.0-rc.1`

## Best Practices

### Before Release
- ✅ Test all architectures locally if possible
- ✅ Run full test suite in private repository
- ✅ Update documentation if needed
- ✅ Review changelog/release notes
- ✅ Verify all dependencies are current

### During Release
- ✅ Monitor workflow execution
- ✅ Check for any warnings or errors
- ✅ Verify all artifacts are created
- ✅ Test download and installation

### After Release
- ✅ Test installation on different platforms
- ✅ Verify update notifications work
- ✅ Monitor for user reports
- ✅ Update any external documentation

## Emergency Procedures

### Roll Back Release
If a release has critical issues:

1. **Delete GitHub Release**:
   - Go to releases page
   - Click on problematic release
   - Click "Delete" button

2. **Revert changes** in private repository if needed

3. **Create hotfix release** with fix

### Hotfix Process
For urgent fixes:

1. **Create hotfix branch** from latest tag
2. **Apply minimal fix**
3. **Test thoroughly**
4. **Create patch version** (e.g., `v1.0.1` → `v1.0.2`)
5. **Follow normal release process**

---

**Important**: Always test releases thoroughly before announcing to users!