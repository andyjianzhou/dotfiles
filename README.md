# Dotfiles

My personal macOS configuration files for yabai, skhd, and Karabiner-Elements.

## What's Included

- **yabai**: Window management configuration
- **skhd**: Hotkey daemon configuration  
- **karabiner**: Karabiner-Elements key remapping configuration

## Prerequisites

Install Homebrew if you haven't already:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

### Automated Installation
Run the install script:
```bash
./install.sh
```

### Manual Installation

1. **Install the applications via Homebrew:**
```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install jq
brew install --cask karabiner-elements
```

2. **Create config directories:**
```bash
mkdir -p ~/.config/{yabai,skhd,karabiner}
```

3. **Copy configuration files:**
```bash
cp yabai/yabairc ~/.config/yabai/
cp skhd/skhdrc ~/.config/skhd/
cp karabiner/karabiner.json ~/.config/karabiner/
```

4. **Set executable permissions:**
```bash
chmod +x ~/.config/yabai/yabairc
chmod +x ~/.config/skhd/skhdrc
```

5. **Start the services:**
```bash
yabai --start-service
skhd --start-service
```

## yabai Setup

yabai requires System Integrity Protection (SIP) to be partially disabled for some features. See the [yabai wiki](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection) for detailed instructions.

## Usage

- **yabai**: Restart with `yabai --restart-service`
- **skhd**: Restart with `skhd --restart-service`
- **Karabiner**: Open Karabiner-Elements.app to load the configuration

## Updating Configurations

After making changes to any configuration file in this repo:

1. Copy the updated file to the appropriate config directory
2. Restart the relevant service

Or simply run `./install.sh` again to update everything.

## File Structure

```
dotfiles/
├── README.md
├── install.sh
├── yabai/
│   └── yabairc
├── skhd/
│   └── skhdrc
└── karabiner/
    └── karabiner.json
```

# Commands to run to ensure that minimizing focuses and highlights borders.

Due to MacOs having slow animation times, some of the borders functionality would break. To fix this, you can either disable, OR speed up the process like I did

Run this in your terminal
```
# Make animations much faster (0.1 = 10x faster)
defaults write NSGlobalDomain NSWindowResizeTime -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.1
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1
defaults write com.apple.dock springboard-page-duration -float 0.1
defaults write com.apple.finder DisableAllAnimations -bool true
killall Dock
killall Finder
```
