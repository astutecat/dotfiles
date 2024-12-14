fpath=("${ZDOTDIR:-$HOME}/.zfunc" $fpath)
autoload -Uz is_cmd
autoload -Uz fix_zsh_history
autoload -Uz get_erl_version

qpushd() {
    pushd $1 > /dev/null
}

qpopd() {
    popd > /dev/null
}

split_tldr() {
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr "$@" || tldr "$@"
}

source_if_exists() {
  [ -f $1 ] && source $1
}

tmux_rename() {
  [[ -n $TMUX ]] && tmux rename-window $1 || :
}

git_squash_from() {
    COMMIT_TO_SQUASH=$1
    SQUASH_MESSAGE=$2

    STARTING_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    CURRENT_HEAD=$(git rev-parse HEAD)

    echo From $CURRENT_HEAD to the successor of  $COMMIT_TO_SQUASH will retain, from $COMMIT_TO_SQUASH to beginging will be squashed

    git checkout $COMMIT_TO_SQUASH
    git reset $(git commit-tree HEAD^{tree} -m "$SQUASH_MESSAGE")
    git cherry-pick $CURRENT_HEAD...$COMMIT_TO_SQUASH
    git branch -D $STARTING_BRANCH
    git checkout -b $STARTING_BRANCH
}

precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }
