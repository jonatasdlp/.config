#!/usr/bin/env bash

set -euo pipefail

STARTUP_DIR="$HOME/.config/startup"
BREW_RC="$STARTUP_DIR/.brewrc"
NPM_RC="$STARTUP_DIR/.npm-globalrc"
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

is_safe_brew_package() {
  [[ "$1" =~ ^[A-Za-z0-9@._+-]+(/[A-Za-z0-9@._+-]+)*$ ]]
}

is_safe_tap_spec() {
  [[ "$1" =~ ^[A-Za-z0-9._-]+/[A-Za-z0-9._-]+$ ]]
}

is_safe_npm_spec() {
  [[ "$1" =~ ^(@[A-Za-z0-9._-]+/)?[A-Za-z0-9._-]+(@[A-Za-z0-9._-]+)?$ ]]
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  if ! command -v curl >/dev/null 2>&1; then
    echo "[deps] Erro: curl nao encontrado para instalar Homebrew." >&2
    exit 1
  fi

  echo "[deps] Homebrew nao encontrado. Instalando..."

  installer_path="$(mktemp)"
  curl --proto '=https' --tlsv1.2 --fail --silent --show-error --location "$HOMEBREW_INSTALL_URL" -o "$installer_path"
  NONINTERACTIVE=1 /bin/bash "$installer_path"
  rm -f "$installer_path"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "[deps] Erro: brew nao encontrado apos instalacao." >&2
    exit 1
  fi
}

install_taps() {
  if [[ ! -f "$BREW_RC" ]]; then
    echo "[deps] Arquivo nao encontrado: $BREW_RC"
    return
  fi

  echo "[deps] Processando taps de $BREW_RC"
  while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
    line="${raw_line%%#*}"
    line="${line%${line##*[![:space:]]}}"
    line="${line#${line%%[![:space:]]*}}"

    [[ -z "$line" ]] && continue

    case "$line" in
      tap:*)
        tap="${line#tap:}"
        if ! is_safe_tap_spec "$tap"; then
          echo "- tap invalido, ignorando: $tap"
          continue
        fi
        if brew tap | grep -qx "$tap"; then
          echo "- tap ok: $tap"
        else
          echo "- adicionando tap: $tap"
          HOMEBREW_NO_AUTO_UPDATE=1 brew tap "$tap"
        fi
        ;;
    esac
  done < "$BREW_RC"
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
        if ! is_safe_brew_package "$pkg"; then
          echo "- formula invalida, ignorando: $pkg"
          continue
        fi
        if brew list --formula "$pkg" >/dev/null 2>&1; then
          echo "- formula ok: $pkg"
        else
          echo "- instalando formula: $pkg"
          HOMEBREW_NO_AUTO_UPDATE=1 brew install "$pkg"
        fi
        ;;
      cask:*)
        pkg="${line#cask:}"
        if ! is_safe_brew_package "$pkg"; then
          echo "- cask invalido, ignorando: $pkg"
          continue
        fi
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

    if ! is_safe_npm_spec "$spec"; then
      echo "- npm spec invalido, ignorando: $spec"
      continue
    fi

    echo "- npm install -g $spec"
    npm install -g -- "$spec"
  done < "$NPM_RC"
}

main() {
  ensure_homebrew
  install_taps
  install_brew_packages
  install_npm_global_packages
  echo "[deps] concluido"
}

main "$@"
