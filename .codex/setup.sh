#!/usr/bin/env bash
set -euo pipefail

# ---------- system packages ----------
sudo apt-get update -y
sudo apt-get install -y \
  curl git unzip xz-utils zip libglu1-mesa \
  clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev :contentReference[oaicite:0]{index=0}

# ---------- download Flutter SDK ----------
FLUTTER_VERSION="3.22.1"
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
  | tar -xJ
export PATH="$PWD/flutter/bin:$PATH"

# ---------- precache & doctor ----------
flutter config --enable-linux-desktop
flutter doctor -v

# ---------- restore project deps ----------
flutter pub get
