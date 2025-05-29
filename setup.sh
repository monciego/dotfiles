#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "Creating symlinks..."

ln -sf $DOTFILES_DIR/.bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/.profile ~/.profile

# Create config dir if not exists
mkdir -p ~/.config
ln -sf $DOTFILES_DIR/nvim ~/.config/nvim

echo "Symlinks created!"
