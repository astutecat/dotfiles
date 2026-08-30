#!/usr/bin/env bash
#
# One-shot cleanup of manually installed fonts that duplicate fonts installed
# by home-manager (see configs/fonts.nix: b612, ibm-plex,
# nerd-fonts{iosevka,iosevka-term,monaspace,noto,symbols-only}).
#
# Platform layout:
#   darwin: manual ~/Library/Fonts, home-manager copies into
#           ~/Library/Fonts/HomeManager (targets.darwin onChange hook)
#   linux:  manual ~/.local/share/fonts (e.g. leftover download subdirs from
#           the former run_after_download_fonts.zsh), home-manager fonts live
#           in the nix profile's share/fonts and are picked up via fontconfig
#
# Only removes a family if a home-manager replacement actually exists, so a
# stale home-manager activation is never orphaned.
#
# Usage:
#   remove-duplicate-fonts.sh           # dry run, print what would happen
#   remove-duplicate-fonts.sh --apply   # move duplicates into a timestamped
#                                       # backup dir under ~/.local/share
#   remove-duplicate-fonts.sh --delete  # remove duplicates permanently
#
# FONT_CLEANUP_OS=Darwin|Linux overrides OS detection (for testing).

set -euo pipefail

MODE=dry-run
case "${1:-}" in
  --apply) MODE=apply ;;
  --delete) MODE=delete ;;
  ""|--dry-run|-n) ;;
  *) echo "usage: $0 [--apply|--delete|--dry-run]" >&2; exit 2 ;;
esac

case "${FONT_CLEANUP_OS:-$(uname)}" in
  Darwin) IS_DARWIN=1 ;;
  Linux) IS_DARWIN=0 ;;
  *) echo "error: unsupported OS '${FONT_CLEANUP_OS:-$(uname)}'" >&2; exit 1 ;;
esac

if ((IS_DARWIN)); then
  FONT_DIR="$HOME/Library/Fonts"
else
  FONT_DIR="$HOME/.local/share/fonts"
fi

# home-manager font roots to verify replacements against (searched recursively)
HM_ROOTS=()
if ((IS_DARWIN)); then
  HM_ROOTS+=("$FONT_DIR/HomeManager")
else
  for r in \
    "$HOME/.local/state/nix/profiles/profile/home-path/share/fonts" \
    "$HOME/.nix-profile/share/fonts" \
    "/etc/profiles/per-user/$USER/share/fonts"; do
    if [[ -d $r ]]; then HM_ROOTS+=("$r"); fi
  done
fi

