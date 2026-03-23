#!/usr/bin/env bash

set -euo pipefail

STARTUP_DIR="$HOME/.config/startup"
BREW_RC="$STARTUP_DIR/.brewrc"
NPM_RC="$STARTUP_DIR/.npm-globalrc"

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  echo "[deps] Homebrew nao encontrado. Instalando..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "[deps] Erro: brew nao encontrado apos instalacao." >&2
    exit 1
  fi
}

install_brew_packages() {
  if [[ ! -f "$BREW_RC" ]]; then
    echo "[deps] Arquivo nao encontrado: $BREW_RC"
    return
  fi

  echo "[deps] Instalando pacotes Homebrew de $BREW_RC"
  while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
    line="${raw_line%%#*}"
    line="${line%${line##*[![:space:]]}}"
    line="${line#${line%%[![:space:]]*}}"

    [[ -z "$line" ]] && continue

    case "$line" in
      formula:*)
        pkg="${line#formula:}"
        if brew list --formula "$pkg" >/dev/null 2>&1; then
          echo "- formula ok: $pkg"
        else
          echo "- instalando formula: $pkg"
          HOMEBREW_NO_AUTO_UPDATE=1 brew install "$pkg"
        fi
        ;;
      cask:*)
        pkg="${line#cask:}"
        if brew list --cask "$pkg" >/dev/null 2>&1; then
          echo "- cask ok: $pkg"
        else
          echo "- instalando cask: $pkg"
          HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "$pkg"
        fi
        ;;
      *)
        echo "- ignorando linha invalida: $line"
        ;;
    esac
  done < "$BREW_RC"
}

install_npm_global_packages() {
  if [[ ! -f "$NPM_RC" ]]; then
    echo "[deps] Arquivo nao encontrado: $NPM_RC"
    return
  fi

  if ! command -v npm >/dev/null 2>&1; then
    echo "[deps] npm nao encontrado. Ignorando npm globals."
    return
  fi

  echo "[deps] Instalando npm globals de $NPM_RC"
  while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
    spec="${raw_line%%#*}"
    spec="${spec%${spec##*[![:space:]]}}"
    spec="${spec#${spec%%[![:space:]]*}}"

    [[ -z "$spec" ]] && continue

    echo "- npm install -g $spec"
    npm install -g "$spec"
  done < "$NPM_RC"
}

main() {
  ensure_homebrew
  install_brew_packages
  install_npm_global_packages
  echo "[deps] concluido"
}

main "$@"
