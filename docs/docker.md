# Pi-hole i18n Mod with Docker

The main scripts (`install.sh` and `update.sh`) **automatically detect** if Pi-hole is running in Docker.

## Install (works for Docker and bare metal)

```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install.sh
sudo ./install.sh
```

If your container is not named `pihole`:

```bash
PIHOLE_CONTAINER=my-pihole sudo ./install.sh
```

## Update

```bash
sudo ./update.sh

# or with custom container name
PIHOLE_CONTAINER=my-pihole sudo ./update.sh
```

## How it works

1. Always keeps a copy on the host in `/opt/pihole-i18n`
2. If it finds a running Docker container named `pihole` (or the name you set), it copies the files inside the container
3. If no container is found, it uses symlinks on the host (classic installation)

## Recommended for long-term Docker use

Mount the mod directory as a volume in your `docker-compose.yml` so it survives container recreation:

```yaml
services:
  pihole:
    volumes:
      - /opt/pihole-i18n:/opt/pihole-i18n:ro
```

Then you only need to re-create the symlinks or copy once after recreating the container.

## Automatic updates (cron)

```bash
sudo cp update.sh /opt/pihole-i18n/update.sh
sudo chmod +x /opt/pihole-i18n/update.sh

sudo crontab -e
```

```cron
0 3 * * * PIHOLE_CONTAINER=pihole /opt/pihole-i18n/update.sh >> /var/log/pihole-i18n-update.log 2>&1
```
