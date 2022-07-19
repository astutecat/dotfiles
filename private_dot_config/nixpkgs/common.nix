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
      nixpkgs-fmt
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
    ] ++ optionals (location == "personal") [
      elixir
      erlang
    ]
    ++ optionals (location != "other") [
      terraform
      visidata
      rustup
      cargo-edit
      cargo-udeps
      nix-prefetch-github
      graphicsmagick
    ]
    ++ optionals isLinux [
      plocate
      qmk
    ];
   }
