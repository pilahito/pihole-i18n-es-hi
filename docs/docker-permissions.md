# Docker Permissions Guide

## Quick diagnostic

```bash
chmod +x check-docker-permissions.sh
./check-docker-permissions.sh
```

## Fix: Allow Docker without sudo

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Log out and back in (or reboot) if `newgrp` is not enough.

Verify:

```bash
docker ps
```

## Fix mod directory permissions

```bash
sudo mkdir -p /opt/pihole-i18n
sudo chown -R $USER:$USER /opt/pihole-i18n
sudo chmod -R 755 /opt/pihole-i18n
```

## Common errors

| Error | Solution |
|-------|----------|
| `permission denied while trying to connect to the Docker daemon` | Add user to `docker` group |
| `Container not found` | Check name with `docker ps` and set `PIHOLE_CONTAINER` |
| `No such file or directory` when copying | Make sure the container is running |

## Full setup with correct permissions

```bash
# 1. Fix Docker permissions
sudo usermod -aG docker $USER
newgrp docker

# 2. Clone and install
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install.sh setup-auto-update.sh check-docker-permissions.sh
./check-docker-permissions.sh
./install.sh
./setup-auto-update.sh
```
