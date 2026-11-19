# Pi-hole i18n Mod with Docker

## Install (Docker)

```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install-docker.sh

# Default container name is "pihole"
sudo ./install-docker.sh

# Or if your container has another name:
PIHOLE_CONTAINER=my-pihole sudo ./install-docker.sh
```

## Update (Docker)

```bash
sudo ./update-docker.sh

# Or with custom container name:
PIHOLE_CONTAINER=my-pihole sudo ./update-docker.sh
```

## Recommended: Mount as volume (best persistence)

In your `docker-compose.yml` add:

```yaml
services:
  pihole:
    volumes:
      - /opt/pihole-i18n:/opt/pihole-i18n:ro
      # Then create symlinks inside the container or copy on start
```

Alternatively, after install you can re-run `install-docker.sh` whenever the container is recreated.

## Automatic updates (cron on the host)

```bash
# Copy updater
sudo cp update-docker.sh /opt/pihole-i18n/update-docker.sh
sudo chmod +x /opt/pihole-i18n/update-docker.sh

# Add to crontab
sudo crontab -e
```

```cron
0 3 * * * PIHOLE_CONTAINER=pihole /opt/pihole-i18n/update-docker.sh >> /var/log/pihole-i18n-update.log 2>&1
```

## Notes

- Files are copied into the running container.
- If you recreate the container, re-run the installer or use a volume mount.
- Host copy is always kept in `/opt/pihole-i18n`.
