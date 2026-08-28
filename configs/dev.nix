{ lib, pkgs, ... }:
let
  generalTools = with pkgs; [
    adrs
    cloc
    # comby
    gh
    jujutsu
    stgit
    tmate
    typos-lsp
    universal-ctags
  ];

  bashPkgs = with pkgs; [
    shellcheck
    shellharden
  ];

  beamPkgs = with pkgs; [
    beam29Packages.erlang
    beam29Packages.elixir_1_20
    beam29Packages.expert
    erlang-language-platform
    gleam
  ];

  luaPkgs = with pkgs; [
    lua
    stylua
    luaPackages.luacheck
  ];

  pythonPkgs = with pkgs; [
    (python313.withPackages (
      ps: with ps; [
        neovim
        numpy
      ]
    ))
  ];

  rustPkgs = with pkgs; [
    rustup
    cargo-binstall
    cargo-cache
    cargo-update
    cargo-nextest
    cargo-generate
    cargo-cross
  ];

  sqlPkgs = with pkgs; [
    sleek
    lazysql
  ];

  nixPkgs = with pkgs; [
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
    bashPkgs
    beamPkgs
    luaPkgs
    pythonPkgs
    rustPkgs
    sqlPkgs
    nixPkgs
#
    pkgs.go
    pkgs.nodejs
    pkgs.sbcl
    pkgs.tombi
    pkgs.tree-sitter
    pkgs.uv
  ];
}
