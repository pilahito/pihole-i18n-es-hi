#!/usr/bin/env python3
"""
Auto-translate missing keys in Pi-hole locale files using Argos Translate (100% offline).

Requirements:
    pip install argostranslate

First time only (needs internet once to download models):
    python tools/translate.py --install
"""

import argparse
import json
from pathlib import Path

import argostranslate.package
import argostranslate.translate

LOCALES_DIR = Path("scripts/lua/locales")
SOURCE = "en.json"
TARGETS = ["es", "hi"]

def install_models():
    print("Updating package index and installing models (requires internet once)...")
    argostranslate.package.update_package_index()
    available = argostranslate.package.get_available_packages()
    for target in TARGETS:
        pkg = next((p for p in available if p.from_code == "en" and p.to_code == target), None)
        if pkg:
            print(f"Installing en → {target}")
            argostranslate.package.install_from_path(pkg.download())
        else:
            print(f"No package found for en → {target}")
    print("Models installed.")

def get_translator(target_code):
    installed = argostranslate.translate.get_installed_languages()
    from_lang = next((l for l in installed if l.code == "en"), None)
    to_lang = next((l for l in installed if l.code == target_code), None)
    if not from_lang or not to_lang:
        raise RuntimeError(f"Language pair en→{target_code} not installed. Run with --install first.")
    return from_lang.get_translation(to_lang)

def translate(text, target):
    if not text or not str(text).strip():
        return text
    try:
        translator = get_translator(target)
        return translator.translate(text)
    except Exception as e:
        print(f"  Error translating to {target}: {e}")
        return text

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--install", action="store_true", help="Download and install language models")
    args = parser.parse_args()

    if args.install:
        install_models()
        return

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
