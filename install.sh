#!/bin/bash

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/nvim" ~/.config/nvim
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/starship/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES/ghostty/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

echo "done."
