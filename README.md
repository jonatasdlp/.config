# 🛠️ Development Environment Configuration

Welcome to my personal development environment configuration! This repository contains my carefully curated setup for a productive development workflow, primarily featuring a modern Neovim configuration with powerful plugins and tools.

## 🚀 What's Inside

This repository includes configurations for:

- **Neovim** - A modern, extensible text editor with powerful plugins
- **Atuin** - Enhanced shell history with sync capabilities

## 🎯 Neovim Setup

The heart of this configuration is a modern Neovim setup built with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

### ✨ Key Features

- **AI-Powered Development**: Integrated with [Avante](https://github.com/yetone/avante.nvim) for Claude AI assistance
- **Smart Code Completion**: Advanced completion with nvim-cmp and multiple sources
- **Language Support**: LSP configuration with Swift development focus
- **Code Formatting**: Automatic formatting with conform.nvim
- **File Navigation**: Telescope fuzzy finder and nvim-tree file explorer
- **Visual Enhancements**: Syntax highlighting and text highlighting tools
- **Modern UI**: Clean, minimal interface with intuitive keybindings

### 🔧 Plugin Stack

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| **lazy.nvim** | Plugin manager | Bootstrap and lazy loading |
| **avante.nvim** | AI assistant (Claude) | AI-powered coding help |
| **nvim-cmp** | Autocompletion | LSP, buffer, and path completion |
| **nvim-lspconfig** | LSP integration | Swift (sourcekit) LSP setup |
| **conform.nvim** | Code formatting | Lua, JavaScript, Swift formatters |
| **telescope.nvim** | Fuzzy finder | File and text search |
| **nvim-tree.lua** | File explorer | Tree-style file navigation |
| **vim-highlighter** | Text highlighting | Multi-color text highlighting |


## 🐚 Shell Configuration

### Atuin - Enhanced History
- **Smart history search** with fuzzy matching
- **Sync across devices** capability
- **Enter-to-execute** for quick command execution
- **Advanced filtering** by directory, session, and workspace

## 📦 Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url> ~/.config
   ```

2. **Install Neovim** (version 0.8+):
   ```bash
   # macOS
   brew install neovim
   
   # Linux
   sudo apt install neovim  # Ubuntu/Debian
   sudo pacman -S neovim    # Arch Linux
   ```

3. **Install dependencies**:
   ```bash
   # Required tools
   brew install ripgrep fd fzf  # macOS
   
   # Language servers and formatters
   brew install stylua prettier swiftformat
   ```

4. **Launch Neovim**:
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first launch.

## 🎯 Usage

### Getting Started with Neovim

1. **Open a project**: `nvim /path/to/project`
2. **File navigation**: Use `<leader>` + telescope commands
3. **Code completion**: Start typing and use `<Tab>` to navigate suggestions
4. **AI assistance**: Use Avante commands for AI-powered help
5. **Formatting**: Press `<leader>f` to format the current file

### Advanced Features

- **Multi-language support**: Automatic language detection and formatting
- **Project-aware**: Workspace-specific configurations
- **Version control**: Git integration with enhanced history
- **Cross-platform**: Works on macOS, Linux, and Windows

## 🔮 Future Plans

This configuration is constantly evolving! Planned additions include:

- **More language servers**: Python, Go, Rust, TypeScript
- **Additional formatters**: More language-specific tools
- **Enhanced themes**: Custom color schemes
- **Workflow automation**: Git hooks and automation scripts
- **Documentation**: Video tutorials and detailed guides

## 📄 License

This configuration is **free and open source**. Feel free to use, modify, and distribute as you see fit.

---

### 🌟 Why This Setup?

This configuration prioritizes:

- **Performance**: Lazy loading and optimized startup
- **Productivity**: AI assistance and smart completion
- **Simplicity**: Clean, intuitive interface
- **Extensibility**: Easy to customize and extend
- **Modern**: Latest tools and best practices

**Happy coding!** 🚀

---

*Last updated: 2025-01-06*
