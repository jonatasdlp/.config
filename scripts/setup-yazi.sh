#!/bin/bash
set -e

echo "🔧 Configurando Yazi com tema gruvbox-dark..."

YAZI_CONFIG_DIR="$HOME/.config/yazi"

mkdir -p "$YAZI_CONFIG_DIR"

if command -v ya &> /dev/null; then
    echo "📦 Instalando tema gruvbox-dark..."
    ya pkg add bennyyip/gruvbox-dark
else
    echo "⚠️  'ya' não encontrado. Instale o yazi com 'brew install yazi'"
fi

cat > "$YAZI_CONFIG_DIR/yazi.toml" << 'EOF'
[plugin]
# gruvbox-dark theme
remote = "github:bennyyip/gruvbox-dark"

[theme]
# Use gruvbox-dark
scheme = "gruvbox-dark"

# File highlighting colors (gruvbox palette)
[theme.file_type]
archive  = "250"
audio    = "142"
binary   = "250"
image    = "214"
video    = "109"
folder   = "250"
symlink  = "109"
text     = "250"
 EOF

echo "✅ Yazi configurado com tema gruvbox-dark!"
echo "📁 Configuração em: $YAZI_CONFIG_DIR/yazi.toml"