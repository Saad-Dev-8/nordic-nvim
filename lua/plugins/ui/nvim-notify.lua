-- ~/.config/nvim/lua/plugins/ui/nvim-notify.lua

return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 1000,
  config = function()
    local notify = require("notify")
    
    -- Setup notify with Nord colors
    notify.setup({
      background_colour = "#2E3440",
      fps = 60,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "slide",
      timeout = 2000,
      top_down = true,
    })

    -- Set as default notify
    vim.notify = notify
  end,
}
