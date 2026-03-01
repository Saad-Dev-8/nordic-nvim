-- ~/.config/nvim/lua/plugins/ui/highlight-colors.lua

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    render = "background",
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_named_colors = true,
  },
  config = function(_, opts)
    -- Safely try to setup
    pcall(function()
      require("nvim-highlight-colors").setup(opts)
    end)
    
    -- Safe toggle
    vim.keymap.set("n", "<leader>uc", function()
      pcall(function()
        local current_state = require("nvim-highlight-colors").toggle()
        vim.notify("Color highlighting " .. (current_state and "enabled" or "disabled"), vim.log.levels.INFO)
      end)
    end, { desc = "Toggle color highlighting" })
  end,
}
