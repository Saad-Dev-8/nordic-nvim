-- ~/.config/nvim/lua/plugins/ui/theme-loader.lua

local theme = require("core.theme")
local current_theme = theme.get_current_theme()

if not current_theme then
  return {}
end

-- Return the theme plugin specification
return {
  {
    current_theme.plugin,
    lazy = false,
    priority = 1000,
    config = function()
      -- The theme setup is now handled by colorscheme.lua
      -- This just ensures the plugin is loaded
    end,
  },
}
