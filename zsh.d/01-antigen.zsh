source "$DOTFILES/antigen/antigen.zsh"

COMPLETION_WAITING_DOTS="true"

antigen use oh-my-zsh

antigen bundle git
antigen bundle mercurial
antigen bundle sudo
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme mortalscumbag