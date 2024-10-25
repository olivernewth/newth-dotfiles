# Profiling (comment out when not needed)
# zmodload zsh/zprof

# Oh My Zsh optimization
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh theme
ZSH_THEME="robbyrussell"
# Plugins
plugins=(git npm docker zsh-autosuggestions zsh-syntax-highlighting zsh-defer)

source $ZSH/oh-my-zsh.sh

# Language and editor setup
export LANG=en_US.UTF-8
export EDITOR='code'

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias update='brew update && brew upgrade'

# Lazy-load NVM
nvm() {
    unset -f nvm node npm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

node() {
    unset -f nvm node npm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    node "$@"
}

npm() {
    unset -f nvm node npm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    npm "$@"
}

# Suppress Homebrew environment hints
export HOMEBREW_NO_ENV_HINTS=1

# Starship prompt
export STARSHIP_COMMAND_TIMEOUT=1000
eval "$(starship init zsh)"

# Add paths to PATH
export PATH="$BUN_INSTALL/bin:$PNPM_HOME:/Library/TeX/texbin:$PATH"

# Bun completion (lazy-loaded)
bun() {
    unset -f bun
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
    bun "$@"
}

# Fuzzy directory jumper (z)
. /opt/homebrew/etc/profile.d/z.sh

# Optimize completion system
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Ensure zsh-completions with Homebrew
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# History configuration
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Auto-correction
setopt CORRECT
setopt CORRECT_ALL

# Defer loading of non-essential plugins
   zsh-defer source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   zsh-defer source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


# Profiling (comment out when not needed)
# zprof
