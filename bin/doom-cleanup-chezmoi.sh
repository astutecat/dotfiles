#!/usr/bin/env bash
#
# Oneshot cleanup for migrating Doom Emacs from chezmoi to home-manager
# (nix-doom-emacs-unstraightened). Run this BEFORE `just nix-apply`.
#
# What it removes / archives:
#   1. ~/.config/emacs      - doomemacs git clone installed by the deleted
#                             .chezmoiexternal.toml entry. Chezmoi does not
#                             auto-remove externals, so it must go manually.
#                             Moved to a backup dir, not deleted: it contains
#                             Doom's old mutable state under emacs/.local.
#   2. ~/.config/doom/{init,config,packages}.el - formerly managed by
#                             chezmoi/private_dot_config/doom, now embedded in
#                             configs/doom-emacs.nix. Deleted outright; chezmoi
#                             would also remove these on its next apply.
#
# Idempotent: safe to re-run. Never touches custom.el or other unmanaged files.

set -euo pipefail

note() { printf '==> %s\n' "$*"; }
warn() { printf 'warning: %s\n' "$*" >&2; }

backup_root="${XDG_DATA_HOME:-$HOME/.local/share}/doom-chezmoi-backup-$(date +%Y%m%d-%H%M%S)"

# --- 1. The doomemacs clone from .chezmoiexternal.toml -----------------------
emacs_dir="$HOME/.config/emacs"

if [[ -L "$emacs_dir" || -e "$emacs_dir" ]]; then
  mkdir -p "$(dirname "$backup_root")"
  note "moving $emacs_dir -> $backup_root/emacs"
  mv "$emacs_dir" "$backup_root/emacs"
else
  note "$emacs_dir absent; already clean"
fi

# --- 2. doomdir files formerly managed by chezmoi ----------------------------
doom_dir="$HOME/.config/doom"

if [[ -d "$doom_dir" ]]; then
  removed=0
  for f in init.el config.el packages.el; do
    if [[ -e "$doom_dir/$f" || -L "$doom_dir/$f" ]]; then
      rm -f "$doom_dir/$f"
      note "removed $doom_dir/$f"
      removed=1
    fi
  done

  leftovers="$(find "$doom_dir" -mindepth 1 -maxdepth 1)"
  if [[ -n "$leftovers" ]]; then
    warn "unmanaged files remain in $doom_dir and were kept:"
    printf '%s\n' "$leftovers" | sed 's/^/    /'
    if [[ -f "$doom_dir/custom.el" ]]; then
      warn "custom.el is no longer loaded automatically by Unstraightened;"
      warn "port any wanted settings into configs/doom-emacs.nix (configEl)."
    fi
  else
    rmdir "$doom_dir"
    note "removed empty $doom_dir"
  fi
else
  note "$doom_dir absent; already clean"
fi

# --- 3. Sanity checks for other stale installs -------------------------------
if [[ -d "$HOME/.emacs.d" ]]; then
  warn "$HOME/.emacs.d exists; Unstraightened does not use it, but Doom's"
  warn "doctor may complain about a second config."
fi

if command -v brew >/dev/null 2>&1 && [[ -x "$(brew --prefix)/bin/emacs" ]]; then
  warn "homebrew provides $(brew --prefix)/bin/emacs which is earlier in PATH"
  warn "than the nix profile: it will keep shadowing the nix-provided 'emacs'."
  warn "Consider: brew uninstall emacs && brew uninstall --cask emacs"
fi

note "done. Next steps:"
printf '    chezmoi apply        # drop former ~/.config/doom tracking state\n'
printf '    just nix-apply       # build + activate the new home-manager config\n'
