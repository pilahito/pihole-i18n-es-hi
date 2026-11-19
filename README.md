# Pi-hole Web i18n (Spanish + Hindi)

Lightweight, maintainable internationalization system for the Pi-hole web interface.

## Features
- JSON locale files (`en`, `es`, `hi`)
- Lua helper (`t(key)` function)
- Cookie-based language persistence
- Fallback to English
- Multiple **100% offline** auto-translation options
- **Persistent mod installer** (survives Pi-hole updates)
- **Docker support**

## Structure
```
scripts/lua/i18n.lp
scripts/lua/locales/{en,es,hi}.json
tools/...
docs/docker.md                      # Docker guide
docs/install-as-mod.md
docs/auto-update.md
install.sh                          # Bare metal / VM
install-docker.sh                   # Docker
update.sh / update-docker.sh
```

## Install

### Bare metal / VM
```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install.sh
sudo ./install.sh
```

### Docker
```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install-docker.sh
sudo ./install-docker.sh
# or: PIHOLE_CONTAINER=my-pihole sudo ./install-docker.sh
```

See **[docs/docker.md](docs/docker.md)** for full Docker instructions and automatic updates.

## Usage in templates
```lua
<?=t("dashboard")?>
```

## Offline auto-translation options

See **[docs/translation-options.md](docs/translation-options.md)**.

---

This is a community proposal for https://github.com/pi-hole/pi-hole/issues/3123

**Note:** English remains the source of truth. Always review machine translations before merging.
