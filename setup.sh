#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

# link <source in repo> <destination>
# Creates a symlink. If a real file or folder is already at the destination,
# it is moved to <destination>.backup first (with a timestamp if that exists).
link() {
  local src="$1" dest="$2"

  # Already linked correctly: nothing to do
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "  ok      $dest"
    return
  fi

  if [ -L "$dest" ]; then
    # A symlink pointing somewhere else: just replace it
    rm "$dest"
  elif [ -e "$dest" ]; then
    local backup="$dest.backup"
    [ -e "$backup" ] && backup="$dest.backup.$(date +%Y%m%d-%H%M%S)"
    mv "$dest" "$backup"
    echo "  backup  $dest -> $backup"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "  linked  $dest -> $src"
}

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "Creating symlinks..."

# Home files
link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/.profile" "$HOME/.profile"
link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Config directories (~/.config)
link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
link "$DOTFILES_DIR/zed" "$HOME/.config/zed"

echo "Symlinks created!"
