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
    nh home switch . -c $(whoami)@$(hostname -s) --accept-flake-config {{ args }}

nix-update:
    nix flake update
    fd -e nix -x update-nix-fetchgit

@apply: nix-darwin-apply nix-apply
