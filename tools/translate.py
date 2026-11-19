#!/usr/bin/env python3
"""
Auto-translate missing keys in Pi-hole locale files using local LibreTranslate.
"""

import json
import requests
from pathlib import Path

LOCALES_DIR = Path("scripts/lua/locales")
SOURCE = "en.json"
TARGETS = ["es", "hi"]

# Change this to your local LibreTranslate instance
API_URL = "http://localhost:5000/translate"

def translate(text, target):
    if not text or not text.strip():
        return text
    try:
        r = requests.post(API_URL, json={
            "q": text,
            "source": "en",
            "target": target,
            "format": "text"
        }, timeout=20)
        r.raise_for_status()
        return r.json().get("translatedText", text)
    except Exception as e:
        print(f"  Error: {e}")
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
