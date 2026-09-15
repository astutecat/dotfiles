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

      initial_window_size = "110x35";

      font_size = if isDarwin then 13.0 else 10.0;
      font_family = "Monaspace Argon Var";
      bold_font = "Monaspace Argon Var";
      italic_font = "Monaspace Radon Var";
    };
  };
}
