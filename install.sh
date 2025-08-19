#!/bin/bash

# Dotfiles Installation Script
# This script installs yabai, skhd, and karabiner configurations

set -e

echo "🚀 Installing dotfiles..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

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

print_status "Installing applications via Homebrew..."

# Install yabai
if ! brew list koekeishiya/formulae/yabai &> /dev/null; then
    print_status "Installing yabai..."
    brew install koekeishiya/formulae/yabai
else
    print_status "yabai is already installed"
fi

# Install skhd
if ! brew list koekeishiya/formulae/skhd &> /dev/null; then
    print_status "Installing skhd..."
    brew install koekeishiya/formulae/skhd
else
    print_status "skhd is already installed"
fi

# Install jq
if ! brew list jq &> /dev/null; then
    print_status "Installing skhd..."
    brew install jq
else
    print_status "jq is already installed"
fi

# Install Karabiner-Elements
if ! brew list --cask karabiner-elements &> /dev/null; then
    print_status "Installing Karabiner-Elements..."
    brew install --cask karabiner-elements
else
    print_status "Karabiner-Elements is already installed"
fi

print_status "Creating config directories..."
mkdir -p ~/.config/{yabai,skhd,karabiner}

print_status "Copying configuration files..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Copy yabai config
if [[ -f "$SCRIPT_DIR/yabai/yabairc" ]]; then
    cp "$SCRIPT_DIR/yabai/yabairc" ~/.config/yabai/
    chmod +x ~/.config/yabai/yabairc
    print_status "yabai configuration copied"
else
    print_warning "yabai configuration not found"
fi

# Copy skhd config  
if [[ -f "$SCRIPT_DIR/skhd/skhdrc" ]]; then
    cp "$SCRIPT_DIR/skhd/skhdrc" ~/.config/skhd/
    chmod +x ~/.config/skhd/skhdrc
    print_status "skhd configuration copied"
else
    print_warning "skhd configuration not found"
fi

# Copy karabiner config
if [[ -f "$SCRIPT_DIR/karabiner/karabiner.json" ]]; then
    cp "$SCRIPT_DIR/karabiner/karabiner.json" ~/.config/karabiner/
    print_status "Karabiner configuration copied"
else
    print_warning "Karabiner configuration not found"
fi

print_status "Starting services..."

# Start yabai service
if command -v yabai &> /dev/null; then
    yabai --start-service
    print_status "yabai service started"
fi

# Start skhd service
if command -v skhd &> /dev/null; then
    skhd --start-service
    print_status "skhd service started"
fi

echo ""
print_status "✅ Installation complete!"
echo ""
print_warning "Important notes:"
echo "• For full yabai functionality, you may need to disable System Integrity Protection (SIP)"
echo "• See: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
echo "• Open Karabiner-Elements.app to ensure the configuration is loaded"
echo "• You may need to grant accessibility permissions to yabai and skhd in System Preferences"
