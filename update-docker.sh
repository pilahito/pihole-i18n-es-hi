#!/bin/bash
# Update Pi-hole i18n mod inside Docker container

set -e

CONTAINER_NAME="${PIHOLE_CONTAINER:-pihole}"
REPO_URL="https://github.com/pilahito/pihole-i18n-es-hi.git"
MOD_DIR="/opt/pihole-i18n"
TMP_DIR="/tmp/pihole-i18n-update"

echo "=== Updating Pi-hole i18n mod (Docker) ==="

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: Container '$CONTAINER_NAME' is not running."
  exit 1
fi

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
git clone --depth 1 "$REPO_URL" "$TMP_DIR"

sudo mkdir -p "$MOD_DIR/locales"
sudo cp -r "$TMP_DIR/scripts/lua/locales/"* "$MOD_DIR/locales/" 2>/dev/null || true
sudo cp "$TMP_DIR/scripts/lua/i18n.lp" "$MOD_DIR/i18n.lp" 2>/dev/null || true

# Push updated files into the container
docker cp "$MOD_DIR/i18n.lp" "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/i18n.lp
docker exec "$CONTAINER_NAME" mkdir -p /var/www/html/admin/scripts/lua/locales
docker cp "$MOD_DIR/locales/." "$CONTAINER_NAME":/var/www/html/admin/scripts/lua/locales/

rm -rf "$TMP_DIR"

echo "Update complete inside container '$CONTAINER_NAME'."
