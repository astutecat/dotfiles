#!/usr/bin/env bash
#
# One-shot cleanup of files/dirs formerly managed by chezmoi that are not
# managed by `just nix-apply -b backup` (home-manager) either.
#
# Default: move everything into a timestamped backup dir under
# ~/.local/share. Run with --delete to remove permanently instead.

set -euo pipefail

DELETE=0
[[ "${1:-}" == "--delete" ]] && DELETE=1

PATHS=(
  # former cheat setup; home-manager now uses ~/.local/share/cheat
  .config/cheat/cheatsheets
  .config/direnv/lib/use_sops.sh

  # fish functions/conf dropped in the nix migration
  .config/fish/conf.d/abbreviations.fish
  .config/fish/conf.d/prompt.fish
  .config/fish/conf.d/variables.fish
  .config/fish/functions/reapply_tide_prompt.fish
  .config/fish/functions/update_fish_completions.fish
  .config/fish/functions/y.fish

  # tide plugin files from the old fisher install (incl. ~47 functions/
  # _tide_*.fish); tide now loads from the nix store via configs/shell.nix
  .config/fish/fish_plugins
  .config/fish/completions/tide.fish
  .config/fish/conf.d/_tide_init.fish
  .config/fish/functions/fish_prompt.fish
  .config/fish/functions/fish_mode_prompt.fish
  .config/fish/functions/tide
  .config/fish/functions/tide.fish
  .config/fish/functions/_tide_item_jj.fish
  .config/fish/functions/_tide_item_jj.fish.backup

  # apps dropped entirely or now configured elsewhere (lazygit/tealdeer use
  # ~/Library/Application Support on macOS via home-manager)
  .config/kitty
  .config/lazygit
  .config/neofetch
  .config/swaylock
  .config/tealdeer
  .local/share/tealdeer

  # linux-only tools whose chezmoi config is gone
  .config/tmux
  .config/zathura
  .config/zellij

  # moved to nix profile binaries, ~/.local/bin copies are stale
  .local/bin/age
  .local/bin/age-keygen
  .local/bin/mr
  .local/bin/pert
  .local/bin/pert-bash
  .local/bin/tfg
  .local/bin/tfg.py

  # misc
  .default-python-packages
  .wezterm.lua
  .config/zsh
)

backup="${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi-migration-backup-$(date +%Y%m%d-%H%M%S)"

count=0
for rel in "${PATHS[@]}"; do
  target="$HOME/$rel"
  [[ -e "$target" || -L "$target" ]] || continue

  if [[ "$DELETE" -eq 1 ]]; then
    rm -rf "$target"
    printf 'deleted %s\n' "$rel"
  else
    mkdir -p "$backup/$(dirname "$rel")"
    mv "$target" "$backup/$rel"
    printf 'moved   %s\n' "$rel"
  fi
  count=$((count + 1))
done

printf 'done: %d path(s)\n' "$count"
if [[ "$DELETE" -eq 0 && "$count" -gt 0 ]]; then
  printf 'backup: %s\n' "$backup"
fi
printf 'next: just nix-apply -b backup\n'
