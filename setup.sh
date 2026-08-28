#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

mkdir -p ~/.config

echo "Creating symlinks..."

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then 
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Home files
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.profile" ~/.profile
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf

# Config directories (~/.config)
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/ghostty" ~/.config/ghostty
ln -sfn "$DOTFILES_DIR/zed" ~/.config/zed

echo "Symlinks created!"
