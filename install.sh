#!/bin/bash

# Dotfiles Installation Script
# This script installs yabai, skhd, karabiner, ghostty, and tmux configurations

set -e

echo "🚀 Installing dotfiles..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Please install it first:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

print_status "Installing applications via Homebrew..."

# Install formulae
for pkg in koekeishiya/formulae/yabai koekeishiya/formulae/skhd jq tmux; do
    if ! brew list "$pkg" &> /dev/null; then
        print_status "Installing $pkg..."
        brew install "$pkg"
    else
        print_status "$pkg is already installed"
    fi
done

# Install casks
for cask in karabiner-elements ghostty; do
    if ! brew list --cask "$cask" &> /dev/null; then
        print_status "Installing $cask..."
        brew install --cask "$cask"
    else
        print_status "$cask is already installed"
    fi
done

print_status "Creating config directories..."
mkdir -p ~/.config/{yabai,skhd,karabiner,ghostty}

print_status "Copying configuration files..."

# Copy yabai config
if [[ -f "$SCRIPT_DIR/yabai/yabairc" ]]; then
    cp "$SCRIPT_DIR/yabai/yabairc" ~/.config/yabai/
    chmod +x ~/.config/yabai/yabairc
    print_status "yabai configuration copied"
fi

# Copy skhd config
if [[ -f "$SCRIPT_DIR/skhd/skhdrc" ]]; then
    cp "$SCRIPT_DIR/skhd/skhdrc" ~/.config/skhd/
    chmod +x ~/.config/skhd/skhdrc
    print_status "skhd configuration copied"
fi

# Copy karabiner config
if [[ -f "$SCRIPT_DIR/karabiner/karabiner.json" ]]; then
    cp "$SCRIPT_DIR/karabiner/karabiner.json" ~/.config/karabiner/
    print_status "Karabiner configuration copied"
fi

# Copy Ghostty config
if [[ -f "$SCRIPT_DIR/ghostty/config" ]]; then
    cp "$SCRIPT_DIR/ghostty/config" ~/.config/ghostty/
    print_status "Ghostty configuration copied"
fi

# Copy tmux config
if [[ -f "$SCRIPT_DIR/tmux/tmux.conf" ]]; then
    cp "$SCRIPT_DIR/tmux/tmux.conf" ~/.tmux.conf
    print_status "tmux configuration copied"
fi

# Add Ghostty+tmux auto-launch to zshrc
if [[ -f "$SCRIPT_DIR/zsh/ghostty-tmux.zsh" ]]; then
    if ! grep -q "Auto-attach to tmux in Ghostty" ~/.zshrc 2>/dev/null; then
        echo "" >> ~/.zshrc
        cat "$SCRIPT_DIR/zsh/ghostty-tmux.zsh" >> ~/.zshrc
        print_status "Ghostty+tmux auto-launch added to ~/.zshrc"
    else
        print_status "Ghostty+tmux auto-launch already in ~/.zshrc"
    fi
fi

print_status "Starting services..."

if command -v yabai &> /dev/null; then
    yabai --start-service 2>/dev/null || true
    print_status "yabai service started"
fi

if command -v skhd &> /dev/null; then
    skhd --start-service 2>/dev/null || true
    print_status "skhd service started"
fi

echo ""
print_status "✅ Installation complete!"
echo ""
print_warning "Notes:"
echo "• For full yabai functionality, you may need to disable SIP"
echo "• See: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
echo "• Grant accessibility permissions to yabai and skhd in System Preferences"
echo "• Open Ghostty to start using tmux integration"
