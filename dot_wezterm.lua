-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- ============================================
-- Window Configuration
-- ============================================
config.initial_cols = 100
config.initial_rows = 30

-- ============================================
-- Font Configuration
-- ============================================
-- Using the correct font name found on the system
config.font = wezterm.font('MesloLGS Nerd Font')
config.font_size = 14.5

-- Font rendering is handled by freetype settings
config.freetype_load_target = 'Normal'
config.freetype_render_target = 'Normal'

-- ============================================
-- Color Scheme - Homebrew
-- ============================================
config.color_scheme = 'GitHub Dark'

-- ============================================
-- Tab Bar Configuration
-- ============================================
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = true

-- Adjust tab bar font size to control height (works with fancy tab bar)
config.window_frame = {
  font = wezterm.font({ family = 'MesloLGS Nerd Font', weight = 'Bold' }),
  font_size = 13.5,  -- Adjust this to change tab bar height (smaller = thinner tabs)
}

-- ============================================
-- Window Appearance
-- ============================================
-- Window padding
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Window background opacity
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

-- ============================================
-- Cursor Configuration
-- ============================================
config.default_cursor_style = 'SteadyBlock'

-- ============================================
-- Scrollback
-- ============================================
config.enable_scroll_bar = true
config.scrollback_lines = 10000  -- Large scrollback buffer

-- ============================================
-- Mouse
-- ============================================
config.pane_focus_follows_mouse = false

-- ============================================
-- Bell
-- ============================================
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

-- ============================================
-- Terminal Settings
-- ============================================
config.term = 'xterm-256color'

-- ============================================
-- Performance
-- ============================================
config.max_fps = 60
config.animation_fps = 60

-- ============================================
-- Window Decorations
-- ============================================
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'

-- ============================================
-- Miscellaneous
-- ============================================
config.automatically_reload_config = true
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400 -- Check for updates every 24 hours

-- ============================================
-- Key Bindings
-- ============================================
config.keys = {
  -- Split horizontally (left/right) with Cmd+D
  -- Similar to iTerm2's Cmd+D (splits pane side-by-side)
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split vertically (top/bottom) with Shift+Cmd+D
  -- Similar to iTerm2's Shift+Cmd+D (splits pane top/bottom)
  {
    key = 'D',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}

-- Finally, return the configuration to wezterm:
return config

