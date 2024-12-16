local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'Iosevka Nerd Font'
config.hide_tab_bar_if_only_one_tab = true
return config
