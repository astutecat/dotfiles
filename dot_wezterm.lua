local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- config.color_scheme = 'AdventureTime'
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  "MonoLisa",
  "Fira Code Nerd Font",
  "Iosevka Nerd Font",
  "Fira Code",
  "Iosevka",
})
config.hide_tab_bar_if_only_one_tab = true
config.allow_win32_input_mode = true
config.send_composed_key_when_left_alt_is_pressed = false
return config
