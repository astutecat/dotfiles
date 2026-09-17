{
  lib,
  ...
}:
{
  # Iosevka's default zero is already slashed, so no OpenType features are
  # needed here.
  programs.wezterm = {
    enable = false;
    settings = {
      color_scheme = "Nightfox";
      font = lib.generators.mkLuaInline ''
        wezterm.font_with_fallback({
          wezterm.font("Iosevka Extended"),
          "Symbols Nerd Font Mono",
        })'';
      font_rules = lib.generators.mkLuaInline ''
        {
          {
            italic = true,
            font = wezterm.font("Iosevka Extended", { italic = true }),
          },
          {
            italic = true,
            intensity = "Bold",
            font = wezterm.font("Iosevka Extended", { italic = true, bold = true }),
          },
        }'';
      font_size = 11;
      hide_tab_bar_if_only_one_tab = true;
      allow_win32_input_mode = true;
      send_composed_key_when_left_alt_is_pressed = false;
      initial_cols = 110;
      initial_rows = 35;
    };
  };
}
