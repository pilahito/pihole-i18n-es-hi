# CTranslate2 Setup (low RAM)

## 1. Install dependencies
```bash
pip install ctranslate2 sentencepiece
```

## 2. Get models

### Download pre-converted (easiest)
Look for OPUS-MT models already converted to CTranslate2 on Hugging Face or community repos.

### Convert yourself
```bash
pip install ctranslate2 transformers sentencepiece

# Example for en-es (adjust model name)
ct2-transformers-converter \
  --model Helsinki-NLP/opus-mt-en-es \
  --output_dir models/en-es \
  --quantization int8 \
  --force
```

Repeat for Hindi (`Helsinki-NLP/opus-mt-en-hi` or similar).

## 3. Expected structure
```
models/
  en-es/
    model.bin
    source.spm
    target.spm
    config.json
  en-hi/
    ...
```

## 4. Run
```bash
python tools/translate_ctranslate2.py
```

### Recommended inference settings (already in the script)
- `compute_type="int8"`
- `inter_threads=1`
- `intra_threads=1`
- `beam_size=1`
