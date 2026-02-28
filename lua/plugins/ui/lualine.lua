-- ~/.config/nvim/lua/plugins/ui/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      -- Use the Nord theme
      theme = "nord",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "alpha", "dashboard" },
      },
      always_divide_middle = true,
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
          colored = true,
          always_visible = false,
        },
      },
      lualine_c = { 
        { 
          "filename", 
          file_status = true,
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          shorting_target = 40,
          symbols = {
            modified = "[+]",
            readonly = "[-]",
            unnamed = "[No Name]",
          },
        },
      },
      lualine_x = { 
        "encoding", 
        "fileformat", 
        { 
          "filetype",
          colored = true,
          icon_only = false,
        },
      },
      lualine_y = { "progress" },
      lualine_z = { 
        { 
          "location",
          padding = { left = 1, right = 1 },
        },
        "searchcount",
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
    extensions = { "fugitive", "nvim-tree", "trouble" },
  },
}
