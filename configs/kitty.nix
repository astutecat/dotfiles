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
      hide_window_decorations = "titlebar-only";
      confirm_os_window_close = 0;

      initial_window_size = "110x35";

      font_size = if isDarwin then 13.0 else 10.0;
      # Only the "Frozen" builds of Monaspace actually ligate under kitty:
      # their ligature substitutions live directly in calt; the static/Var
      # builds gate ligatures behind ss sets that kitty doesn't pass through.
      # cv01 (slashed zero) etc. aren't exposed in Frozen; ghostty handles
      # those instead (see configs/ghostty.nix).
      font_family = "Monaspace Argon Frozen";
      bold_font = "Monaspace Argon Frozen";
      italic_font = "Monaspace Radon Frozen";
    };
  };
}
