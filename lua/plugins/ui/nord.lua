-- ~/.config/nvim/lua/plugins/ui/nord.lua

return {
  "shaunsingh/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- No setup() function needed for this plugin
    -- Just set the colorscheme directly
    vim.cmd.colorscheme("nord")
    
    -- Optional: Custom highlights after theme is loaded
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "nord",
      callback = function()
        -- Customize some highlights for better contrast
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#4C566A" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D8DEE9", bold = true })
        vim.api.nvim_set_hl(0, "Comment", { fg = "#616E88", italic = true })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#3B4252" })
        
        -- Telescope customizations
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#88C0D0", bg = "#2E3440" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#81A1C1", bg = "#2E3440" })
        
        -- Bufferline customizations
        vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#88C0D0" })
        vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#2E3440" })
        
        -- LSP Diagnostics
        vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#BF616A" })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#EBCB8B" })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#88C0D0" })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#81A1C1" })
      end,
    })
  end,
}
