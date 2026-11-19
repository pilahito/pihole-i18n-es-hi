#!/bin/bash
# Pi-hole i18n Mod Installer (Docker support)
# Works with official Pi-hole Docker container

set -e

CONTAINER_NAME="${PIHOLE_CONTAINER:-pihole}"
MOD_DIR="/opt/pihole-i18n"
LOCALES_SRC="$(dirname "$0")/scripts/lua/locales"
I18N_SRC="$(dirname "$0")/scripts/lua/i18n.lp"

echo "=== Pi-hole i18n Mod Installer (Docker) ==="
echo "Container: $CONTAINER_NAME"

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: Container '$CONTAINER_NAME' is not running."
  echo "Set PIHOLE_CONTAINER=your_container_name if different."
  exit 1
fi

# Create persistent mod directory on host
sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$LOCALES_SRC"/* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$I18N_SRC" "$MOD_DIR/i18n.lp" 2>/dev/null || true

# Copy into the container (Pi-hole web is usually at /var/www/html/admin)
echo "Copying files into container..."
docker cp "$MOD_DIR/i18n.lp" "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/i18n.lp
docker exec "$CONTAINER_NAME" mkdir -p /var/www/html/admin/scripts/lua/locales
docker cp "$MOD_DIR/locales/." "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/locales/

echo ""
echo "Installation complete inside container '$CONTAINER_NAME'."
echo "Host copy kept at: $MOD_DIR"
echo ""
echo "Note: After container recreation you may need to re-run this script"
echo "or mount $MOD_DIR as a volume."
