# Translation Tools

## Quick start

### Argos (easiest)
```bash
pip install -r ../requirements.txt
python install_argos.py
python translate.py
```

### CTranslate2 (lightest)
```bash
# First prepare models (see docs/ctranslate2-setup.md)
python translate_ctranslate2.py
```

## Files
- `translate.py` → Argos Translate backend
- `translate_ctranslate2.py` → CTranslate2 backend (int8)
- `install_argos.py` → Download Argos models
