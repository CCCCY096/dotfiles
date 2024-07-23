# ------------------------------
# Chegnyu's stuff
# ------------------------------

# alias
alias vim="nvim"

# custom scripts
export PATH=$PATH:~/.local/bin

# fzf
source <(fzf --zsh)

# go
export PATH=$PATH:$(go env GOPATH)/bin

# opam configuration
[[ ! -r /Users/chengyuchen/.opam/opam-init/init.zsh ]] || source /Users/chengyuchen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

