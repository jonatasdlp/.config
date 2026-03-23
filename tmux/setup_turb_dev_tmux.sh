#!/usr/bin/env bash

set -euo pipefail

SCRIPT_PATH="$HOME/.config/tmux/scripts/start_turb_dev_tmux.sh"
STARTUP_SCRIPT="$HOME/.config/startup/macos_startup.sh"
INSTALL_DEPS_SCRIPT="$HOME/.config/startup/install_deps.sh"
SNAPSHOT_DEPS_SCRIPT="$HOME/.config/startup/snapshot_deps.sh"
ZSHRC_PATH="$HOME/.zshrc"
ALIAS_TURBDEV="alias turbdev='\$HOME/.config/tmux/scripts/start_turb_dev_tmux.sh'"
ALIAS_TD="alias td='turbdev'"
ALIAS_STARTUP="alias startup='\$HOME/.config/startup/macos_startup.sh'"
ALIAS_FIRSTSETUP="alias firstsetup='startup --with-deps'"
ALIAS_DEPS_INSTALL="alias depsinstall='\$HOME/.config/startup/install_deps.sh'"
ALIAS_DEPS_SNAPSHOT="alias depssnapshot='\$HOME/.config/startup/snapshot_deps.sh'"

if [[ ! -f "$SCRIPT_PATH" ]]; then
  echo "Erro: script principal nao encontrado em $SCRIPT_PATH" >&2
  exit 1
fi

chmod +x "$SCRIPT_PATH"
mkdir -p "$HOME/.config/startup"
mkdir -p "$HOME/Developer"

if [[ -f "$STARTUP_SCRIPT" ]]; then
  chmod +x "$STARTUP_SCRIPT"
fi

if [[ -f "$INSTALL_DEPS_SCRIPT" ]]; then
  chmod +x "$INSTALL_DEPS_SCRIPT"
fi

if [[ -f "$SNAPSHOT_DEPS_SCRIPT" ]]; then
  chmod +x "$SNAPSHOT_DEPS_SCRIPT"
fi

if [[ ! -f "$ZSHRC_PATH" ]]; then
  touch "$ZSHRC_PATH"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+turbdev=" "$ZSHRC_PATH"; then
  {
    printf "\n# turb-dev tmux\n"
    printf "%s\n" "$ALIAS_TURBDEV"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: turbdev"
else
  echo "Alias turbdev ja existe no ~/.zshrc"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+td=" "$ZSHRC_PATH"; then
  {
    printf "%s\n" "$ALIAS_TD"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: td"
else
  echo "Alias td ja existe no ~/.zshrc"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+startup=" "$ZSHRC_PATH"; then
  {
    printf "%s\n" "$ALIAS_STARTUP"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: startup"
else
  echo "Alias startup ja existe no ~/.zshrc"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+firstsetup=" "$ZSHRC_PATH"; then
  {
    printf "%s\n" "$ALIAS_FIRSTSETUP"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: firstsetup"
else
  echo "Alias firstsetup ja existe no ~/.zshrc"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+depsinstall=" "$ZSHRC_PATH"; then
  {
    printf "%s\n" "$ALIAS_DEPS_INSTALL"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: depsinstall"
else
  echo "Alias depsinstall ja existe no ~/.zshrc"
fi

if ! grep -Eq "^[[:space:]]*alias[[:space:]]+depssnapshot=" "$ZSHRC_PATH"; then
  {
    printf "%s\n" "$ALIAS_DEPS_SNAPSHOT"
  } >> "$ZSHRC_PATH"
  echo "Alias adicionado no ~/.zshrc: depssnapshot"
else
  echo "Alias depssnapshot ja existe no ~/.zshrc"
fi

echo "Pronto. Rode: source ~/.zshrc"
