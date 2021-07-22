qpushd "$DOTFILES/antigen/"
    source "$DOTFILES/antigen/antigen.zsh"
qpopd

COMPLETION_WAITING_DOTS="true"

antigen use oh-my-zsh

antigen bundle git

if is_cmd hg; then
    antigen bundle mercurial
fi

antigen bundle sudo
antigen bundle command-not-found

antigen theme mortalscumbag