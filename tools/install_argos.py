#!/usr/bin/env python3
"""Helper to download and install Argos Translate models for en-es and en-hi."""

import argostranslate.package

TARGETS = ["es", "hi"]

def main():
    print("Updating package index...")
    argostranslate.package.update_package_index()
    available = argostranslate.package.get_available_packages()

    for target in TARGETS:
        pkg = next((p for p in available if p.from_code == "en" and p.to_code == target), None)
        if pkg:
            print(f"Installing en → {target}...")
            argostranslate.package.install_from_path(pkg.download())
            print(f"  Done.")
        else:
            print(f"No package found for en → {target}")

    print("\nInstalled languages:")
    for lang in argostranslate.translate.get_installed_languages():
        print(f"  - {lang.code} ({lang.name})")

if __name__ == "__main__":
    main()
