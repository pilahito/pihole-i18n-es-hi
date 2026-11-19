#!/bin/bash
# Pi-hole i18n Mod Installer
# Installs the translation system in a way that survives Pi-hole updates.

set -e

PIHOLE_WEB="/var/www/html/admin"
MOD_DIR="/opt/pihole-i18n"
LOCALES_SRC="$(dirname "$0")/scripts/lua/locales"
I18N_SRC="$(dirname "$0")/scripts/lua/i18n.lp"

echo "=== Pi-hole i18n Mod Installer ==="

# Create persistent mod directory
sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$LOCALES_SRC"/* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$I18N_SRC" "$MOD_DIR/i18n.lp" 2>/dev/null || true

# Create symlink inside Pi-hole web (or copy if symlink not desired)
if [ -d "$PIHOLE_WEB" ]; then
  sudo mkdir -p "$PIHOLE_WEB/scripts/lua"
  sudo ln -sfn "$MOD_DIR/i18n.lp" "$PIHOLE_WEB/scripts/lua/i18n.lp"
  sudo ln -sfn "$MOD_DIR/locales" "$PIHOLE_WEB/scripts/lua/locales"
  echo "Symlinks created in $PIHOLE_WEB"
else
  echo "Warning: Pi-hole web directory not found at $PIHOLE_WEB"
  echo "Files installed to $MOD_DIR (manual copy may be needed)"
fi

echo ""
echo "Installation complete."
echo "Mod files are in: $MOD_DIR"
echo "They will survive Pi-hole updates as long as the symlinks remain."
echo ""
echo "To uninstall: sudo rm -rf $MOD_DIR && sudo rm -f $PIHOLE_WEB/scripts/lua/i18n.lp $PIHOLE_WEB/scripts/lua/locales"
