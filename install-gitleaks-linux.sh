#!/bin/bash

set -e

echo "[INFO] Detecting platform..."
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')

install_linux() {
  echo "[INFO] Installing Gitleaks on Linux..."

  GITLEAKS_VERSION=$(curl -s "https://api.github.com/repos/gitleaks/gitleaks/releases/latest" \
    | grep -Po '"tag_name": "v\K[0-9.]+' || echo "8.18.1")

  wget -qO gitleaks.tar.gz \
    "https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz"
  tar -xzf gitleaks.tar.gz
  sudo mv gitleaks /usr/local/bin/
  sudo chmod +x /usr/local/bin/gitleaks
  rm gitleaks.tar.gz

  echo "[✔] Gitleaks installed:"
  gitleaks version
}

install_mac() {
  echo "[INFO] Installing Gitleaks on macOS..."
  if ! command -v brew >/dev/null 2>&1; then
    echo "[ERROR] Homebrew not found. Install it from https://brew.sh"
    exit 1
  fi
  brew install gitleaks
  echo "[✔] Gitleaks installed:"
  gitleaks version
}

if [[ "$PLATFORM" == "linux" ]]; then
  install_linux
elif [[ "$PLATFORM" == "darwin" ]]; then
  install_mac
else
  echo "[❌] Unsupported OS: $PLATFORM"
  echo "Use Docker or manual install for this platform."
  exit 1
fi
