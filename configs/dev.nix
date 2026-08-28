{ lib, pkgs, ... }:
let
  generalTools = with pkgs; [
    gh
    cloc
    adrs
    universal-ctags
  ];

  beam = with pkgs; [
    beam29Packages.erlang
    beam29Packages.elixir_1_20
    beam29Packages.expert
    erlang-language-platform
    gleam
  ];

  python = with pkgs; [
    (python313.withPackages (
      ps: with ps; [
        neovim
        numpy
      ]
    ))
  ];

  rust = with pkgs; [
    rustup
    cargo-binstall
    cargo-cache
    cargo-update
    cargo-nextest
    cargo-generate
    cargo-cross
  ];

  nix = with pkgs; [
    nil
    nixd
    nixfmt
    update-nix-fetchgit
  ];
in
{
  home.file.".ctags.d/defaults.ctags".text = ''
    --recurse=yes
    --exclude=*.git*
    --exclude=*.hg*
    --exclude=*.pyc
    --exclude=*.pyo
    --exclude=.DS_Store
    --exclude=*.md
    --exclude=*.mkd
    --exclude=*.beam
  '';

  home.packages = lib.flatten [
    generalTools
    beam
    python
    rust
    nix
#
    pkgs.go
    pkgs.nodejs
    pkgs.sbcl
    pkgs.tombi
    pkgs.tree-sitter
    pkgs.uv
    pkgs.lua
  ];
}
