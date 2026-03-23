#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="${1:-turb-dev}"
TURB_DIR="$HOME/Developer/turb-ios"
BACKEND_DIR="$HOME/Developer/AppBackend/app"
FIGMA_MCP_CMD="npx cursor-talk-to-figma-socket"
DEVELOPER_DIR="$HOME/Developer"

# Proporcoes do layout (ajustadas para o esquema ideal da imagem)
MAIN_SPLIT_PERCENT=50
LEFT_BOTTOM_PERCENT=42
LEFT_BOTTOM_RIGHT_PERCENT=50
RIGHT_BOTTOM_PERCENT=20

if ! command -v tmux >/dev/null 2>&1; then
  echo "Erro: tmux nao esta instalado." >&2
  exit 1
fi

if [[ ! -d "$DEVELOPER_DIR" ]]; then
  mkdir -p "$DEVELOPER_DIR"
fi

if [[ ! -d "$TURB_DIR" ]]; then
  mkdir -p "$TURB_DIR"
fi

if [[ ! -d "$BACKEND_DIR" ]]; then
  mkdir -p "$BACKEND_DIR"
fi

BACKEND_CMD="cd '$BACKEND_DIR' && docker-compose up"
if [[ ! -f "$BACKEND_DIR/docker-compose.yml" && ! -f "$BACKEND_DIR/compose.yml" ]]; then
  BACKEND_CMD="cd '$BACKEND_DIR' && printf 'Backend ainda nao configurado (%s).\n' '$BACKEND_DIR'"
fi

OPENCODE_CMD="opencode"
if ! command -v opencode >/dev/null 2>&1; then
  OPENCODE_CMD="printf 'opencode nao instalado.\n'"
fi

FIGMA_CMD="$FIGMA_MCP_CMD"
if ! command -v npx >/dev/null 2>&1; then
  FIGMA_CMD="printf 'npx nao encontrado para iniciar Figma MCP.\n'"
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$SESSION_NAME"
  else
    tmux attach-session -t "$SESSION_NAME"
  fi
  exit 0
fi

# Janela inicial
tmux new-session -d -s "$SESSION_NAME" -n dev -c "$TURB_DIR"

# Layout ideal (5 paineis):
# - Esquerda topo: turb-ios com nvim
# - Esquerda baixo/esq: AppBackend/app com docker-compose up
# - Esquerda baixo/dir: turb-ios com Figma MCP
# - Direita topo: turb-ios com opencode
# - Direita baixo: turb-ios terminal only

# Split principal: esquerda x direita
RIGHT_PANE="$(tmux split-window -h -p "$MAIN_SPLIT_PERCENT" -P -F '#{pane_id}' -t "$SESSION_NAME:dev.0" -c "$TURB_DIR")"

# Captura IDs dos paineis apos split principal
LEFT_PANE="$(tmux display-message -p -t "$SESSION_NAME:dev.0" '#{pane_id}')"

# Esquerda: topo grande + faixa inferior
LEFT_BOTTOM_PANE="$(tmux split-window -v -p "$LEFT_BOTTOM_PERCENT" -P -F '#{pane_id}' -t "$LEFT_PANE" -c "$TURB_DIR")"
LEFT_TOP_PANE="$LEFT_PANE"

# Faixa inferior esquerda: backend (esq) + figma mcp (dir)
FIGMA_PANE="$(tmux split-window -h -p "$LEFT_BOTTOM_RIGHT_PERCENT" -P -F '#{pane_id}' -t "$LEFT_BOTTOM_PANE" -c "$TURB_DIR")"
BACKEND_PANE="$LEFT_BOTTOM_PANE"

# Direita: topo grande + terminal only embaixo
TERMINAL_ONLY_PANE="$(tmux split-window -v -p "$RIGHT_BOTTOM_PERCENT" -P -F '#{pane_id}' -t "$RIGHT_PANE" -c "$TURB_DIR")"
OPENCODE_PANE="$RIGHT_PANE"

# Comandos em cada painel
tmux send-keys -t "$LEFT_TOP_PANE" "nvim" C-m
tmux send-keys -t "$OPENCODE_PANE" "$OPENCODE_CMD" C-m
tmux send-keys -t "$BACKEND_PANE" "$BACKEND_CMD" C-m
tmux send-keys -t "$FIGMA_PANE" "$FIGMA_CMD" C-m

# Direita inferior fica terminal puro
tmux select-pane -t "$TERMINAL_ONLY_PANE"

# Foco inicial no nvim
tmux select-pane -t "$LEFT_TOP_PANE"

if [[ -n "${TMUX:-}" ]]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach-session -t "$SESSION_NAME"
fi