if [[ ${#HM_ROOTS[@]} -eq 0 ]]; then
  echo "error: no home-manager font dir found to verify against" >&2
  exit 1
fi

BACKUP_DIR="$HOME/.local/share/fonts-removed-$(date +%Y%m%d-%H%M%S)"

# manual glob (in FONT_DIR)|replacement globs, comma-separated (relative to any
# HM root; checked recursively, any match counts)
SPECS=()
if ((IS_DARWIN)); then
  SPECS+=(
    'B612-*.ttf|B612-*.ttf'
    'B612Mono-*.ttf|B612Mono-*.ttf'
    'IBMPlexSans-*.otf|IBMPlexSans-*.otf'
    'IosevkaNerdFont-*.ttf|IosevkaNerdFont-*.ttf'
    'IosevkaNerdFontMono-*.ttf|IosevkaNerdFontMono-*.ttf'
    'IosevkaNerdFontPropo-*.ttf|IosevkaNerdFontPropo-*.ttf'
    'Monaspace*.otf|Monaspace*.otf'
    'SymbolsNerdFont-Regular.ttf|SymbolsNerdFont-Regular.ttf'
    'SymbolsNerdFontMono-Regular.ttf|SymbolsNerdFontMono-Regular.ttf'
  )
else
  # leftovers of the former run_after_download_fonts.zsh (nerd-fonts release
  # tarballs, extracted per-font into subdirs)
  SPECS+=(
    'Iosevka/IosevkaNerdFont*.ttf|IosevkaNerdFont*.ttf'
    'IosevkaTerm/IosevkaTermNerdFont*.ttf|IosevkaTermNerdFont*.ttf'
    'Monaspace/*.ttf|Monaspace*,Monaspice*'
    'NerdFontsSymbolsOnly/SymbolsNerdFont*.ttf|SymbolsNerdFont*.ttf'
    'Noto/NotoSansMNerdFont*.ttf|NotoSansMNerdFont*.ttf'
  )
fi

hm_has() {
  local pat r hit
  for pat in ${1//,/ }; do
    for r in "${HM_ROOTS[@]}"; do
      hit=$(find "$r" -name "$pat" -print 2>/dev/null | head -n 1)
      if [[ -n $hit ]]; then return 0; fi
    done
  done
  return 1
}

acted=0
skipped=0
created_backup=0

for spec in "${SPECS[@]}"; do
  manual_glob=${spec%%|*}
  repl_globs=${spec#*|}

  # leave $manual_glob unquoted so it expands; no spaces in these globs
  shopt -s nullglob
  files=( "$FONT_DIR/"$manual_glob )
  shopt -u nullglob

  # wildcard-less specs stay literal (bash skips the existence check), so
  # filter to files that actually exist
  real=()
  for f in "${files[@]}"; do
    if [[ -f $f ]]; then real+=("$f"); fi
  done
  files=("${real[@]}")

  [[ ${#files[@]} -eq 0 ]] && continue

  if ! hm_has "$repl_globs"; then
    printf 'SKIP  %-40s %3d file(s), no home-manager replacement (%s)\n' \
      "$manual_glob" "${#files[@]}" "$repl_globs"
    skipped=$((skipped + ${#files[@]}))
    continue
  fi

  case $MODE in
    dry-run)
      printf 'WOULD %-40s %3d file(s) (mv-to-backup)\n' \
        "$manual_glob" "${#files[@]}"
      ;;
    delete)
      printf 'RM    %-40s %3d file(s)\n' "$manual_glob" "${#files[@]}"
      ;;
    apply)
      printf 'MOVE  %-40s %3d file(s) -> %s\n' \
        "$manual_glob" "${#files[@]}" "${BACKUP_DIR#$HOME/}"
      ;;
  esac

  # act per file: re-check existence so a file that vanished between the glob
  # above and now does not abort the whole run under set -e
  for f in "${files[@]}"; do
    [[ -f $f ]] || continue
    case $MODE in
      dry-run)
        acted=$((acted + 1))
        ;;
      delete)
        rm -- "$f"
        acted=$((acted + 1))
        ;;
      apply)
        if (( ! created_backup )); then
          mkdir -p "$BACKUP_DIR"
          created_backup=1
        fi
        mv -- "$f" "$BACKUP_DIR/"
        acted=$((acted + 1))
        ;;
    esac
    # drop per-font dirs left empty (linux tarball layout); never in dry-run
    if [[ $MODE != dry-run ]]; then
      parent=$(dirname -- "$f")
      if [[ $parent != "$FONT_DIR" ]]; then
        rmdir -- "$parent" 2>/dev/null || true
      fi
    fi
  done
done

if ((acted == 0 && skipped == 0)); then
  echo "no duplicate fonts found; nothing to do"
  exit 0
fi

if ((acted > 0)); then
  case $MODE in
    dry-run) printf 'dry run: %d file(s) would be affected\n' "$acted" ;;
    delete)
      printf 'done: %d file(s) deleted\n' "$acted"
      if (( ! IS_DARWIN )) && command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f -- "$FONT_DIR" >/dev/null 2>&1 || true
      fi
      ;;
    apply)
      printf 'done: %d file(s) moved to %s\n' "$acted" "$BACKUP_DIR"
      if (( ! IS_DARWIN )) && command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f -- "$FONT_DIR" >/dev/null 2>&1 || true
      fi
      ;;
  esac
else
  echo "no files removed"
fi
((skipped)) && \
  echo "note: $skipped file(s) kept — no home-manager copy yet; run 'just nix-apply' and re-run this script"
