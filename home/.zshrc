ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Chegnyu's stuff
# ------------------------------

# alias
alias vim="nvim"
alias lg="lazygit"
alias l="ls -lA"
alias lt="ls -lAtr"

# custom scripts
export PATH=$PATH:~/.local/bin

# fzf
source <(fzf --zsh)

# go
export PATH=$PATH:$(go env GOPATH)/bin

# opam configuration
[[ ! -r /Users/chengyuchen/.opam/opam-init/init.zsh ]] || source /Users/chengyuchen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

