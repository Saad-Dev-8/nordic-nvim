-- ~/.config/nvim/lua/plugins/ui/bufferline.lua

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "thin",
      show_close_icon = false,
      show_buffer_close_icons = false,
      modified_icon = "●",
      color_icons = true,
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          text_align = "left",
          separator = true,
        },
      },
      indicator = {
        icon = "",
        style = "underline",
      },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
}
