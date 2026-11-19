#!/bin/bash
# Pi-hole i18n Mod Installer
# Automatically detects if Pi-hole is running on the host or in Docker.

set -e

MOD_DIR="/opt/pihole-i18n"
LOCALES_SRC="$(dirname "$0")/scripts/lua/locales"
I18N_SRC="$(dirname "$0")/scripts/lua/i18n.lp"
CONTAINER_NAME="${PIHOLE_CONTAINER:-pihole}"

echo "=== Pi-hole i18n Mod Installer ==="

# Always keep a host copy
sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$LOCALES_SRC"/* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$I18N_SRC" "$MOD_DIR/i18n.lp" 2>/dev/null || true

# Detect Docker
if command -v docker >/dev/null 2>&1 && docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Detected Pi-hole running in Docker (container: $CONTAINER_NAME)"
  echo "Installing inside the container..."

  docker exec "$CONTAINER_NAME" mkdir -p /var/www/html/admin/scripts/lua/locales
  docker cp "$MOD_DIR/i18n.lp" "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/i18n.lp
  docker cp "$MOD_DIR/locales/." "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/locales/

  echo ""
  echo "Installation complete inside Docker container '$CONTAINER_NAME'."
  echo "Host copy kept at: $MOD_DIR"
  echo ""
  echo "Tip: After recreating the container, re-run this script."
  echo "Or mount $MOD_DIR as a volume for better persistence."

else
  # Bare metal / VM installation
  PIHOLE_WEB="/var/www/html/admin"
  echo "Detected host installation (no Docker container named '$CONTAINER_NAME')"

  if [ -d "$PIHOLE_WEB" ]; then
    sudo mkdir -p "$PIHOLE_WEB/scripts/lua"
    sudo ln -sfn "$MOD_DIR/i18n.lp" "$PIHOLE_WEB/scripts/lua/i18n.lp"
    sudo ln -sfn "$MOD_DIR/locales" "$PIHOLE_WEB/scripts/lua/locales"
    echo "Symlinks created in $PIHOLE_WEB"
  else
    echo "Warning: Pi-hole web directory not found at $PIHOLE_WEB"
    echo "Files installed only to $MOD_DIR"
  fi

  echo ""
  echo "Installation complete."
  echo "Mod files are in: $MOD_DIR"
fi

echo ""
echo "To uninstall: sudo rm -rf $MOD_DIR"
