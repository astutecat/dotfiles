set shell := ["zsh", "-cu"]

[private]
default:
    @just --justfile "{{ justfile() }}" --list

@apply:
    echo -n "applying dotfiles..."
    chezmoi apply
    echo "done"

watch:
    watchexec -- just apply

commit message: apply
    git add .
    git commit -m "{{ message }}"
    git push

nix-apply:
    nh home switch . -c $(whoami)@$(hostname)

nix-update:
    nix flake update
    @just nix-apply

install-hooks:
    pre-commit install
