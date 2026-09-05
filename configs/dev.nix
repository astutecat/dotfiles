{
  lib,
  pkgs,
  config,
  ...
}:
let
  generalTools = with pkgs; [
    adrs
    cloc
    tmate
    universal-ctags
    exercism
  ];

  bashPkgs = with pkgs; [
    shellcheck
    shellharden
  ];

  beamPkgs = with pkgs; [
    beam29Packages.erlang
    beam29Packages.elixir_1_20
    beam29Packages.expert
    gleam
  ];

  luaPkgs = with pkgs; [
    lua
    stylua
    luaPackages.luacheck
  ];

  pythonPkgs = with pkgs; [
    (python313.withPackages (
      ps:
      with ps;
      [
        numpy
      ]
      ++ config.dev.extraPythonPackages
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
    omnix
    nixfmt
    update-nix-fetchgit
  ];
in
{
  options.dev.extraPythonPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    description = "Extra Python packages added to the shared python313 environment.";
  };

  config = {
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
      pkgs.tree-sitter
      pkgs.uv
    ];
  };
}
