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

      font_family = "Iosevka Extended";
      bold_font = ''family="Iosevka Extended" style=Bold'';
      bold_italic_font = ''family="Iosevka Extended" style="Bold Italic"'';
      italic_font = ''family="Iosevka Extended" style=Italic'';
    };
  };
}
