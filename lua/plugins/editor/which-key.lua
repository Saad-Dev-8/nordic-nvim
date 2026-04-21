-- ~/.config/nvim/lua/plugins/editor/which-key.lua

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay  = 400,
    icons  = {
      mappings = vim.g.have_nerd_font,
      keys     = { Up = "▲", Down = "▼", Left = "◀", Right = "▶" },
    },
    spec = {
      -- Find (Telescope)
      { "<leader>f",  group = "Find" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fo", desc = "Old files" },
      { "<leader>fh", desc = "Help" },
      { "<leader>fk", desc = "Keymaps" },

      -- Git
      { "<leader>g",  group = "Git" },
      { "<leader>gs", desc = "Stage hunk" },
      { "<leader>gr", desc = "Reset hunk" },
      { "<leader>gS", desc = "Stage buffer" },
      { "<leader>gR", desc = "Reset buffer" },
      { "<leader>gu", desc = "Undo stage hunk" },
      { "<leader>gb", desc = "Blame line" },
      { "<leader>gp", desc = "Preview hunk" },
      { "<leader>gd", desc = "Diff this" },
      { "<leader>gD", desc = "Diff this ~" },
      { "<leader>gt", desc = "Toggle line blame" },
      { "<leader>gT", desc = "Toggle deleted" },

      -- LSP
      { "<leader>l",  group = "LSP" },
      { "<leader>lr", desc = "Rename" },
      { "<leader>la", desc = "Code action" },
      { "<leader>lf", desc = "Format" },
      { "<leader>ld", desc = "Diagnostic float" },
      { "<leader>le", desc = "Toggle error lens" },
      { "<leader>lm", desc = "Mason" },

      -- Search/Noice
      { "<leader>s",   group = "Search" },
      { "<leader>sn",  group = "Noice" },
      { "<leader>snl", desc = "Noice last message" },
      { "<leader>snh", desc = "Noice history" },

      -- UI
      { "<leader>u",  group = "UI" },
      { "<leader>uc", desc = "Toggle color highlight" },
      { "<leader>ue", desc = "Toggle error lens" },

      -- Terminal
      { "<leader>t",  group = "Terminal" },
      { "<leader>tt", desc = "Toggle terminal" },
      { "<leader>tf", desc = "Float terminal" },
      { "<leader>th", desc = "Horizontal terminal" },
      { "<leader>tv", desc = "Vertical terminal" },
      { "<leader>tg", desc = "Terminal in git root" },
      { "<leader>ts", desc = "Send line to terminal" },

      -- Misc
      { "<leader>e",  desc = "Toggle file explorer" },
      { "<leader>ec", desc = "Edit config" },
      { "<leader>sc", desc = "Source config" },

      -- Go-to
      { "g",   group = "Go to" },
      { "gd",  desc = "Definition" },
      { "gD",  desc = "Declaration" },
      { "gi",  desc = "Implementation" },
      { "gr",  desc = "References" },
      { "K",   desc = "Hover docs" },
      { "[d",  desc = "Prev diagnostic" },
      { "]d",  desc = "Next diagnostic" },
      { "[c",  desc = "Prev hunk" },
      { "]c",  desc = "Next hunk" },
      { "[b",  desc = "Prev buffer" },
      { "]b",  desc = "Next buffer" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
