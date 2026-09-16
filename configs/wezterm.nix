{
  lib,
  ...
}:
let
  # Monaspace gates all of its ligatures behind stylistic sets ss01-ss10
  # (matching ghostty/contour); cv01=2 selects the slashed zero. Inline Lua
  # list syntax ('name'/'name=1') for wezterm's harfbuzz_features.
  harfbuzzFeatures = lib.concatStringsSep ", " [
    "'ss01'" # equals-family ligatures: != === =~ ~~ &=
    "'ss02'" # greater/less-or-equal: <= >=
    "'ss03'" # arrows: -> <-> --> ~> <~>
    "'ss04'" # markup: </ /> <!-->
    "'ss05'" # F# pipe operators: |> <|
    "'ss06'" # repeats of # + _ = &: ## ### __ ===
    "'ss07'" # colons: :: =:= <:
    "'ss08'" # period combos: ..= .- .=
    "'ss09'" # greater/less + equals combos: <=> >> =<<
    "'ss10'" # other tags: #[ #(
    "'cv01=2'" # slashed zero (1 plain, 2 slash, 3 reverse slash, 4 cut-out)
  ];
in
{
  programs.wezterm = {
    enable = false;
    settings = {
      color_scheme = "Nightfox";
      font = lib.generators.mkLuaInline ''
        wezterm.font_with_fallback({
          wezterm.font({
            family = "Monaspace Argon",
            harfbuzz_features = { ${harfbuzzFeatures} },
          }),
          "Symbols Nerd Font Mono",
        })'';
      font_size = 11;
      hide_tab_bar_if_only_one_tab = true;
      allow_win32_input_mode = true;
      send_composed_key_when_left_alt_is_pressed = false;
      initial_cols = 110;
      initial_rows = 35;
    };
  };
}
