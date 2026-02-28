-- ~/.config/nvim/lua/lsp/error-lens.lua

-- This is not a plugin, it's a configuration file
-- We'll run it when LSP attaches

local M = {}

function M.setup()
  -- Define highlight groups for error lens with Nord colors
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

  local nord = {
    bg = "#2E3440",
    error = "#BF616A",
    warn = "#EBCB8B",
    hint = "#A3BE8C",
    info = "#81A1C1",
  }

  -- Create blended highlight groups
  vim.api.nvim_set_hl(0, "DiagnosticErrorLine", {
    bg = blend_color(nord.error, nord.bg, 0.15)
  })
  vim.api.nvim_set_hl(0, "DiagnosticWarnLine", {
    bg = blend_color(nord.warn, nord.bg, 0.15)
  })
  vim.api.nvim_set_hl(0, "DiagnosticHintLine", {
    bg = blend_color(nord.hint, nord.bg, 0.15)
  })
  vim.api.nvim_set_hl(0, "DiagnosticInfoLine", {
    bg = blend_color(nord.info, nord.bg, 0.15)
  })

  -- Configure diagnostics
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

  -- Add toggle keymap
  vim.keymap.set("n", "<leader>ue", function()
    local current_config = vim.diagnostic.config()
    local new_state = not (current_config.signs and current_config.signs.linehl)

    vim.diagnostic.config({
      signs = {
        linehl = new_state and {
          [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
          [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
          [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
        } or nil,
      },
    })

    vim.notify("Error Lens " .. (new_state and "enabled" or "disabled"), vim.log.levels.INFO)
  end, { desc = "Toggle error lens" })
end

return M
