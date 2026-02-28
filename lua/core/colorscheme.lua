-- ~/.config/nvim/lua/core/colorscheme.lua

local theme = require("core.theme")

-- Apply the theme
theme.setup()

-- Global highlights that work with any theme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Re-apply theme-specific highlights
    theme.setup()
    
    -- Telescope customizations
    vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "Special" })
    
    -- Bufferline customizations
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { link = "Special" })
    
    -- Which-key
    vim.api.nvim_set_hl(0, "WhichKey", { link = "Special" })
    vim.api.nvim_set_hl(0, "WhichKeyGroup", { link = "Type" })
  end,
})
