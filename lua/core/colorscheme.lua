-- ~/.config/nvim/lua/core/colorscheme.lua

-- This will be loaded after plugins
-- For now, set a temporary colorscheme until nord loads
vim.cmd.colorscheme("habamax")

-- Nord theme will override this when it loads

-- Optional: Set some Nord-specific highlight groups
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nord",
  callback = function()
    -- Customize some highlights for better contrast
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#4C566A" })  -- Softer line numbers
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D8DEE9", bold = true })
    vim.api.nvim_set_hl(0, "Comment", { fg = "#616E88", italic = true })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#3B4252" })
  end,
})
