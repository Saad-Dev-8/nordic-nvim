-- ~/.config/nvim/lua/plugins/ui/theme-loader.lua

local theme = require("core.theme")
local current_theme = theme.get_current_theme()

if not current_theme then
  return {}
end

return {
  {
    current_theme.plugin,
    lazy = false,       -- must not be lazy-loaded
    priority = 1000,    -- load before all other plugins
    config = function()
      -- Apply colorscheme + highlights + diagnostic config
      theme.setup()
      -- Setup error lens keymap
      theme.setup_keymaps()
    end,
  },
}
