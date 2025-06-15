# Use the timer to profile zshrc loading if it is being slow.
# ZSHRC_TIMER=${EPOCHREALTIME:-$(date +%s.%N)}
# zshrc_time_log() {
#   local now=${EPOCHREALTIME:-$(date +%s.%N)}
#   local elapsed=$(awk "BEGIN { print $now - $ZSHRC_TIMER }")
#   echo "⏱️  ${1:-Unnamed section}: ${elapsed}s"
#   ZSHRC_TIMER=$now
# }

case "$OSTYPE" in
  darwin*) export IS_MACOS=true ;;
  linux*)  export IS_LINUX=true ;;
esac


# SSH Agent handling
if [[ $IS_MACOS == true ]]; then
  # Add the key to the launchd SSH agent if not already loaded
  if ! ssh-add -l &>/dev/null; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 &>/dev/null
  fi
elif [[ $IS_LINUX == true ]]; then
  # Start ssh-agent if not already running, and add key
  if [[ -z "$SSH_AUTH_SOCK" ]] || ! ssh-add -l &>/dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 &>/dev/null
  fi
fi

export LANG=en_US.UTF-8

# plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load zsh-completions
autoload -Uz compinit && compinit -C
zinit cdreplay -q

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/chip.toml)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# fzf theming
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

# Aliases
alias v="nvim"
alias vim="nvim"
alias ls='ls --color=auto'
alias ll="ls -lah"
alias la="ls -a"
alias grep='grep --color=auto'
alias g="git"

nvm() {
  unset -f nvm node npm
  if [[ $IS_MACOS == true ]]; then
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  elif [[ $IS_LINUX == true ]]; then
    source "/usr/share/nvm/init-nvm.sh"
  fi
  nvm "$@"
}

node() { nvm; node "$@"; }
npm()  { nvm; npm "$@"; }



# LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# GTK theme
# Change to suite your flavor / accent combination
export FLAVOR="mocha"
export ACCENT="red"
export PATH="/usr/local/sbin:$PATH"
