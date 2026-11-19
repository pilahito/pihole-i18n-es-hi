#!/bin/bash
# Install automatic daily updates via cron

UPDATE_SCRIPT="/opt/pihole-i18n/update.sh"
CRON_JOB="0 3 * * * $UPDATE_SCRIPT >> /var/log/pihole-i18n-update.log 2>&1"

echo "Installing automatic update cron job..."

# Make sure update script exists
if [ ! -f "$UPDATE_SCRIPT" ]; then
  echo "Error: $UPDATE_SCRIPT not found. Run install.sh first."
  exit 1
fi

# Add cron job if not already present
(crontab -l 2>/dev/null | grep -v "pihole-i18n"; echo "$CRON_JOB") | crontab -

echo "Cron job installed:"
echo "$CRON_JOB"
echo ""
echo "Updates will run every day at 3:00 AM."
echo "Log: /var/log/pihole-i18n-update.log"
