-- ~/.config/nvim/lua/plugins/ui/noice.lua

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    presets = {
      bottom_search        = true,
      command_palette      = true,
      long_message_to_split = true,
      inc_rename           = true,
      lsp_doc_border       = true,
    },
    cmdline = {
      enabled = true,
      view    = "cmdline_popup",
      opts    = {
        position = { row = "10%", col = "50%" },
        size     = { width = 60, height = "auto" },
        border   = { style = "rounded", padding = { 0, 1 } },
      },
    },
    messages = { enabled = true, view = "notify" },
    popupmenu = { enabled = true, backend = "nui" },
    lsp = {
      progress = {
        enabled   = true,
        format    = "lsp",
        throttled = true,
        view      = "mini",
      },
      hover     = { enabled = true },
      -- disabled: we handle signature help manually via <C-s> in servers.lua
      -- enabling this causes a double popup on signature trigger
      signature = { enabled = false },
    },
  },
  keys = {
    {
      "<leader>sn",
      "",
      desc = "+Noice",
    },
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc = "Noice last message",
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc = "Noice history",
    },
    -- <C-f>/<C-b> in insert/normal for scrolling LSP docs
    -- Use <C-d>/<C-u> to avoid conflict with cmp's scroll_docs mappings
    {
      "<C-d>",
      function()
        if not require("noice.lsp").scroll(4) then return "<C-d>" end
      end,
      silent = true, expr = true,
      mode = { "i", "n", "s" },
      desc = "Scroll doc down",
    },
    {
      "<C-u>",
      function()
        if not require("noice.lsp").scroll(-4) then return "<C-u>" end
      end,
      silent = true, expr = true,
      mode = { "i", "n", "s" },
      desc = "Scroll doc up",
    },
  },
}
