
#!/usr/bin/env bash
set -euo pipefail

# Detect operating system

OS="$(uname -s)"

case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)
    if [[ -f /etc/arch-release ]]; then
      PLATFORM="arch"
    else
      echo "Unsupported Linux distribution. This script supports Arch Linux."
      exit 1
    fi
    ;;
  *)
    echo "Unsupported operating system: $OS"
    exit 1
    ;;
esac

echo "Setting up dotfiles for $PLATFORM..."

# Platform-specific package installation
if [[ "$PLATFORM" == "macos" ]]; then
  # Install Xcode Command Line Tools
  if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install

    echo "Waiting for Xcode Command Line Tools installation..."
    until xcode-select -p &>/dev/null; do
      sleep 5
    done
  else
    echo "Xcode Command Line Tools already installed."
  fi

  # Pam config tweak (use fingerprint for sudo)
  if sudo -v >/dev/null 2>&1; then
    if [[ -f /etc/pam.d/sudo_local.template ]]; then
      sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template |
        sudo tee /etc/pam.d/sudo_local >/dev/null
    else
      echo "Skipping PAM config tweak, sudo_local.template not found."
    fi

    # Install Rosetta only on Apple Silicon
    if [[ "$(uname -m)" == "arm64" ]]; then
      if /usr/bin/pgrep -q oahd >/dev/null 2>&1; then
        echo "Rosetta is already running."
      elif /usr/bin/arch -x86_64 /usr/bin/true >/dev/null 2>&1; then
        echo "Rosetta is already installed."
      else
        sudo softwareupdate --install-rosetta --agree-to-license
      fi

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

  # Install Homebrew
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew already installed. Skipping installation."
  fi

  # Add Homebrew to .zprofile
  grep -Fq 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile" 2>/dev/null ||
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"

  # Add Homebrew to this script's PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Install CLI tools
  brew install -q git fzf direnv zoxide eza vimpager nvim scala sbt npm

  # Install GUI apps
  brew install -q --cask firefox intellij-idea enpass slack smooze-pro spotify alfred discord iterm2 font-fira-code-nerd-font

elif [[ "$PLATFORM" == "arch" ]]; then

  # This script must run as a normal user with working sudo access
  if [[ $EUID -eq 0 ]]; then
    echo "Run this script as your normal user, not root."
    exit 1
  fi

  if ! command -v sudo &>/dev/null; then
    echo "sudo is required. Install and configure sudo first."
    exit 1
  fi

  sudo -v

  # Install prerequisites required for yay and the rest of setup
  sudo pacman -Syu --needed git curl base-devel zsh

  # Bootstrap yay if necessary
  if ! command -v yay &>/dev/null; then
    echo "Installing yay..."

    BUILD_DIR="$(mktemp -d)"
    trap 'rm -rf "$BUILD_DIR"' EXIT

    git clone https://aur.archlinux.org/yay-bin.git "$BUILD_DIR/yay-bin"

    (
      cd "$BUILD_DIR/yay-bin"
      makepkg -si
    )

    rm -rf "$BUILD_DIR"
    trap - EXIT
  else
    echo "yay already installed."
  fi

  # Equivalent CLI tools from Arch repositories
  yay -S --needed fzf zoxide eza vimpager neovim

fi

# Find or clone dotfiles

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if git -C "$SCRIPT_DIR" rev-parse --show-toplevel >/dev/null 2>&1; then
  DOTFILES="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"
  echo "Running from an existing dotfiles repository: $DOTFILES"

  echo "Fetching latest changes..."
  git -C "$DOTFILES" fetch origin
  git -C "$DOTFILES" pull --ff-only

elif [[ -d "$HOME/dotfiles/.git" ]]; then
  echo "Found existing dotfiles directory. Fetching latest changes..."

  DOTFILES="$HOME/dotfiles"
  git -C "$DOTFILES" fetch origin
  git -C "$DOTFILES" pull --ff-only

else
  echo "Cloning dotfiles repository..."

  if [[ -e "$HOME/dotfiles" ]]; then
    echo "Error: $HOME/dotfiles exists but is not a Git repository."
    exit 1
  fi

  git clone https://github.com/Amuxix/dotfiles.git "$HOME/dotfiles"
  DOTFILES="$HOME/dotfiles"
fi

cd "$DOTFILES"

# Link dotfiles

files=(".zshrc" ".p10k.zsh" ".config/nvim")

mkdir -p "$HOME/.config"

for file in "${files[@]}"; do
  f="$HOME/$file"

  # Select the appropriate OS-specific Zsh configuration
  if [[ "$file" == ".zshrc" ]]; then
    target="$DOTFILES/zsh/$PLATFORM.zsh"
  else
    target="$DOTFILES/$file"
  fi

  # Validate source before moving any existing configuration
  if [[ ! -e "$target" ]]; then
    echo "Error: dotfile target does not exist: $target"
    exit 1
  fi

  # Preserve existing real files/directories in old/
  if { [[ -d "$f" ]] || [[ -f "$f" ]]; } && ! [[ -L "$f" ]]; then
    echo "$file already exists, move it to old/?"

    mkdir -p "$DOTFILES/old"
    mv -i "$f" "$DOTFILES/old/"

    # If the user declined to move it, don't overwrite it
    if [[ -e "$f" || -L "$f" ]]; then
      echo "Skipping $file."
      continue
    fi
  fi

  # Replace old symlinks safely, including symlinks to directories
  if [[ -L "$f" ]]; then
    rm "$f"
  fi

  ln -s "$target" "$f"
done

# Install Oh My Zsh

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh already installed. Skipping."
else
  echo "Installing Oh My Zsh..."

  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL \
      https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k and custom plugins

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

clone_if_missing() {
  local repo="$1"
  local destination="$2"

  if [[ -d "$destination/.git" ]]; then
    echo "Already installed: $destination"
  elif [[ -e "$destination" || -L "$destination" ]]; then
    echo "Error: $destination exists but is not a Git repository."
    return 1
  else
    git clone --depth=1 "$repo" "$destination"
  fi
}

clone_if_missing \
  https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"

clone_if_missing \
  https://github.com/TamCore/autoupdate-oh-my-zsh-plugins \
  "$ZSH_CUSTOM/plugins/autoupdate"

clone_if_missing \
  https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

clone_if_missing \
  https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Set Zsh as the default shell
ZSH_PATH="$(command -v zsh || true)"

if [[ -z "$ZSH_PATH" ]]; then
  echo "Error: zsh not found, cannot set default shell."
  exit 1
elif [[ "${SHELL:-}" != "$ZSH_PATH" ]]; then
  echo "Setting Zsh as the default shell..."
  chsh -s "$ZSH_PATH"
else
  echo "Zsh is already the default shell."
fi

echo "Setup complete for $PLATFORM."

if [[ "$PLATFORM" == "macos" ]]; then
  echo "Launching iTerm and Enpass..."
  sleep 2
  open -a "iTerm"
  open -a "Enpass"
fi
