{ lib, ... }:
let
  # Monaspace gates all of its ligatures behind stylistic sets ss01-ss10
  # (calt/liga alone only give texture healing); cv01 2 selects the slashed
  # zero. Ghostty wants HarfBuzz-style "name" / "index value" syntax.
  stySets = lib.concatStringsSep ", " [
    "ss01" # equals-family ligatures: != === =~ ~~ &=
    "ss02" # greater/less-or-equal: <= >=
    "ss03" # arrows: -> <-> --> ~> <~>
    "ss04" # markup: </ /> <!-->
    "ss05" # F# pipe operators: |> <|
    "ss06" # repeats of # + _ = &: ## ### __ ===
    "ss07" # colons: :: =:= <:
    "ss08" # period combos: ..= .- .=
    "ss09" # greater/less + equals combos: <=> >> =<<
    "ss10" # other tags: #[ #(
  ];
in
{
  programs.ghostty = {
    enable = true;
    systemd.enable = false;
    package = null; # Installed externally

    settings = {
      font-family = [
        "Monaspace Argon"
        "Symbols Nerd Font Mono"
      ];
      font-feature = "calt, liga, ${stySets}, cv01 2";
      font-size = 11;
      font-family-italic = "Monaspace Radon";

      bell-features = "no-title";

      # Nightfox colors
      background = "#192330";
      foreground = "#cdcecf";
      selection-background = "#2b3b51";
      selection-foreground = "#cdcecf";
      cursor-color = "#cdcecf";

      palette = [
        # normal
        "0=#393b44"
        "1=#c94f6d"
        "2=#81b29a"
        "3=#dbc074"
        "4=#719cd6"
        "5=#9d79d6"
        "6=#63cdcf"
        "7=#dfdfe0"
        # bright
        "8=#575860"
        "9=#d16983"
        "10=#8ebaa4"
        "11=#e0c989"
        "12=#86abdc"
        "13=#baa1e2"
        "14=#7ad5d6"
        "15=#e4e4e5"
        # extended colors
        "16=#f4a261"
      ];

      macos-option-as-alt = "left";
      keybind = [
        "alt+left=unbind"
        "alt+right=unbind"
      ];
    };
  };
}
