-- ~/.config/nvim/lua/lsp/error-lens.lua
-- NOTE: error lens is now fully managed by core/theme.lua (setup_error_lens,
-- toggle_error_lens, setup_keymaps). This file is kept so any external
-- requires don't break, but it delegates to the theme module.

local M = {}

function M.setup()
  require("core.theme").setup_error_lens()
end

function M.toggle()
  require("core.theme").toggle_error_lens()
end

function M.setup_keymap()
  require("core.theme").setup_keymaps()
end

return M
