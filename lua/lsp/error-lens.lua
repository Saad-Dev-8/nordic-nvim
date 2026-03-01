-- ~/.config/nvim/lua/lsp/error-lens.lua

local M = {}

function M.setup()
  -- Only setup on normal buffers
  pcall(function()
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticError",
          [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
          [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        },
      },
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      underline = true,
      update_in_insert = true,
    })
  end)
end

function M.toggle()
  pcall(function()
    local current = vim.diagnostic.config()
    local new_state = not (current.signs and current.signs.linehl)
    
    if new_state then
      vim.diagnostic.config({
        signs = {
          linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          },
        },
      })
    else
      vim.diagnostic.config({
        signs = {
          linehl = nil,
        },
      })
    end
    
    vim.notify("Error Lens " .. (new_state and "enabled" or "disabled"), vim.log.levels.INFO)
  end)
end

function M.setup_keymap()
  pcall(function()
    vim.keymap.set("n", "<leader>le", M.toggle, { desc = "Toggle error lens" })
  end)
end

return M
