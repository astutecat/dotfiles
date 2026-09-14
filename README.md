# dotfiles

Nix flake that manages user environments with [home-manager](https://github.com/nix-community/home-manager) and, on macOS, system settings with [nix-darwin](https://github.com/nix-darwin/nix-darwin). It targets three machines:

| Host | System | User | Notes |
| --- | --- | --- | --- |
| `AstuteMBP` | `aarch64-darwin` | `astutecat` | macOS, uses nix-darwin + homebrew |
| `astutecachy` | `x86_64-linux` | `astutecat` | Linux desktop, genericLinux |
| `nb0408` | `x86_64-linux` | `willrog` | Work machine, genericLinux + sway |

Config is split as follows:

- `flake.nix` - inputs, dev shell, and output definitions (`homeConfigurations`, `darwinConfigurations`).
- `home/` - shared home-manager modules imported by every host.
- `hosts/<host>/` - per-host `home.nix` / `darwin.nix`.
- `configs/` - individual program configs (shell, git, editors, terminals, etc.).
- `editors/` - Helix, Zed, Doom Emacs, LSP.
- `services/` - nix-gc and restic backups.

## Requirements

- Nix with flakes enabled (`nix-command`, `flakes`).
- `git`.
- SSH access to the private flake inputs:
  - `git@git.sr.ht:~schemar/fonts`
  - `git@github.com:astutecat/moneymoney-to-ynab-rs`
- macOS only: a previous nix-darwin setup so `darwin-rebuild` is available.
- Optional but used by the `just` recipes: `nh`, `just`, `direnv`, `watchexec`.

## Getting up and running

Clone the repo:

```sh
git clone git@github.com:astutecat/dotfiles.git
cd dotfiles
```

Enter the dev shell. `.envrc` runs `use flake`; with direnv installed:

```sh
direnv allow
```

Otherwise:

```sh
nix develop
```

The dev shell provides `just`, `direnv`, `prek`, and the pre-commit hooks. Hooks are generated at `.pre-commit-config.yaml` on entry and run on `pre-push` (plus `gitlint` on `commit-msg`).

## Applying the config

The `justfile` wraps `nh`. Apply everything for the current machine:

```sh
just apply
```

Or apply the pieces individually:

```sh
# Linux
just nix-apply

# macOS (home + system)
just nix-apply
just nix-darwin-apply
```

The underlying commands are:

```sh
# Linux home environment
nh home switch . -c $(whoami)@$(hostname -s) --accept-flake-config

# macOS system (nix-darwin)
nh darwin switch .
```

Watch for changes and re-apply on save:

```sh
just watch
```

## Updating inputs

```sh
just nix-update
```

This runs `nix flake update` and refreshes fetchgit pins in all `.nix` files.

## Validate changes

```sh
nix flake check --all-systems
```

This is also run by the `nix-flake-check` pre-push hook. The formatter is `nixfmt`:

```sh
nix fmt
```
