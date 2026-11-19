# Pi-hole Web i18n (Spanish + Hindi)

Lightweight, maintainable internationalization system for the Pi-hole web interface.

## Features
- JSON locale files (`en`, `es`, `hi`)
- Lua helper (`t(key)` function)
- Cookie-based language persistence
- Fallback to English
- Optional **100% offline** auto-translation

## Structure
```
scripts/lua/i18n.lp
scripts/lua/locales/en.json
scripts/lua/locales/es.json
scripts/lua/locales/hi.json
tools/translate.py                  # Argos Translate (simple)
tools/translate_ctranslate2.py      # CTranslate2 (lighter RAM)
docs/libretranslate.md
```

## Usage in templates
```lua
<?=t("dashboard")?>
```

## Offline auto-translation (choose one)

### Option A: Argos Translate (recommended for simplicity)
```bash
pip install argostranslate
python tools/translate.py --install   # only once
python tools/translate.py
```

### Option B: CTranslate2 (lower RAM, better for Raspberry Pi)
1. Place quantized models in `models/en-es/` and `models/en-hi/`
2. `pip install ctranslate2 sentencepiece`
3. `python tools/translate_ctranslate2.py`

This is a community proposal for https://github.com/pi-hole/pi-hole/issues/3123

**Note:** English remains the source of truth. Always review machine translations before merging.
