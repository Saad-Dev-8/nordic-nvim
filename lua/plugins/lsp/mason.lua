-- ~/.config/nvim/lua/plugins/lsp/mason.lua

return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
    },
  },
}
