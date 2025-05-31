#!/bin/bash

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
  else
    echo "Rosetta install skipped: not Apple Silicon."
  fi
else
  echo "You do not have sudo privileges, skipping sudo commands."
fi

# Install homebrew (does not require sudo)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> "$HOME/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install oh-my-zsh (does not require sudo)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install CLI tools
brew install git fzf direnv zoxide eza vimcat nvim scala sbt

# Install GUI apps
brew install --cask firefox intellij-idea enpass slack smooze-pro spotify alfred discord iterm2 font-fira-code-nerd-font

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

DOTFILES="$(pwd)"

files=(".zshrc" ".p10k.zsh" ".config/nvim")

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

# Change default shell to zsh if available
ZSH_PATH="$(which zsh)"
if [[ -n "$ZSH_PATH" ]]; then
  chsh -s "$ZSH_PATH"
else
  echo "zsh not found, skipping shell change."
fi

