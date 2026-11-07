local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Latte"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0
config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

return config
