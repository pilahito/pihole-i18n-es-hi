# Install as a persistent mod (survives Pi-hole updates)

This method installs the i18n files outside the Pi-hole directory and uses symlinks, so they are not overwritten when you update Pi-hole.

## Quick install

```bash
git clone https://github.com/pilahito/pihole-i18n-es-hi.git
cd pihole-i18n-es-hi
chmod +x install.sh
sudo ./install.sh
```

## What it does

1. Copies files to `/opt/pihole-i18n/` (persistent location)
2. Creates symlinks inside `/var/www/html/admin/scripts/lua/`
3. When Pi-hole updates, the symlinks usually remain or can be recreated easily

## Uninstall

```bash
sudo ./uninstall.sh
```

## Manual reinstall after major Pi-hole update

If the symlinks disappear after a big update:

```bash
sudo ./install.sh
```

## Notes

- English remains the fallback.
- You still need to include `i18n.lp` in the templates that should be translated (or patch them).
- This is a community mod approach — not an official Pi-hole feature.
