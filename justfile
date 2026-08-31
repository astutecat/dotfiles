set shell := ["bash", "-cu"]

[private]
default:
    @just --justfile "{{ justfile() }}" --list

@apply-chezmoi:
    echo -n "applying dotfiles..."
    chezmoi apply
    echo "done"

watch:
    watchexec -- just apply

commit message: apply-chezmoi
    git add .
    git commit -m "{{ message }}"
    git push

[macos]
nix-darwin-apply *args:
    nh darwin switch . {{ args }}

[linux]
nix-darwin-apply *args:
    :

nix-apply *args:
    nh home switch . -c $(whoami)@$(hostname) --accept-flake-config {{ args }}

nix-update:
    nix flake update
    @just nix-apply

@apply: apply-chezmoi nix-update

install-hooks:
    pre-commit install
