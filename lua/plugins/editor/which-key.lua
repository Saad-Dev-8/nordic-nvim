-- ~/.config/nvim/lua/plugins/editor/which-key.lua

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 400,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = { Up = "▲", Down = "▼", Left = "◀", Right = "▶" },
    },
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>f f", desc = "Find files" },
      { "<leader>f g", desc = "Live grep" },
      { "<leader>f b", desc = "Buffers" },
      { "<leader>f o", desc = "Old files" },
      { "<leader>f h", desc = "Help" },
  
      { "<leader>g", group = "Git" },
      { "<leader>g s", desc = "Stage hunk" },
      { "<leader>g r", desc = "Reset hunk" },
      { "<leader>g b", desc = "Blame line" },
      { "<leader>g d", desc = "Diff" },
  
      { "<leader>l", group = "LSP" },
      { "<leader>l r", desc = "Rename" },
      { "<leader>l a", desc = "Code action" },
      { "<leader>l f", desc = "Format" },
      { "g d", desc = "Go to definition" },
      { "g r", desc = "References" },
      { "K", desc = "Hover" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
