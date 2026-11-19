#!/bin/bash
# Update Pi-hole i18n mod from GitHub

set -e

REPO_URL="https://github.com/pilahito/pihole-i18n-es-hi.git"
MOD_DIR="/opt/pihole-i18n"
TMP_DIR="/tmp/pihole-i18n-update"

echo "=== Updating Pi-hole i18n mod ==="

# Clean previous temp
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# Clone latest version
git clone --depth 1 "$REPO_URL" "$TMP_DIR"

# Update files
sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$TMP_DIR/scripts/lua/locales/"* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$TMP_DIR/scripts/lua/i18n.lp" "$MOD_DIR/i18n.lp" 2>/dev/null || true

# Cleanup
rm -rf "$TMP_DIR"

echo "Update complete."
echo "Mod files updated in $MOD_DIR"
