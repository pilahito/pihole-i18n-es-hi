#!/bin/bash
# Update Pi-hole i18n mod from GitHub
# Automatically detects Docker and updates inside the container if present.

set -e

REPO_URL="https://github.com/pilahito/pihole-i18n-es-hi.git"
MOD_DIR="/opt/pihole-i18n"
TMP_DIR="/tmp/pihole-i18n-update"
CONTAINER_NAME="${PIHOLE_CONTAINER:-pihole}"

echo "=== Updating Pi-hole i18n mod ==="

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
git clone --depth 1 "$REPO_URL" "$TMP_DIR"

# Update host copy
sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$TMP_DIR/scripts/lua/locales/"* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$TMP_DIR/scripts/lua/i18n.lp" "$MOD_DIR/i18n.lp" 2>/dev/null || true

rm -rf "$TMP_DIR"

# If Docker container is running, also update inside it
if command -v docker >/dev/null 2>&1 && docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Detected Docker container '$CONTAINER_NAME' — updating inside container..."
  docker exec "$CONTAINER_NAME" mkdir -p /var/www/html/admin/scripts/lua/locales
  docker cp "$MOD_DIR/i18n.lp" "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/i18n.lp
  docker cp "$MOD_DIR/locales/." "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/locales/
  echo "Container updated."
else
  echo "No running Docker container named '$CONTAINER_NAME' detected."
  echo "Host files updated in $MOD_DIR"
fi

echo "Update complete."
