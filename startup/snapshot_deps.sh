#!/usr/bin/env bash

set -euo pipefail

STARTUP_DIR="$HOME/.config/startup"
BREW_RC="$STARTUP_DIR/.brewrc"
NPM_RC="$STARTUP_DIR/.npm-globalrc"

mkdir -p "$STARTUP_DIR"

if command -v brew >/dev/null 2>&1; then
  formulas="$(HOMEBREW_NO_AUTO_UPDATE=1 brew leaves | sort)"
  casks="$(HOMEBREW_NO_AUTO_UPDATE=1 brew list --cask | sort)"

  {
    printf "# Homebrew packages (top-level)\n"
    printf "# Format:\n"
    printf "# - formula:<name>\n"
    printf "# - cask:<name>\n\n"

    if [[ -n "$formulas" ]]; then
      while IFS= read -r pkg; do
        [[ -n "$pkg" ]] && printf "formula:%s\n" "$pkg"
      done <<< "$formulas"
    fi

    printf "\n"

    if [[ -n "$casks" ]]; then
      while IFS= read -r pkg; do
        [[ -n "$pkg" ]] && printf "cask:%s\n" "$pkg"
      done <<< "$casks"
    fi
  } > "$BREW_RC"

  echo "[snapshot] brew salvo em $BREW_RC"
else
  echo "[snapshot] brew nao encontrado, pulando $BREW_RC"
fi

if command -v npm >/dev/null 2>&1; then
  npm_packages="$(npm ls -g --depth=0 --json | node -e "
let data = '';
process.stdin.on('data', (chunk) => data += chunk);
process.stdin.on('end', () => {
  const parsed = JSON.parse(data);
  const deps = parsed.dependencies || {};
  const skip = new Set(['npm', 'corepack']);
  const lines = Object.entries(deps)
    .filter(([name]) => !skip.has(name))
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([name, info]) => name + '@' + info.version);
  process.stdout.write(lines.join('\\n'));
});
")"

  {
    printf "# npm global packages\n"
    printf "# Keep one package spec per line.\n\n"
    if [[ -n "$npm_packages" ]]; then
      printf "%s\n" "$npm_packages"
    fi
  } > "$NPM_RC"

  echo "[snapshot] npm globals salvos em $NPM_RC"
else
  echo "[snapshot] npm nao encontrado, pulando $NPM_RC"
fi

echo "[snapshot] concluido"
