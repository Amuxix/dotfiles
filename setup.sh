#!/bin/bash
set -euo pipefail

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install

  echo "Waiting for Xcode Command Line Tools installation to complete..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
  echo "Xcode Command Line Tools installed."
else
  echo "Xcode Command Line Tools already installed."
fi

# Check if user can run sudo
if sudo -v >/dev/null 2>&1; then
  echo "Sudo privileges detected. Running sudo commands..."

  # PAM tweak (only if template file exists)
  if [[ -f /etc/pam.d/sudo_local.template ]]; then
    sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
  else
    echo "Skipping PAM config tweak, sudo_local.template not found."
  fi

  # Install Rosetta only on Apple Silicon
  if [[ "$(uname -m)" == "arm64" ]]; then
    sudo softwareupdate --install-rosetta --agree-to-license

    echo "Waiting for Rosetta (oahd) to be ready..."
    until /usr/bin/pgrep oahd &>/dev/null; do
      sleep 5
    done
    echo "Rosetta installed and ready."
  else
    echo "Rosetta install skipped: not Apple Silicon."
  fi
else
  echo "You do not have sudo privileges, skipping sudo commands."
fi

# Install Homebrew (does not require sudo)
if command -v brew &>/dev/null; then
  echo "Homebrew already installed. Skipping installation."
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install CLI tools
brew install -q git fzf direnv zoxide eza vimcat nvim scala sbt zsh-syntax-highlighting zsh-autosuggestions

# Install GUI apps
brew install -q --cask firefox intellij-idea enpass slack smooze-pro spotify alfred discord iterm2 font-fira-code-nerd-font

if [[ -d "./dotfiles/.git" ]]; then
  echo "Found existing dotfiles directory. Fetching latest changes..."
  cd dotfiles || exit 1
  git fetch origin
elif [[ "$(basename "$PWD")" == "dotfiles" ]] || [[ "$PWD" == */dotfiles/* ]]; then
  echo "Already inside a 'dotfiles' directory. Skipping clone."
else
  echo "Cloning dotfiles repository..."
  if git clone https://github.com/Amuxix/dotfiles.git; then
    cd dotfiles || exit 1
  else
    echo "Failed to clone dotfiles repo."
    exit 1
  fi
fi

DOTFILES="$(pwd)"

files=(".zshrc" ".p10k.zsh" ".config/nvim")

mkdir -p "$HOME/.config"

for file in "${files[@]}"
do
  f="$HOME/$file"
  if [[ -d $f ]] || [[ -f $f ]] && ! [[ -L $f ]]; then
    echo "$file already exists, move it to old/?"
    if ! [[ -d "old" ]]; then
      mkdir old
    fi
    mv -i "$f" old/
  fi
  ln -sf "$DOTFILES/$file" "$f"
done

# Install oh-my-zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "oh-my-zsh already installed. Skipping."
else
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Change default shell to zsh if available
ZSH_PATH="$(which zsh)"
if [[ -n "$ZSH_PATH" ]]; then
  chsh -s "$ZSH_PATH"
else
  echo "zsh not found, skipping shell change."
fi

echo "Launching iTerm and Enpass..."
sleep 2
open -a "iTerm"
open -a "Enpass"
