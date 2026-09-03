set shell := ["bash", "-cu"]

[private]
default:
    @just --justfile "{{ justfile() }}" --list

watch:
    watchexec -- just apply

[macos]
nix-darwin-apply *args:
    nh darwin switch . {{ args }}

[linux]
nix-darwin-apply *args:
    @:

nix-apply *args:
    nh home switch . -c $(whoami)@$(hostname) --accept-flake-config {{ args }}

nix-update:
    nix flake update
    update-nix-fetchgit **/*.nix

@apply: nix-darwin-apply nix-apply

install-hooks:
    pre-commit install
