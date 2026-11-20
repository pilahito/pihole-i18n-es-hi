# Pi-hole Web i18n (Spanish + Hindi)

Lightweight, maintainable internationalization system for the Pi-hole web interface.

## Cobertura del español

 trae **618 cadenas**: el menú, los botones, los
estados y los ajustes del panel de Pi-hole v6 (extraídas de las plantillas
). Las que falten se quedan en inglés (fallback).

## Features
- JSON locale files (`en`, `es`, `hi`)
- Lua helper (`t(key)` function)
- Cookie-based language persistence
- Fallback to English
- Multiple **100% offline** auto-translation options
- **Persistent mod installer** (survives Pi-hole updates)
- **Automatic Docker detection**
- **Pi-hole CLI wrapper** for Docker
- Docker permissions diagnostic
- **DNS-over-HTTPS (DoH) guide**

## Install (works on bare metal **and** Docker)

```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install.sh check-docker-permissions.sh
./check-docker-permissions.sh
sudo ./install.sh
```

## DNS-over-HTTPS (DoH)

See **[docs/dns-over-https.md](docs/dns-over-https.md)** for a complete guide using cloudflared.

## Docker permissions

```bash
./check-docker-permissions.sh
```

## Use Pi-hole commands from the host (Docker)

```bash
chmod +x pihole-docker
./pihole-docker -c
./pihole-docker status
```

## Update

```bash
sudo ./update.sh
```

## Usage in templates
```lua
<?=t("dashboard")?>
```

## Offline auto-translation options

See **[docs/translation-options.md](docs/translation-options.md)**.

---

This is a community proposal for https://github.com/pi-hole/pi-hole/issues/3123

**Note:** English remains the source of truth. Always review machine translations before merging.
