#!/bin/bash

# Get the directory of the script (current dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
  if ! command_exists brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
}

# Function to install Node.js using nvm
install_node() {
  if ! command_exists node; then
    echo "Installing Node.js using nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
  else
    echo "Node.js is already installed."
  fi
}

# Function to install Git
install_git() {
  if ! command_exists git; then
    echo "Installing Git..."
    brew install git
  else
    echo "Git is already installed."
  fi
}

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

# Function to create symlinks
create_symlinks() {
  echo "Creating symlinks..."
  link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
  link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
  link_file "$DOTFILES_DIR/.hyper.js" "$HOME/.hyper.js"
  echo "Symlinks created successfully!"
}

# Function to install Homebrew packages
install_homebrew_packages() {
  echo "Installing Homebrew packages..."
  if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    brew bundle --file="$DOTFILES_DIR/Brewfile"
  else
    echo "Brewfile not found in $DOTFILES_DIR"
  fi
}

# Function to install npm global packages
install_npm_globals() {
  echo "Installing npm global packages..."
  npm install -g astro cloudflare-cli contentful-cli depcheck eslint gatsby-cli ghost-cli lice pnpm postcss-cli purgecss sanity spaceship-prompt yarn
}

# Function to install prerequisites
install_prerequisites() {
  install_homebrew
  install_git
  install_node
}

# Main menu
while true; do
  echo "What would you like to do?"
  echo "1) Install prerequisites (Homebrew, Git, Node.js)"
  echo "2) Create symlinks"
  echo "3) Install Homebrew packages"
  echo "4) Install npm global packages"
  echo "5) Do all of the above"
  echo "6) Exit"
  read -p "Enter your choice (1-6): " choice

  case $choice in
    1) install_prerequisites ;;
    2) create_symlinks ;;
    3) install_homebrew_packages ;;
    4) install_npm_globals ;;
    5)
      install_prerequisites
      create_symlinks
      install_homebrew_packages
      install_npm_globals
      ;;
    6) 
      echo "Exiting installation script."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac

  echo ""
done
