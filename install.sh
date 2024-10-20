#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Get the directory of the script (current dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Function to print colored output
print_color() {
  printf "${!1}%s${RESET}\n" "$2"
}

# Function to print a header
print_header() {
  echo
  print_color "MAGENTA" "===================================="
  print_color "MAGENTA" "   $1"
  print_color "MAGENTA" "===================================="
  echo
}

# Colorful ASCII Art Function
print_ascii_art() {
  echo -e "${BLUE}▗▄▖ █ ▄ ▄   ▄ ▗▞▀▚▖ ▄▄▄ ▄▄▄         "
  echo -e "${BLUE}▐▌ ▐▌█ ▄ █   █ ▐▛▀▀▘█   ▀▄▄          "
  echo -e "${BLUE}▐▌ ▐▌█ █  ▀▄▀  ▝▚▄▄▖█   ▄▄▄▀         "
  echo -e "${BLUE}▝▚▄▞▘█ █                             "
  echo -e "${RED}▗▄▄▄   ▄▄▄     ■  ▗▞▀▀▘▄ █ ▗▞▀▚▖ ▄▄▄ "
  echo -e "${RED}▐▌  █ █   █ ▗▄▟▙▄▖▐▌   ▄ █ ▐▛▀▀▘▀▄▄  "
  echo -e "${RED}▐▌  █ ▀▄▄▄▀   ▐▌  ▐▛▀▘ █ █ ▝▚▄▄▖▄▄▄▀ "
  echo -e "${RED}▐▙▄▄▀         ▐▌  ▐▌   █ █           "
  echo -e "${RED}              ▐▌                     "
  echo -e "${RESET}"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
  if ! command_exists brew; then
    print_color "YELLOW" "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    print_color "GREEN" "Homebrew installed successfully."
  else
    print_color "CYAN" "Homebrew is already installed."
  fi
}

# Function to install Node.js using nvm
install_node() {
  if ! command_exists node; then
    print_color "YELLOW" "Installing Node.js using nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
    print_color "GREEN" "Node.js installed successfully."
  else
    print_color "CYAN" "Node.js is already installed."
  fi
}

# Function to install Git
install_git() {
  if ! command_exists git; then
    print_color "YELLOW" "Installing Git..."
    brew install git
    print_color "GREEN" "Git installed successfully."
  else
    print_color "CYAN" "Git is already installed."
  fi
}

# Function to create symlink if it doesn't already exist
link_file() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    print_color "CYAN" "Symlink already exists for $target"
  elif [ -e "$target" ]; then
    print_color "YELLOW" "File $target exists, skipping."
  else
    ln -s "$source" "$target"
    print_color "GREEN" "Created symlink: $target -> $source"
  fi
}

# Function to create symlinks
create_symlinks() {
  print_header "Creating Symlinks"
  link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
  link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
  link_file "$DOTFILES_DIR/.hyper.js" "$HOME/.hyper.js"
  link_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
  print_color "GREEN" "Symlinks created successfully!"
}

# Function to install Homebrew packages
install_homebrew_packages() {
  print_header "Installing Homebrew Packages"
  if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    print_color "GREEN" "Homebrew packages installed successfully."
  else
    print_color "RED" "Brewfile not found in $DOTFILES_DIR"
  fi
}

# Function to install npm global packages
install_npm_globals() {
  print_header "Installing npm Global Packages"
  npm install -g astro cloudflare-cli contentful-cli depcheck eslint gatsby-cli ghost-cli lice pnpm postcss-cli purgecss sanity spaceship-prompt yarn
  print_color "GREEN" "npm global packages installed successfully."
}

# Function to install prerequisites
install_prerequisites() {
  print_header "Installing Prerequisites"
  install_homebrew
  install_git
  install_node
}

# Main script
clear
print_ascii_art
print_color "CYAN" "Welcome to Oliver's Dotfiles Installer!"
echo

print_header "Dotfiles Installation"
echo "What would you like to do?"
print_color "CYAN" "1) Install prerequisites (Homebrew, Git, Node.js)"
print_color "CYAN" "2) Create symlinks"
print_color "CYAN" "3) Install Homebrew packages"
print_color "CYAN" "4) Install npm global packages"
print_color "CYAN" "5) Do all of the above"
print_color "CYAN" "6) Exit"
echo
read -p "Enter your choice (1-6): " choice

case $choice in
  1)
    install_prerequisites
    print_color "GREEN" "Prerequisites installed."
    ;;
  2)
    create_symlinks
    print_color "GREEN" "Symlinks created."
    ;;
  3)
    install_homebrew_packages
    print_color "GREEN" "Homebrew packages installed."
    ;;
  4)
    install_npm_globals
    print_color "GREEN" "npm global packages installed."
    ;;
  5)
    install_prerequisites
    create_symlinks
    install_homebrew_packages
    install_npm_globals
    print_color "GREEN" "All actions completed successfully."
    ;;
  6)
    print_color "YELLOW" "Exiting installation script."
    exit 0
    ;;
  *)
    print_color "RED" "Invalid option. Exiting."
    exit 1
    ;;
esac

print_header "Installation Complete"
print_color "GREEN" "Thank you for using Oliver's dotfiles installer!"
exit 0
