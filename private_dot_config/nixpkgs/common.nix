{ pkgs, workConfig, location, ... }:
with pkgs;
with lib;
let
  inherit (stdenv) isLinux;
  inherit (lib) optionalString optionals;

  elixir = beam.packages.erlangR25.elixir_1_14;
  inherit (beam.packages.erlangR25) erlang;
in {
  home.packages = with pkgs;
    [
    ] ++ optionals (location != "other") [
    ]
    ++ optionals isLinux [
      plocate
      qmk
      gcc
    ] ++ optionals workConfig [
      terraform
      visidata
      rustup
      cargo-edit
      cargo-udeps
      nix-prefetch-github
      graphicsmagick
      fira-mono
      fira
      tealdeer
      fd
      chezmoi
      sops
      age
      paperkey
      gnupg
      cfssl
      cocogitto
      croc
      angle-grinder
      lnav
      du-dust
      asdf-vm
      entr
      just
      asciinema
      agg
      nixpkgs-fmt
      shellcheck
      rnix-lsp
      nodePackages.markdownlint-cli
      rust-analyzer
      yaml-language-server
      yamllint
      ripgrep
      fd
      fzy
      tree-sitter
      yamllint
      dprint
      universal-ctags
      proselint
      par
      curl
    ];
   }
