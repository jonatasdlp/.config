#!/usr/bin/env bash

set -euo pipefail

echo "[startup] preparando diretorios base"
mkdir -p "$HOME/Developer"
mkdir -p "$HOME/.config/tmux/scripts"
mkdir -p "$HOME/.config/startup"

INSTALL_DEPS_SCRIPT="$HOME/.config/startup/install_deps.sh"

echo "[startup] validando comandos essenciais"
for cmd in tmux nvim git; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "- ok: $cmd"
  else
    echo "- faltando: $cmd"
  fi
done

if [[ "${1:-}" == "--with-deps" ]]; then
  if [[ -x "$INSTALL_DEPS_SCRIPT" ]]; then
    echo "[startup] executando instalacao de dependencias"
    "$INSTALL_DEPS_SCRIPT"
  else
    echo "[startup] script nao encontrado/executavel: $INSTALL_DEPS_SCRIPT"
  fi
fi

echo "[startup] pronto"
echo "Adicione novos passos neste arquivo: $HOME/.config/startup/macos_startup.sh"
