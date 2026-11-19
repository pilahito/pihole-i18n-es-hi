# Automatic Updates for Pi-hole i18n Mod

## Manual update

```bash
cd /path/to/pihole-i18n-es-hi
sudo ./update.sh
```

Or from anywhere (if the script is in PATH):

```bash
sudo /opt/pihole-i18n/update.sh
```

## Automatic updates with cron (recommended)

Edit the crontab:

```bash
sudo crontab -e
```

Add one of these lines:

```cron
# Update every day at 3:00 AM
0 3 * * * /opt/pihole-i18n/update.sh >> /var/log/pihole-i18n-update.log 2>&1

# Update every Sunday at 4:00 AM
0 4 * * 0 /opt/pihole-i18n/update.sh >> /var/log/pihole-i18n-update.log 2>&1
```

## Install the update script permanently

After running `install.sh`, you can also copy the updater:

```bash
sudo cp update.sh /opt/pihole-i18n/update.sh
sudo chmod +x /opt/pihole-i18n/update.sh
```

## Notes

- The update only refreshes the locale files and `i18n.lp`.
- Symlinks created by `install.sh` remain valid.
- Check `/var/log/pihole-i18n-update.log` if something fails.
- You can disable automatic updates by removing the cron line.
