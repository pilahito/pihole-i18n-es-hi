#!/bin/bash
# Enable automatic daily updates for the Pi-hole i18n mod

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
UPDATE_SCRIPT="/opt/pihole-i18n/update.sh"
CRON_JOB="0 3 * * * $UPDATE_SCRIPT >> /var/log/pihole-i18n-update.log 2>&1"

echo "=== Setting up automatic updates ==="

# Copy the update script to the permanent location
sudo mkdir -p /opt/pihole-i18n
sudo cp "$SCRIPT_DIR/update.sh" "$UPDATE_SCRIPT"
sudo chmod +x "$UPDATE_SCRIPT"

# Install cron job (avoid duplicates)
(crontab -l 2>/dev/null | grep -v "pihole-i18n"; echo "$CRON_JOB") | crontab -

echo ""
echo "Automatic updates enabled."
echo "The mod will update every day at 3:00 AM."
echo "Log file: /var/log/pihole-i18n-update.log"
echo ""
echo "To check the cron job:"
echo "  crontab -l"
echo ""
echo "To disable:"
echo "  crontab -l | grep -v pihole-i18n | crontab -"
