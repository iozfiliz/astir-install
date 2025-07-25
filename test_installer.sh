#\!/bin/bash
# Extract and test individual functions from installer

detect_arch() {
    local arch
    arch=$(uname -m)
    
    case $arch in
        x86_64)
            echo "amd64"
            ;;
        aarch64 < /dev/null | arm64)
            echo "arm64"
            ;;
        armv7l)
            echo "armv7"
            ;;
        armv6l)
            echo "armv6"
            ;;
        *)
            echo "ERROR: Unsupported architecture: $arch"
            exit 1
            ;;
    esac
}

detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "ERROR: Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

echo "Testing installer functions:"
echo "Detected OS: $(detect_os)"
echo "Detected Arch: $(detect_arch)"
echo "Binary would be: astir-$(detect_os)-$(detect_arch)"
