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

  # fish leftovers not managed by chezmoi or home-manager
  .config/fish/config.fish.backup
  .config/fish/fish_variablesmGB2EbnEFr
  .config/fish/conf.d/fish_frozen_key_bindings.fish

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

  # ssh config.d split retired by the nix migration; the github.com block now
  # lives in programs.ssh and ~/.ssh/config is a home-manager symlink
  .ssh/config.d

  # configs migrated to home-manager modules (configs/mise.nix,
  # configs/shikane.nix on nb0408, configs/dircolors.nix); home-manager
  # manages these paths now and activation would fail on stale copies
  .config/mise/config.toml
  .config/shikane/config.toml
  .dir_colors

  # fonts now come from nix packages via configs/fonts.nix (b612, IBM Plex,
  # nerd fonts formerly fetched by run_after_download_fonts, ...); fontconfig
  # scans this dir too, so leftovers would duplicate the nix-installed fonts
  .local/share/fonts

  # misc
  .default-python-packages
  .wezterm.lua
  .config/zsh
)

backup="${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi-migration-backup-$(date +%Y%m%d-%H%M%S)"

count=0

remove() {
  local target="$1" label="$2"
  [[ -e "$target" || -L "$target" ]] || return 0

  if [[ "$DELETE" -eq 1 ]]; then
    rm -rf "$target"
    printf 'deleted %s\n' "$label"
  else
    mkdir -p "$backup/$(dirname "$label")"
    mv "$target" "$backup/$label"
    printf 'moved   %s\n' "$label"
  fi
  count=$((count + 1))
}

for rel in "${PATHS[@]}"; do
  remove "$HOME/$rel" "$rel"
done

# Stale tide/fisher function copies left in the user functions dir; the user
# dir comes first in $fish_function_path, so these shadow the nix-store
# plugin loaded via configs/shell.nix. Custom items (_tide_item_git_or_jj)
# and home-manager symlinks are kept.
for f in "$HOME"/.config/fish/functions/_tide_*.fish \
         "$HOME"/.config/fish/functions/configure_tide.fish \
         "$HOME"/.config/fish/functions/fisher.fish \
         "$HOME"/.config/fish/functions/*.backup; do
  [[ "$f" == *_tide_item_git_or_jj.fish ]] && continue
  remove "$f" "${f#"$HOME"/}"
done

# Homebrew packages now provided by nix via home-manager (all hosts; includes
# linuxbrew equivalents like bluetui/zathura/lorri used on the Linux boxes).
# Only uninstalls formulae/casks that are actually installed. ghostty is
# deliberately NOT removed: programs.ghostty.package = null (installed
# externally); wezterm is disabled, not nix-provided. Formulae with brew
# dependents (e.g. gawk, unzip) are refused by brew and left alone.
if command -v brew >/dev/null 2>&1; then
  comm -12 <(brew list --formula | sort) \
    <(printf '%s\n' age adrs atuin babelfish bash bluetui bottom \
      cargo-binstall cargo-cache cargo-generate cargo-nextest cargo-update \
      cheat cloc comby cross difftastic direnv dust dysk elixir emacs eza \
      exercism fastfetch fd fish fzf fortune gawk gh git git-delta gleam go \
      helix htop hyperfine just jujutsu lazysql lnav lua luacheck mise most \
      mr nix nix-direnv nixd nixfmt nh nodejs nil opencode prek python@3.13 \
      restic ripgrep rustup sbcl shellcheck shellharden sops sleek stgit \
      stylua tealdeer the_silver_searcher tmate tombi topgrade tree-sitter \
      typos-lsp universal-ctags unzip update-nix-fetchgit usage uv visidata \
      watchexec zathura zellij zoxide zsh | sort) \
    | xargs brew uninstall --formula || true
  comm -12 <(brew list --cask | sort) \
    <(printf '%s\n' imhex keymapp | sort) \
    | xargs brew uninstall --cask || true

  # Prune old versions and stale downloads left behind by the uninstalls
  brew cleanup || true
fi

printf 'done: %d path(s)\n' "$count"
if [[ "$DELETE" -eq 0 && "$count" -gt 0 ]]; then
  printf 'backup: %s\n' "$backup"
fi
printf 'next: just nix-apply -b backup\n'
