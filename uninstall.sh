#!/bin/bash

set -euo pipefail

# Astir Uninstaller
# Removes Astir client and optionally user data

# Configuration
BINARY_NAME="astir"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="$HOME/.config/astir"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Ask user confirmation
ask_confirmation() {
    local prompt="$1"
    local response
    
    while true; do
        read -p "$prompt (y/N): " response
        case $response in
            [Yy]|[Yy][Ee][Ss])
                return 0
                ;;
            [Nn]|[Nn][Oo]|"")
                return 1
                ;;
            *)
                echo "Please answer yes or no."
                ;;
        esac
    done
}

# Check if binary exists
check_installation() {
    if [[ ! -f "$INSTALL_DIR/$BINARY_NAME" ]]; then
        log_warning "Astir binary not found at $INSTALL_DIR/$BINARY_NAME"
        return 1
    fi
    return 0
}

# Remove binary
remove_binary() {
    local binary_path="$INSTALL_DIR/$BINARY_NAME"
    
    if [[ ! -f "$binary_path" ]]; then
        log_warning "Binary not found: $binary_path"
        return 0
    fi
    
    log_info "Removing Astir binary..."
    
    if [[ -w "$INSTALL_DIR" ]]; then
        rm -f "$binary_path"
    else
        log_info "Removing from $INSTALL_DIR (requires sudo)"
        sudo rm -f "$binary_path"
    fi
    
    if [[ ! -f "$binary_path" ]]; then
        log_success "Removed binary: $binary_path"
    else
        log_error "Failed to remove binary: $binary_path"
        return 1
    fi
}

# Remove user data
remove_user_data() {
    if [[ ! -d "$CONFIG_DIR" ]]; then
        log_info "No user data found at $CONFIG_DIR"
        return 0
    fi
    
    echo
    log_warning "This will remove ALL Astir data including:"
    echo "  • Configuration files"
    echo "  • Wallet data (encrypted)"
    echo "  • Cached images"
    echo "  • Logs"
    echo "  • Certificates"
    echo
    echo "Location: $CONFIG_DIR"
    echo
    
    if ask_confirmation "Remove user data?"; then
        log_info "Removing user data..."
        rm -rf "$CONFIG_DIR"
        
        if [[ ! -d "$CONFIG_DIR" ]]; then
            log_success "Removed user data: $CONFIG_DIR"
        else
            log_error "Failed to remove user data: $CONFIG_DIR"
            return 1
        fi
    else
        log_info "Keeping user data at: $CONFIG_DIR"
        log_info "You can manually remove it later if needed"
    fi
}

# Stop any running processes
stop_processes() {
    log_info "Checking for running Astir processes..."
    
    # Find and kill any running astir processes
    local pids
    pids=$(pgrep -f "$BINARY_NAME" 2>/dev/null || true)
    
    if [[ -n "$pids" ]]; then
        log_warning "Found running Astir processes: $pids"
        if ask_confirmation "Stop running processes?"; then
            # Try graceful shutdown first
            pkill -TERM -f "$BINARY_NAME" 2>/dev/null || true
            sleep 2
            
            # Force kill if still running
            if pgrep -f "$BINARY_NAME" >/dev/null 2>&1; then
                log_warning "Processes still running, forcing shutdown..."
                pkill -KILL -f "$BINARY_NAME" 2>/dev/null || true
            fi
            
            log_success "Stopped Astir processes"
        fi
    else
        log_info "No running Astir processes found"
    fi
}

# Remove from PATH (if added manually)
check_path_modifications() {
    local shell_files=(
        "$HOME/.bashrc"
        "$HOME/.bash_profile"
        "$HOME/.zshrc"
        "$HOME/.profile"
    )
    
    local found_modifications=false
    
    for file in "${shell_files[@]}"; do
        if [[ -f "$file" ]] && grep -q "astir" "$file" 2>/dev/null; then
            log_warning "Found Astir-related entries in: $file"
            found_modifications=true
        fi
    done
    
    if [[ "$found_modifications" == true ]]; then
        log_info "Please manually remove any Astir-related PATH modifications from your shell files"
    fi
}

# Show completion message
show_completion() {
    log_success "Uninstallation complete!"
    echo
    echo "Astir has been removed from your system."
    echo
    echo "If you installed Docker specifically for Astir, you may also want to:"
    echo "  • Remove Docker: sudo apt remove docker-ce docker-ce-cli containerd.io"
    echo "  • Remove Docker data: sudo rm -rf /var/lib/docker"
    echo
    echo "Thank you for using Astir! 👋"
    echo
}

# Main uninstallation function
main() {
    echo "Astir Uninstaller"
    echo "=================="
    echo
    
    # Check if installed
    local binary_exists=true
    if ! check_installation; then
        binary_exists=false
    fi
    
    # Show what will be removed
    echo "This will remove:"
    if [[ "$binary_exists" == true ]]; then
        echo "  ✓ Astir binary from $INSTALL_DIR"
    else
        echo "  ✗ Astir binary (not found)"
    fi
    
    if [[ -d "$CONFIG_DIR" ]]; then
        echo "  ? User data at $CONFIG_DIR (optional)"
    else
        echo "  ✗ User data (not found)"
    fi
    
    echo
    
    if [[ "$binary_exists" == false ]] && [[ ! -d "$CONFIG_DIR" ]]; then
        log_info "Astir is not installed or already removed"
        exit 0
    fi
    
    if ! ask_confirmation "Continue with uninstallation?"; then
        log_info "Uninstallation cancelled"
        exit 0
    fi
    
    echo
    
    # Stop processes
    stop_processes
    
    # Remove binary
    if [[ "$binary_exists" == true ]]; then
        remove_binary
    fi
    
    # Remove user data (optional)
    remove_user_data
    
    # Check for manual PATH modifications
    check_path_modifications
    
    # Show completion
    show_completion
}

# Check if running with supported shell
if [[ -z "${BASH_VERSION:-}" ]]; then
    log_error "This uninstaller requires bash"
    exit 1
fi

# Run main function
main "$@"