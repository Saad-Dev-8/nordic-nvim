-- ~/.config/nvim/lua/core/theme.lua

-- Theme manager for nordic-nvim
-- Users can change this to their preferred theme
-- Available themes: "nord", "tokyonight", "catppuccin", "gruvbox", "onedark"

local M = {}

-- Default theme (users can change this)
M.current_theme = "gruvbox"  -- Change this to switch themes

-- Helper function to blend colors for error lens
local function blend_color(hex, bg_hex, alpha)
  alpha = alpha or 0.15
  
  local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)), 
           tonumber("0x" .. hex:sub(3, 4)), 
           tonumber("0x" .. hex:sub(5, 6))
  end
  
  local r, g, b = hex_to_rgb(hex)
  local br, bg, bb = hex_to_rgb(bg_hex or "#2E3440")
  
  r = math.floor(r * alpha + br * (1 - alpha))
  g = math.floor(g * alpha + bg * (1 - alpha))
  b = math.floor(b * alpha + bb * (1 - alpha))
  
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Theme configurations
M.themes = {
  -- Nord theme
  nord = {
    plugin = "shaunsingh/nord.nvim",
    colorscheme = "nord",
    colors = {
      bg = "#2E3440",
      bg_light = "#3B4252",
      bg_lighter = "#434C5E",
      fg = "#D8DEE9",
      accent = "#88C0D0",
      error = "#BF616A",
      warn = "#EBCB8B",
      hint = "#A3BE8C",
      info = "#81A1C1",
    },
    setup = function()
      -- Set colorscheme
      vim.cmd.colorscheme("nord")
      
      -- Apply theme-specific highlights
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#4C566A" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D8DEE9", bold = true })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#616E88", italic = true })
    end,
  },

  -- Tokyo Night theme
  tokyonight = {
    plugin = "folke/tokyonight.nvim",
    colorscheme = "tokyonight-night",
    colors = {
      bg = "#1A1B26",
      bg_light = "#24283B",
      bg_lighter = "#2A2F44",
      fg = "#C0CAF5",
      accent = "#7AA2F7",
      error = "#F7768E",
      warn = "#E0AF68",
      hint = "#9ECE6A",
      info = "#7DCFFF",
    },
    setup = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
      })
      vim.cmd.colorscheme("tokyonight-night")
      
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#3B4261" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FF9E64", bold = true })
    end,
  },

  -- Catppuccin theme
  catppuccin = {
    plugin = "catppuccin/nvim",
    colorscheme = "catppuccin",
    colors = {
      bg = "#1E1E2E",
      bg_light = "#302D41",
      bg_lighter = "#45475A",
      fg = "#CDD6F4",
      accent = "#89B4FA",
      error = "#F38BA8",
      warn = "#F9E2AF",
      hint = "#A6E3A1",
      info = "#89DCEB",
    },
    setup = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          telescope = true,
          which_key = true,
          notify = true,
          neo_tree = true,
          cmp = true,
          gitsigns = true,
          treesitter = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
      
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#6C7086" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F5E0DC", bold = true })
    end,
  },

  -- Gruvbox theme
  gruvbox = {
    plugin = "ellisonleao/gruvbox.nvim",
    colorscheme = "gruvbox",
    colors = {
      bg = "#282828",
      bg_light = "#3C3836",
      bg_lighter = "#504945",
      fg = "#EBDBB2",
      accent = "#83A598",
      error = "#FB4934",
      warn = "#FABD2F",
      hint = "#B8BB26",
      info = "#83A598",
    },
    setup = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
      vim.cmd.colorscheme("gruvbox")
      
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#7C6F64" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FABD2F", bold = true })
    end,
  },

  -- OneDark theme
  onedark = {
    plugin = "navarasu/onedark.nvim",
    colorscheme = "onedark",
    colors = {
      bg = "#282C34",
      bg_light = "#353B45",
      bg_lighter = "#3E4452",
      fg = "#ABB2BF",
      accent = "#61AFEF",
      error = "#E06C75",
      warn = "#E5C07B",
      hint = "#98C379",
      info = "#56B6C2",
    },
    setup = function()
      require("onedark").setup({
        style = "darker",
        transparent = false,
        code_style = {
          comments = "italic",
          keywords = "bold",
          functions = "italic,bold",
        },
      })
      vim.cmd.colorscheme("onedark")
      
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#4B5263" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#98C379", bold = true })
    end,
  },
}

-- Function to get current theme config
function M.get_current_theme()
  return M.themes[M.current_theme]
end

-- Function to get current theme name
function M.get_theme_name()
  return M.current_theme
end

-- Function to get current theme colors
function M.get_theme_colors()
  local theme = M.get_current_theme()
  return theme and theme.colors or M.themes.nord.colors
end

-- Function to setup error lens with current theme colors
function M.setup_error_lens()
  local colors = M.get_theme_colors()
  
  -- Create blended highlight groups for each severity
  vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { 
    bg = blend_color(colors.error, colors.bg, 0.15) 
  })
  vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { 
    bg = blend_color(colors.warn, colors.bg, 0.15) 
  })
  vim.api.nvim_set_hl(0, "DiagnosticHintLine", { 
    bg = blend_color(colors.hint, colors.bg, 0.15) 
  })
  vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { 
    bg = blend_color(colors.info, colors.bg, 0.15) 
  })
  
  -- Configure diagnostics to use line highlighting
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
        [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
        [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
        [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
      },
    },
    virtual_text = {
      prefix = "●",
      spacing = 4,
    },
    underline = true,
    update_in_insert = true,
  })
end

-- Function to setup the current theme
function M.setup()
  local theme = M.get_current_theme()
  if theme and theme.setup then
    theme.setup()
  end
  
  -- Setup error lens with theme colors
  M.setup_error_lens()
  
  -- Force a refresh of UI components
  vim.defer_fn(function()
    pcall(vim.cmd, "LualineRefresh")
    pcall(vim.cmd, "Noice dismiss")
  end, 100)
end

-- Function to toggle error lens
function M.toggle_error_lens()
  local current_config = vim.diagnostic.config()
  local new_state = not (current_config.signs and current_config.signs.linehl)
  
  if new_state then
    -- Re-enable with current theme colors
    M.setup_error_lens()
  else
    -- Disable line highlighting
    vim.diagnostic.config({
      signs = {
        linehl = nil,
      },
    })
  end
  
  vim.notify("Error Lens " .. (new_state and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- Setup keymap for error lens toggle
function M.setup_keymaps()
  vim.keymap.set("n", "<leader>ue", M.toggle_error_lens, { desc = "Toggle error lens" })
end

return M
