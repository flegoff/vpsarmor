#!/bin/bash
# VPS Armor - Basic security hardening for Ubuntu LTS and Debian Stable
# https://vpsarmor.com
# License: BSD 3-Clause

set -euo pipefail

echo "🛡️  VPS Armor - Hardening your server..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: Please run as root (or use sudo)${NC}"
   exit 1
fi

# Load OS information
if [[ ! -f /etc/os-release ]]; then
    echo -e "${RED}Error: Cannot detect OS. /etc/os-release not found.${NC}"
    exit 1
fi
. /etc/os-release

# Check for supported OS
echo "🔍 Checking OS compatibility..."
if [[ "$ID" == "ubuntu" ]]; then
    case "$VERSION_ID" in
        22.04|24.04)
            echo -e "${GREEN}✓ Ubuntu $VERSION_ID LTS detected${NC}"
            ;;
        *)
            echo -e "${RED}Error: Ubuntu $VERSION_ID is not an LTS release.${NC}"
            echo "Supported: 22.04, 24.04"
            exit 1
            ;;
    esac
elif [[ "$ID" == "debian" ]]; then
    case "$VERSION_CODENAME" in
        bookworm|trixie)
            echo -e "${GREEN}✓ Debian $VERSION_CODENAME detected${NC}"
            ;;
        *)
            echo -e "${RED}Error: Debian $VERSION_CODENAME is not a stable release.${NC}"
            echo "Supported: bookworm (12), trixie (13)"
            exit 1
            ;;
    esac
else
    echo -e "${RED}Error: Unsupported OS '$ID'.${NC}"
    echo "VPS Armor only supports Ubuntu LTS and Debian Stable."
    exit 1
fi

# Update system
echo ""
echo "📦 Updating system packages..."
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -qq

# Install security packages
echo ""
echo "🔧 Installing security tools..."
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    unattended-upgrades \
    apt-listchanges \
    fail2ban \
    ufw

# Configure fail2ban
echo ""
echo "🚫 Configuring fail2ban..."
systemctl enable fail2ban --quiet
systemctl start fail2ban

# Configure UFW
echo ""
echo "🧱 Setting up firewall (UFW)..."
if ufw status | grep -q "^Status: active"; then
    ufw allow 22/tcp comment 'SSH' > /dev/null
    ufw allow 80/tcp comment 'HTTP' > /dev/null
    ufw allow 443/tcp comment 'HTTPS' > /dev/null
    echo -e "${GREEN}✓ UFW already active. Existing rules preserved.${NC}"
else
    ufw default deny incoming > /dev/null
    ufw default allow outgoing > /dev/null
    ufw allow 22/tcp comment 'SSH' > /dev/null
    ufw allow 80/tcp comment 'HTTP' > /dev/null
    ufw allow 443/tcp comment 'HTTPS' > /dev/null
    ufw --force enable > /dev/null
    echo -e "${GREEN}✓ Firewall enabled. Allowed ports: 22, 80, 443${NC}"
fi

# Summary
echo ""
echo "=========================================="
echo -e "${GREEN}🛡️  VPS Armor complete!${NC}"
echo "=========================================="
echo ""
echo "Your server now has:"
echo "  ✓ All packages updated"
echo "  ✓ Unattended upgrades installed (distro defaults)"
echo "  ✓ Fail2ban protecting SSH"
echo "  ✓ UFW firewall active (existing rules preserved)"
echo ""
echo -e "${YELLOW}Note: If you need additional ports, run:${NC}"
echo "  ufw allow <port>/tcp"
echo ""
echo "Stay safe out there! 🚀"
