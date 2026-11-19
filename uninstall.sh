#!/bin/bash
# Uninstall Pi-hole i18n mod

PIHOLE_WEB="/var/www/html/admin"
MOD_DIR="/opt/pihole-i18n"

echo "Removing Pi-hole i18n mod..."

sudo rm -rf "$MOD_DIR"
sudo rm -f "$PIHOLE_WEB/scripts/lua/i18n.lp"
sudo rm -rf "$PIHOLE_WEB/scripts/lua/locales"

echo "Uninstall complete."
