{ lib, ... }:
{
  programs.wezterm = {
    enable = false;
    settings = {
      color_scheme = "Tokyo Night";
      font = lib.generators.mkLuaInline ''
        wezterm.font_with_fallback({
          "MonoLisa",
          "Fira Code Nerd Font",
          "Iosevka Nerd Font",
          "Fira Code",
          "Iosevka",
        })'';
      font_size = 11;
      hide_tab_bar_if_only_one_tab = true;
      allow_win32_input_mode = true;
      send_composed_key_when_left_alt_is_pressed = false;
      initial_cols = 120;
      initial_rows = 30;
    };
  };
}
