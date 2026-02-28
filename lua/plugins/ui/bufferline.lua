-- ~/.config/nvim/lua/plugins/ui/bufferline.lua

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "thin", -- Cleaner VSCode look
      show_close_icon = false,   -- Hide close icons by default (VSCode style)
      show_buffer_close_icons = false,
      close_icon = "",
      modified_icon = "●",
      pinned_icon = "",
      color_icons = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      name_formatter = function(buf)
        return vim.fn.fnamemodify(buf.name, ":t")
      end,
      show_buffer_numbers = false,
      show_buffer_index = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          text_align = "left",
          separator = true,
          highlight = "Directory",
        },
      },
      indicator = {
        icon = "", -- No icon, just underline
        style = "underline",
      },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
    highlights = {
      fill = {
        bg = "#2E3440", -- nord0 (tab bar background)
      },
      background = {
        bg = "#2E3440", -- Same as fill (empty space)
        fg = "#4C566A", -- nord3 (dim text for empty area)
      },
      buffer_visible = {
        bg = "#3B4252", -- nord1 (slightly lighter than background)
        fg = "#D8DEE9", -- nord4
      },
      buffer_selected = {
        bg = "#434C5E", -- nord2 (highlighted)
        fg = "#88C0D0", -- nord8 (accent color)
        bold = true,
      },
      close_button = {
        bg = "#3B4252",
        fg = "#D8DEE9",
      },
      close_button_visible = {
        bg = "#3B4252",
        fg = "#BF616A", -- nord11 (red on hover)
      },
      close_button_selected = {
        bg = "#434C5E",
        fg = "#BF616A",
      },
      modified = {
        bg = "#3B4252",
        fg = "#EBCB8B", -- nord13 (yellow)
      },
      modified_visible = {
        bg = "#3B4252",
        fg = "#EBCB8B",
      },
      modified_selected = {
        bg = "#434C5E",
        fg = "#EBCB8B",
        bold = true,
      },
      duplicate = {
        bg = "#3B4252",
        fg = "#D8DEE9",
        italic = true,
      },
      duplicate_selected = {
        bg = "#434C5E",
        fg = "#88C0D0",
        bold = true,
        italic = true,
      },
      separator = {
        bg = "#2E3440",
        fg = "#4C566A",
      },
      separator_selected = {
        bg = "#2E3440",
        fg = "#4C566A",
      },
      indicator_selected = {
        bg = "#434C5E",
        fg = "#88C0D0",
        underline = true,
      },
      pick = {
        bg = "#3B4252",
        fg = "#EBCB8B",
        bold = true,
      },
    },
  },
}
