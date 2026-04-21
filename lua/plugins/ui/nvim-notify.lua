-- ~/.config/nvim/lua/plugins/ui/nvim-notify.lua

return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 1000,
  config = function()
    local notify = require("notify")
    local theme  = require("core.theme")

    -- Pull background from the active theme instead of hardcoding Nord
    local bg = (theme.get_theme_colors() or {}).bg or "#2E3440"

    notify.setup({
      background_colour = bg,
      fps           = 60,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO  = "",
        TRACE = "✎",
        WARN  = "",
      },
      level         = 2,
      minimum_width = 50,
      render        = "compact",
      stages        = "slide",
      timeout       = 2000,
      top_down      = true,
    })

    vim.notify = notify

    -- Re-apply background if the colorscheme changes at runtime
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        local new_bg = (theme.get_theme_colors() or {}).bg or "#2E3440"
        notify.setup({ background_colour = new_bg })
      end,
    })
  end,
}
