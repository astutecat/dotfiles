
[private]
default:
  @just --justfile "{{justfile()}}" --list

@apply:
  echo -n "applying dotfiles..."
  chezmoi apply
  echo "done"

watch:
  watchexec -- just apply

commit message:
  git add .
  git commit -m "{{message}}"
