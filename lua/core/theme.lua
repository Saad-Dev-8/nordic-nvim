-- ~/.config/nvim/lua/core/theme.lua
-- Theme manager for nordic-nvim
-- To switch themes, change M.current_theme below.
-- Available: "nord", "tokyonight", "catppuccin", "gruvbox", "onedark"

local M = {}

M.current_theme = "nord"

-- Blend a foreground hex color into a background hex color at a given alpha
local function blend_color(hex, bg_hex, alpha)
  alpha = alpha or 0.15
  local function hex_to_rgb(h)
    h = h:gsub("#", "")
    return tonumber("0x" .. h:sub(1, 2)),
           tonumber("0x" .. h:sub(3, 4)),
           tonumber("0x" .. h:sub(5, 6))
  end
  local r, g, b   = hex_to_rgb(hex)
  local br, bg, bb = hex_to_rgb(bg_hex or "#2E3440")
  return string.format("#%02x%02x%02x",
    math.floor(r * alpha + br * (1 - alpha)),
    math.floor(g * alpha + bg * (1 - alpha)),
    math.floor(b * alpha + bb * (1 - alpha)))
end

M.themes = {
  nord = {
    plugin = "shaunsingh/nord.nvim",
    colorscheme = "nord",
    colors = {
      bg = "#2E3440", bg_light = "#3B4252", bg_lighter = "#434C5E",
      fg = "#D8DEE9", accent = "#88C0D0",
      error = "#BF616A", warn = "#EBCB8B", hint = "#A3BE8C", info = "#81A1C1",
    },
    setup = function()
      vim.cmd.colorscheme("nord")
      vim.api.nvim_set_hl(0, "LineNr",        { fg = "#4C566A" })
      vim.api.nvim_set_hl(0, "CursorLineNr",  { fg = "#D8DEE9", bold = true })
      vim.api.nvim_set_hl(0, "Comment",       { fg = "#616E88", italic = true })
    end,
  },

  tokyonight = {
    plugin = "folke/tokyonight.nvim",
    colorscheme = "tokyonight-night",
    colors = {
      bg = "#1A1B26", bg_light = "#24283B", bg_lighter = "#2A2F44",
      fg = "#C0CAF5", accent = "#7AA2F7",
      error = "#F7768E", warn = "#E0AF68", hint = "#9ECE6A", info = "#7DCFFF",
    },
    setup = function()
      require("tokyonight").setup({ style = "night", transparent = false })
      vim.cmd.colorscheme("tokyonight-night")
      vim.api.nvim_set_hl(0, "LineNr",       { fg = "#3B4261" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FF9E64", bold = true })
    end,
  },

  catppuccin = {
    plugin = "catppuccin/nvim",
    colorscheme = "catppuccin",
    colors = {
      bg = "#1E1E2E", bg_light = "#302D41", bg_lighter = "#45475A",
      fg = "#CDD6F4", accent = "#89B4FA",
      error = "#F38BA8", warn = "#F9E2AF", hint = "#A6E3A1", info = "#89DCEB",
    },
    setup = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          telescope = true, which_key = true, notify = true,
          neo_tree = true, cmp = true, gitsigns = true, treesitter = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_set_hl(0, "LineNr",       { fg = "#6C7086" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F5E0DC", bold = true })
    end,
  },

  gruvbox = {
    plugin = "ellisonleao/gruvbox.nvim",
    colorscheme = "gruvbox",
    colors = {
      bg = "#282828", bg_light = "#3C3836", bg_lighter = "#504945",
      fg = "#EBDBB2", accent = "#83A598",
      error = "#FB4934", warn = "#FABD2F", hint = "#B8BB26", info = "#83A598",
    },
    setup = function()
      require("gruvbox").setup({ contrast = "hard", transparent_mode = false })
      vim.cmd.colorscheme("gruvbox")
      vim.api.nvim_set_hl(0, "LineNr",       { fg = "#7C6F64" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FABD2F", bold = true })
    end,
  },

  onedark = {
    plugin = "navarasu/onedark.nvim",
    colorscheme = "onedark",
    colors = {
      bg = "#282C34", bg_light = "#353B45", bg_lighter = "#3E4452",
      fg = "#ABB2BF", accent = "#61AFEF",
      error = "#E06C75", warn = "#E5C07B", hint = "#98C379", info = "#56B6C2",
    },
    setup = function()
      require("onedark").setup({
        style = "darker",
        transparent = false,
        code_style = { comments = "italic", keywords = "bold", functions = "italic,bold" },
      })
      vim.cmd.colorscheme("onedark")
      vim.api.nvim_set_hl(0, "LineNr",       { fg = "#4B5263" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#98C379", bold = true })
    end,
  },
}

function M.get_current_theme() return M.themes[M.current_theme] end
function M.get_theme_name()    return M.current_theme end
function M.get_theme_colors()
  local t = M.get_current_theme()
  return t and t.colors or M.themes.nord.colors
end

function M.setup_error_lens()
  local colors = M.get_theme_colors()
  vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = blend_color(colors.error, colors.bg, 0.15) })
  vim.api.nvim_set_hl(0, "DiagnosticWarnLine",  { bg = blend_color(colors.warn,  colors.bg, 0.15) })
  vim.api.nvim_set_hl(0, "DiagnosticHintLine",  { bg = blend_color(colors.hint,  colors.bg, 0.15) })
  vim.api.nvim_set_hl(0, "DiagnosticInfoLine",  { bg = blend_color(colors.info,  colors.bg, 0.15) })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.HINT]  = "",
        [vim.diagnostic.severity.INFO]  = "",
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
        [vim.diagnostic.severity.WARN]  = "DiagnosticWarnLine",
        [vim.diagnostic.severity.HINT]  = "DiagnosticHintLine",
        [vim.diagnostic.severity.INFO]  = "DiagnosticInfoLine",
      },
    },
    virtual_text   = { prefix = "●", spacing = 4 },
    underline      = true,
    update_in_insert = true,
  })
end

function M.toggle_error_lens()
  local current   = vim.diagnostic.config()
  local enabling  = not (current.signs and current.signs.linehl)
  if enabling then
    M.setup_error_lens()
  else
    vim.diagnostic.config({ signs = { linehl = nil } })
  end
  vim.notify("Error Lens " .. (enabling and "enabled" or "disabled"), vim.log.levels.INFO)
end

function M.setup_keymaps()
  -- <leader>le kept for back-compat; <leader>ue is the "ui" namespace home
  vim.keymap.set("n", "<leader>le", M.toggle_error_lens, { desc = "Toggle error lens" })
  vim.keymap.set("n", "<leader>ue", M.toggle_error_lens, { desc = "Toggle error lens" })
end

-- Called once by theme-loader's config()
function M.setup()
  local t = M.get_current_theme()
  if t and t.setup then
    t.setup()
  end
  M.setup_error_lens()
  -- Re-apply after any subsequent :colorscheme calls
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      M.setup_error_lens()
    end,
  })
end

return M
