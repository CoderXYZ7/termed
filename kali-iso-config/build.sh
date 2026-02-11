#!/bin/bash

# build.sh - Automated build script for Custom Kali ISO
# Handles Kali vs non-Kali quirks, cleanup, and configuration.

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[*] Starting Kali ISO Build Process...${NC}"

# Check for root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}[!] Please run as root (use sudo).${NC}"
    exit 1
fi

# Check dependencies
if ! command -v lb &> /dev/null; then
    echo -e "${RED}[!] live-build is not installed. Installing...${NC}"
    apt-get update && apt-get install -y live-build cdebootstrap
fi

# 1. Setup Exclusions (Fix for firmware-nexmon failure)
echo -e "${YELLOW}[*] Configuring package exclusions...${NC}"
mkdir -p config/archives
cat > config/archives/exclude-problematic.pref.chroot <<EOF
Package: firmware-nexmon
Pin: release *
Pin-Priority: -1
EOF

# 2. Cleanup
echo -e "${YELLOW}[*] Cleaning previous builds...${NC}"
lb clean --purge

# 3. Configure
echo -e "${YELLOW}[*] Configuring live-build...${NC}"
# Detect if we need IPv4 workaround (simple check: try to ping IPv6 google or just force it for safety on non-Kali)
# actually, forcing IPv4 is safer generally for these mirrors
echo "inet4_only = on" > wgetrc-ipv4
export WGETRC="$PWD/wgetrc-ipv4"

lb config

# 4. Build
echo -e "${GREEN}[*] Starting build (this will take time)...${NC}"
lb build 2>&1 | tee build.log

echo -e "${GREEN}[+] Build Complete! ISO should be in the current directory.${NC}"
echo -e "${GREEN}[+] Build log saved to: build.log${NC}"
