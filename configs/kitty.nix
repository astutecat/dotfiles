{
  lib,
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

      font_size = lib.mkIf isDarwin 13.0;
      font_family = "Monaspace Argon Var";
      bold_font = "Monaspace Argon Var";
      italic_font = "Monaspace Radon Var";
    };
  };
}
