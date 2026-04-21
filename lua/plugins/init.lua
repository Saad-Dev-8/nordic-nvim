-- ~/.config/nvim/lua/plugins/init.lua

-- This file imports all plugin modules
-- Each module returns a plugin specification

local plugins = {
  -- UI
  require("plugins.ui.theme-loader"),
  require("plugins.ui.lualine"),
  require("plugins.ui.bufferline"),
  require("plugins.ui.nvim-notify"),
  require("plugins.ui.noice"), 
  require("plugins.ui.alpha"),
  require("plugins.ui.highlight-colors"),

  -- Editor 
  require("plugins.editor.treesitter"),
  require("plugins.editor.telescope"),
  require("plugins.editor.neo-tree"),
  require("plugins.editor.which-key"),

  -- LSP 
  require("plugins.lsp.servers"),
  require("plugins.lsp.cmp"),

  -- Utility
  require("plugins.utils.comment"),
  require("plugins.utils.autopairs"),
  require("plugins.utils.gitsigns"),
  require("plugins.utils.toggleterm"),
}

return plugins
