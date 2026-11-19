# Offline Automatic Translation Options for Pi-hole i18n

Several ways to generate / update Spanish and Hindi translations without internet (after models are downloaded).

## Comparison

| Method                  | RAM     | Quality | Ease | Best for                  |
|-------------------------|---------|---------|------|---------------------------|
| Argos Translate         | Medium  | Medium  | High | Quick setup               |
| CTranslate2 (int8)      | Low     | Medium  | Med  | Raspberry Pi / low RAM    |
| Marian / OPUS-MT        | Low-Med | Medium+ | Med  | Good quality/speed        |
| LibreTranslate local    | High    | Medium  | High | If you already use it     |
| Manual + review         | None    | High    | -    | Final quality             |

## Option 1: Argos Translate (recommended starting point)
```bash
pip install argostranslate
python tools/install_argos.py
python tools/translate.py
```

**Real-time demo:**
```bash
python tools/realtime_demo.py
```

## Option 2: CTranslate2 + quantized models (lowest RAM)
See `tools/translate_ctranslate2.py` and `docs/ctranslate2-setup.md`

## Option 3: LibreTranslate local (with optimizations)
See `docs/libretranslate.md`

## Option 4: Direct Marian / OPUS-MT
See **[docs/marian-nmt.md](marian-nmt.md)** for models, conversion and usage examples.

## Example outputs
See **[examples/output-examples.md](../examples/output-examples.md)**

## Workflow recommendation
1. Generate with Argos or CTranslate2
2. Review and fix the JSON files manually
3. Commit the reviewed translations
4. English remains the source of truth
