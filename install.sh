#!/bin/bash

# Get the directory of the script (current dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Function to create symlink if it doesn't already exist
link_file() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    echo "Symlink already exists for $target"
  elif [ -e "$target" ]; then
    echo "File $target exists, skipping."
  else
    ln -s "$source" "$target"
    echo "Created symlink: $target -> $source"
  fi
}

# Symlink configurations relative to the dotfiles directory
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.hyper.js" "$HOME/.hyper.js"

echo "Symlinks created successfully!"
