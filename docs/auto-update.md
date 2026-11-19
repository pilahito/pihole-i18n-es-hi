# Automatic Updates for Pi-hole i18n Mod

## One-command setup (recommended)

```bash
cd pihole-i18n-es-hi
chmod +x setup-auto-update.sh
sudo ./setup-auto-update.sh
```

This will:
- Copy `update.sh` to `/opt/pihole-i18n/`
- Add a daily cron job (3:00 AM)
- Log output to `/var/log/pihole-i18n-update.log`

## Manual update

```bash
sudo ./update.sh
```

## Check or remove automatic updates

```bash
# See current cron jobs
crontab -l

# Disable automatic updates
crontab -l | grep -v pihole-i18n | crontab -
```

## Custom schedule

Edit the crontab manually:

```bash
crontab -e
```

Examples:

```cron
# Every day at 3:00 AM
0 3 * * * /opt/pihole-i18n/update.sh >> /var/log/pihole-i18n-update.log 2>&1

# Every Sunday at 4:00 AM
0 4 * * 0 /opt/pihole-i18n/update.sh >> /var/log/pihole-i18n-update.log 2>&1
```

## Notes

- Works with both bare metal and Docker (the update script auto-detects Docker).
- Only updates the locale files and `i18n.lp`.
- Safe to run multiple times.
