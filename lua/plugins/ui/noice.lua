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
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      opts = {
        position = {
          row = "10%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
      },
    },
    messages = {
      enabled = true,
      view = "notify",
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    lsp = {
      progress = {
        enabled = true,
        format = "lsp",
        throttled = true,
        view = "mini",
      },
      hover = { enabled = true },
      signature = { enabled = true },
    },
  },
  keys = {
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc = "Noice Last Message",
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc = "Noice History",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then return "<c-f>" end
      end,
      silent = true,
      expr = true,
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then return "<c-b>" end
      end,
      silent = true,
      expr = true,
      mode = { "i", "n", "s" },
    },
  },
}
