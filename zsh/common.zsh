if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="%Y/%m/%d"
plugins=(
  git
  sudo
  safe-paste
  command-not-found
  docker-compose
  "${local_plugins[@]}"
  autoupdate
  zsh-autosuggestions
  zsh-syntax-highlighting #Must the last
)

source $ZSH/oh-my-zsh.sh

# User configuration
setopt EXTENDED_HISTORY
setopt inc_append_history_time

export EDITOR='nvim'

alias t='tree -c -d'
alias grep='grep --color=always'
alias l='eza -lb'
alias la='l -a'
alias lx='l --sort=extension' # aka l -x
alias lt='l --sort=time -r' # aka l -t  -r = reverse order while sorting
alias v=nvim
alias cat=vimcat

if [ $USER = "root" ]; then
	alias v='nvim -u ~amuxix/.vimrc'
	alias vimdiff='vimdiff -u ~amuxix/.vimrc'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source <(fzf --zsh)
eval "$(zoxide init --cmd cd --no-cmd zsh)"

