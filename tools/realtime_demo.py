#!/usr/bin/env python3
"""
Simple real-time translation demo using Argos Translate.
Type text and see the translation immediately.
"""

import argostranslate.translate

def get_translator(target="es"):
    installed = argostranslate.translate.get_installed_languages()
    from_lang = next((l for l in installed if l.code == "en"), None)
    to_lang = next((l for l in installed if l.code == target), None)
    if not from_lang or not to_lang:
        print(f"Language pair en→{target} not installed. Run: python tools/install_argos.py")
        return None
    return from_lang.get_translation(to_lang)

def main():
    print("Real-time translation demo (Argos Translate)")
    print("Type 'quit' to exit, 'es' or 'hi' to change target language\n")

    target = "es"
    translator = get_translator(target)
    if not translator:
        return

    while True:
        try:
            text = input(f"[en→{target}] > ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nBye!")
            break

        if not text:
            continue
        if text.lower() == "quit":
            break
        if text.lower() in ("es", "hi"):
            target = text.lower()
            translator = get_translator(target)
            if translator:
                print(f"Switched to {target}")
            continue

        if translator:
            result = translator.translate(text)
            print(f"  → {result}\n")

if __name__ == "__main__":
    main()
