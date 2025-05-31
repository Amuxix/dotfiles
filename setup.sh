#!/bin/bash -e

# Allow fingerprint for sudo in console
sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

# Install rosetta
sudo softwareupdate --install-rosetta

# Install homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> "$HOME/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# CLI tools
brew install git fzf direnv zoxide eza vimcat nvim scala sbt

# GUI apps
brew install --cask firefox intellij-idea enpass slack smooze-pro spotify alfred discord iterm2 font-fira-code-nerd-font

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

chsh -s $(which zsh)

if git clone https://github.com/Amuxix/dotfiles.git; then
  cd dotfiles
else
  echo "Failed to clone dotfiles repo."
  exit 1
fi

cd dotfiles

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
    mv -i $f old/
  fi
  ln -sf "$DOTFILES/$file" $f
done

cd ..
