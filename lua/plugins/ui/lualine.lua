-- ~/.config/nvim/lua/plugins/ui/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = function()
    -- Get current theme to set appropriate lualine theme
    local theme = require("core.theme")
    local current_theme = theme.get_theme_name()
    
    -- Map themes to lualine themes using a table
    local theme_map = {
      nord = "nord",
      tokyonight = "tokyonight",
      catppuccin = "catppuccin",
      gruvbox = "gruvbox",
      onedark = "onedark",
    }
    
    local lualine_theme = theme_map[current_theme] or "auto"
    
    -- Custom component to show error lens status
    local function error_lens_status()
      local current_config = vim.diagnostic.config()
      local enabled = current_config.signs and current_config.signs.linehl ~= nil
      return enabled and " EL" or " EL"  --  = enabled,  = disabled
    end
    
    return {
      options = {
        theme = lualine_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard" },
        },
        globalstatus = false,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 
          "branch", 
          "diff",
          { 
            "diagnostics", 
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_c = { 
          { 
            "filename", 
            file_status = true,
            path = 1,
          },
        },
        lualine_x = { 
          "encoding", 
          "fileformat", 
          { "filetype", colored = true },
          error_lens_status,  -- Add error lens status here
        },
        lualine_y = { "progress" },
        lualine_z = { 
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive", "neo-tree", "trouble" },
    }
  end,
}
