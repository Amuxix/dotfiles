local_plugins=(
  sbt
  kubectl
  kubectx
)

# Load shared dotfiles
source "$HOME/dotfiles/zsh/common.zsh"

eval "$(direnv hook zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# terraform stuff mostly
export PATH="$PATH:/Users/amuxix/bin"

# opencode alias with share enforcement
oc() {
    # Check if jq is installed
    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq is required but not installed"
        echo ""
        echo "Install jq using:"
        echo "  Ubuntu/Debian: sudo apt install jq"
        echo "  macOS:         brew install jq"
        return 1
    fi

    # Check home config file
    config_file="$HOME/.config/opencode/opencode.json"

    if [ ! -f "$config_file" ]; then
        echo "ERROR: OpenCode config file not found"
        echo "Expected: $config_file"
        echo ""
        echo "Please create a config file with:"
        echo '  {"share": "disabled"}'
        return 1
    fi

    # Parse share setting using jq
    share_setting=$(jq -r '.share // "not-set"' "$config_file" 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to parse config file (invalid JSON?)"
        echo "Config file: $config_file"
        return 1
    fi

    # Check if share is explicitly set to "disabled"
    if [ "$share_setting" != "disabled" ]; then
        echo "ERROR: OpenCode share feature is NOT disabled!"
        echo ""
        echo "Current share setting: '$share_setting'"
        echo "Config file: $config_file"
        echo ""
        echo "The share feature must be set to 'disabled' for security."
        echo "Please update your config file with:"
        echo '  "share": "disabled"'
        return 1
    fi

    # All checks passed, run opencode
    opencode .
}

