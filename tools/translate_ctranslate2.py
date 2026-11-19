#!/usr/bin/env python3
"""
Auto-translate missing keys using CTranslate2 + quantized OPUS-MT models (lighter RAM).

Requirements:
    pip install ctranslate2 sentencepiece

You need the converted models locally. Example structure:
    models/
      en-es/
        model.bin
        source.spm
        target.spm
      en-hi/
        ...

Download / convert models once (can be done on a machine with more RAM):
  - OPUS-MT models: https://github.com/Helsinki-NLP/Opus-MT
  - Convert with: ct2-opus-mt-converter or ctranslate2-converter
"""

import json
from pathlib import Path

import ctranslate2
import sentencepiece as spm

LOCALES_DIR = Path("scripts/lua/locales")
SOURCE = "en.json"
TARGETS = ["es", "hi"]
MODELS_DIR = Path("models")   # change if needed

def load_model(lang):
    model_path = MODELS_DIR / f"en-{lang}"
    if not model_path.exists():
        raise FileNotFoundError(f"Model not found: {model_path}")
    translator = ctranslate2.Translator(str(model_path), device="cpu", compute_type="int8", inter_threads=1, intra_threads=1)
    sp_source = spm.SentencePieceProcessor(model_file=str(model_path / "source.spm"))
    sp_target = spm.SentencePieceProcessor(model_file=str(model_path / "target.spm"))
    return translator, sp_source, sp_target

def translate(text, target):
    if not text or not str(text).strip():
        return text
    try:
        translator, sp_src, sp_tgt = load_model(target)
        tokens = sp_src.encode(text, out_type=str)
        results = translator.translate_batch([tokens], beam_size=1)
        translated_tokens = results[0].hypotheses[0]
        return sp_tgt.decode(translated_tokens)
    except Exception as e:
        print(f"  Error ({target}): {e}")
        return text

def main():
    source_path = LOCALES_DIR / SOURCE
    with open(source_path, encoding="utf-8") as f:
        source = json.load(f)

    for lang in TARGETS:
        target_path = LOCALES_DIR / f"{lang}.json"
        target = {}
        if target_path.exists():
            with open(target_path, encoding="utf-8") as f:
                target = json.load(f)

        updated = False
        for key, english in source.items():
            if key not in target or not str(target[key]).strip():
                print(f"[{lang}] {key}")
                target[key] = translate(english, lang)
                updated = True

        if updated:
            with open(target_path, "w", encoding="utf-8") as f:
                json.dump(target, f, ensure_ascii=False, indent=2)
            print(f"Updated {target_path}")

if __name__ == "__main__":
    main()
