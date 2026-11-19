# Pi-hole Web i18n (Spanish + Hindi)

Lightweight, maintainable internationalization system for the Pi-hole web interface.

## Features
- JSON locale files (`en`, `es`, `hi`)
- Lua helper (`t(key)` function)
- Cookie-based language persistence
- Fallback to English
- Optional auto-translation via local LibreTranslate

## Structure
```
scripts/lua/i18n.lp
scripts/lua/locales/en.json
scripts/lua/locales/es.json
scripts/lua/locales/hi.json
tools/translate.py
docs/libretranslate.md
```

## Usage in templates
```lua
<?=t("dashboard")?>
```

## Auto-translation (optional, local)
1. Run LibreTranslate locally (see `docs/libretranslate.md`)
2. `python tools/translate.py`

This is a community proposal for https://github.com/pi-hole/pi-hole/issues/3123

**Note:** English remains the source of truth. Machine translations should be reviewed before merging.
