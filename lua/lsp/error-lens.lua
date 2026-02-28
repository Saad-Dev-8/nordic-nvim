-- ~/.config/nvim/lua/lsp/error-lens.lua

local M = {}

-- Helper function to blend colors
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

-- Check if buffer should have error lens
local function should_enable_for_buffer(bufnr)
  bufnr = bufnr or 0
  
  -- Get buffer info
  local buftype = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype
  local modifiable = vim.bo[bufnr].modifiable
  local readonly = vim.bo[bufnr].readonly
  
  -- Always disable for these buffer types
  local skip_buftypes = {
    ["nofile"] = true,
    ["terminal"] = true,
    ["prompt"] = true,
    ["help"] = true,
    ["quickfix"] = true,
    ["nowrite"] = true,
  }
  
  -- Always disable for these filetypes
  local skip_filetypes = {
    ["neo-tree"] = true,
    ["NvimTree"] = true,
    ["TelescopePrompt"] = true,
    ["alpha"] = true,
    ["dashboard"] = true,
    ["toggleterm"] = true,
    ["noice"] = true,
    ["Notify"] = true,
  }
  
  -- Main checks
  if skip_buftypes[buftype] then
    return false
  end
  
  if skip_filetypes[filetype] then
    return false
  end
  
  if not modifiable or readonly then
    return false
  end
  
  return true
end

-- Default Nord colors (fallback)
local default_colors = {
  bg = "#2E3440",
  error = "#BF616A",
  warn = "#EBCB8B",
  hint = "#A3BE8C",
  info = "#81A1C1",
}

function M.setup()
  -- Check if we should proceed
  if not should_enable_for_buffer() then
    return
  end
  
  -- Try to get theme colors, fallback to Nord
  local colors = default_colors
  local ok, theme = pcall(require, "core.theme")
  if ok then
    local theme_colors = theme.get_theme_colors()
    if theme_colors then
      colors = theme_colors
    end
  end

  -- Create highlight groups (these are global, not buffer-specific)
  local hl_ok1 = pcall(vim.api.nvim_set_hl, 0, "DiagnosticErrorLine", {
    bg = blend_color(colors.error, colors.bg, 0.15)
  })
  
  local hl_ok2 = pcall(vim.api.nvim_set_hl, 0, "DiagnosticWarnLine", {
    bg = blend_color(colors.warn, colors.bg, 0.15)
  })
  
  local hl_ok3 = pcall(vim.api.nvim_set_hl, 0, "DiagnosticHintLine", {
    bg = blend_color(colors.hint, colors.bg, 0.15)
  })
  
  local hl_ok4 = pcall(vim.api.nvim_set_hl, 0, "DiagnosticInfoLine", {
    bg = blend_color(colors.info, colors.bg, 0.15)
  })

  -- Configure diagnostics (global)
  local diag_ok = pcall(vim.diagnostic.config, {
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
  
  -- Debug info (remove after fixing)
  if not hl_ok1 or not hl_ok2 or not hl_ok3 or not hl_ok4 then
    vim.notify("Error lens: Failed to set some highlights", vim.log.levels.WARN)
  end
end

function M.toggle()
  -- Get current config safely
  local current_config = {}
  pcall(function()
    current_config = vim.diagnostic.config()
  end)
  
  local new_state = not (current_config.signs and current_config.signs.linehl)

  if new_state then
    M.setup()
    vim.notify("Error Lens enabled", vim.log.levels.INFO)
  else
    pcall(vim.diagnostic.config, {
      signs = {
        linehl = nil,
      },
    })
    vim.notify("Error Lens disabled", vim.log.levels.INFO)
  end
end

-- Setup keymap (buffer-local)
function M.setup_keymap()
  -- Only set keymap if buffer is appropriate
  if should_enable_for_buffer() then
    local ok = pcall(vim.keymap.set, "n", "<leader>le", M.toggle, { 
      buffer = true,
      desc = "Toggle error lens",
      silent = true,
    })
    
    if not ok then
      vim.notify("Error lens: Failed to set keymap for buffer " .. vim.api.nvim_get_current_buf(), vim.log.levels.DEBUG)
    end
  end
end

return M
