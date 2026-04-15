-- ~/.config/nvim/lua/plugins/ui/highlight-colors.lua

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>uc",
      function()
        local hc = require("nvim-highlight-colors")
        vim.g._highlight_colors_enabled = not vim.g._highlight_colors_enabled
        if vim.g._highlight_colors_enabled then
          hc.turnOn()
          vim.notify("Color highlighting enabled", vim.log.levels.INFO)
        else
          hc.turnOff()
          vim.notify("Color highlighting disabled", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle color highlighting",
    },
  },
  opts = {
    render              = "background",
    enable_hex          = true,
    enable_short_hex    = true,
    enable_rgb          = true,
    enable_hsl          = true,
    enable_named_colors = true,
  },
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
    vim.g._highlight_colors_enabled = true 
  end,
}
