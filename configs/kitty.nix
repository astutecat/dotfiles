{
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  programs.kitty = {
    enable = true;

    themeFile = "Nightfox";

    shellIntegration = {
      enableZshIntegration = false;
      mode = "no-cursor";
    };

    settings = {
      # hide_window_decorations = "titlebar-only";
      confirm_os_window_close = 0;

      initial_window_width = if isDarwin then "120c" else "110c";
      initial_window_height = if isDarwin then "45c" else "35c";

      font_size = if isDarwin then 13.0 else 10.0;

      font_family = "Monaspace Argon";
      bold_font = ''family="Monaspace Argon" style=SemiBold'';
      bold_italic_font = ''family="Monaspace Radon" style="SemiBold Italic"'';
      italic_font = "Monaspace Radon";
    };
    # font_features is keyed by PostScript name. The stylistic sets are
    # Monaspace's ligature gate (calt/liga alone only give texture healing):
    #   ss01 equals-family ligatures: != === =~ ~~ &=
    #   ss02 greater/less-or-equal: <= >=
    #   ss03 arrows: -> <-> --> ~> <~>
    #   ss04 markup: </ /> <!-->
    #   ss05 F# pipe operators: |> <|
    #   ss06 repeats of # + _ = &: ## ### __ ===
    #   ss07 colons: :: =:= <:
    #   ss08 period combos: ..= .- .=
    #   ss09 greater/less + equals combos: <=> >> =<<
    #   ss10 other tags: #[ #(
    # cv01=2 selects the slashed zero (default zero is plain)
    extraConfig = ''
      font_features MonaspaceArgon-Regular +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +ss07 +ss08 +ss09 +ss10 +cv01=2
      font_features MonaspaceArgon-SemiBold +cv01=2
      font_features MonaspaceRadon-Italic +cv01=2
      font_features MonaspaceRadon-SemiBoldItalic +cv01=2
    '';
  };
}
