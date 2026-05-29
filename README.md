# Dotfiles

My personal macOS configuration files.

## What's Included
* **yabai**: Window management configuration
* **skhd**: Hotkey daemon configuration
* **karabiner**: Karabiner-Elements key remapping configuration
* **ghostty**: Ghostty terminal configuration
* **tmux**: tmux configuration (integrated with Ghostty)
* **zsh**: Shell snippets (Ghostty+tmux auto-launch)

## Prerequisites

Install Homebrew if you haven't already:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

```
git clone https://github.com/andyjianzhou/dotfiles.git
cd dotfiles
./install.sh
```

This will:
1. Install yabai, skhd, jq, tmux, Karabiner-Elements, and Ghostty via Homebrew
2. Copy all config files to their correct locations
3. Add Ghostty+tmux auto-launch to your `.zshrc`
4. Start yabai and skhd services

## File Structure

```
dotfiles/
├── README.md
├── install.sh
├── ghostty/
│   └── config
├── tmux/
│   └── tmux.conf
├── yabai/
│   └── yabairc
├── skhd/
│   └── skhdrc
├── karabiner/
│   └── karabiner.json
└── zsh/
    └── ghostty-tmux.zsh
```

## Updating

After making changes, run `./install.sh` again to copy updated configs.
