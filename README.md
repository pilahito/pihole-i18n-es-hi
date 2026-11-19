# Pi-hole Web i18n (Spanish + Hindi)

Lightweight, maintainable internationalization system for the Pi-hole web interface.

## Features
- JSON locale files (`en`, `es`, `hi`)
- Lua helper (`t(key)` function)
- Cookie-based language persistence
- Fallback to English
- Multiple **100% offline** auto-translation options

## Structure
```
scripts/lua/i18n.lp
scripts/lua/locales/{en,es,hi}.json
tools/translate.py                  # Argos Translate
tools/translate_ctranslate2.py      # CTranslate2 (int8)
tools/install_argos.py
tools/realtime_demo.py              # Real-time interactive demo
docs/translation-options.md         # Comparison of all methods
docs/marian-nmt.md                 # Marian NMT / OPUS-MT guide
docs/ctranslate2-setup.md
docs/libretranslate.md
examples/output-examples.md         # Sample translations
requirements.txt
```

## Usage in templates
```lua
<?=t("dashboard")?>
```

## Offline auto-translation options

See **[docs/translation-options.md](docs/translation-options.md)** for a full comparison.

### Quick start (Argos – simplest)
```bash
pip install -r requirements.txt
python tools/install_argos.py
python tools/translate.py
```

### Real-time interactive demo
```bash
python tools/realtime_demo.py
```

### Marian NMT / OPUS-MT
See [docs/marian-nmt.md](docs/marian-nmt.md)

### Lowest RAM (CTranslate2)
See [docs/ctranslate2-setup.md](docs/ctranslate2-setup.md)

### Example outputs
See [examples/output-examples.md](examples/output-examples.md)

---

This is a community proposal for https://github.com/pi-hole/pi-hole/issues/3123

**Note:** English remains the source of truth. Always review machine translations before merging.
