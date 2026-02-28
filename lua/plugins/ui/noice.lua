-- ~/.config/nvim/lua/plugins/ui/noice.lua

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- You already have this
  },
  opts = {
    -- Enable all the goodies
    presets = {
      bottom_search = true,      -- Use a classic bottom cmdline for search
      command_palette = true,    -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = true,         -- Enables an input dialog for renaming
      lsp_doc_border = true,     -- Add a border to hover docs and signature help
    },
    
    -- Command line configuration
    cmdline = {
      enabled = true,           -- Enable floating cmdline
      view = "cmdline_popup",   -- Use popup view for command line
      opts = {
        -- Position at the top like fine-cmdline
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
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
      -- Format the cmdline
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      },
    },
    
    -- Messages configuration (notifications)
    messages = {
      enabled = true,           -- Enable enhanced messages
      view = "notify",          -- Use notify for messages
      view_error = "notify",    -- Use notify for errors
      view_warn = "notify",     -- Use notify for warnings
      view_history = "messages", -- Show history in splits
    },
    
    -- Popup menu configuration (for command-line completion)
    popupmenu = {
      enabled = true,           -- Enable enhanced popup menu
      backend = "nui",          -- Use nui for rendering
      kind_icons = {},          -- Use default icons
    },
    
    -- LSP configuration
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = {
        enabled = true,         -- Show LSP progress messages
        format = "lsp",         -- Use LSP format
        throttled = true,       -- Throttle progress updates
        view = "mini",          -- Show progress in mini view
      },
      hover = {
        enabled = true,
        view = nil,             -- Use default view
      },
      signature = {
        enabled = true,
        view = nil,             -- Use default view
      },
    },
    
    -- Markdown configuration for hover docs
    markdown = {
      hover = {
        ["=lang"] = true,
      },
      highlights = {
        -- Use treesitter for markdown highlighting
        ["=lang"] = function(lang, text)
          local ts_ok, _ = pcall(require, "nvim-treesitter")
          if ts_ok then
            return vim.treesitter.highlight_string(lang, text)
          end
          return text
        end,
      },
    },
    
    -- Smart move for search
    smart_move = {
      enabled = true,
      -- Move to matching pairs
      pairs = { "(", ")", "[", "]", "{", "}" },
    },
  },
  -- Keymaps for noice
  keys = {
    -- Show message history
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
      "<leader>sna",
      function() require("noice").cmd("all") end,
      desc = "Noice All",
    },
    {
      "<leader>snd",
      function() require("noice").cmd("dismiss") end,
      desc = "Dismiss All",
    },
    -- Scroll through hover docs
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" },
    },
    -- Redirect cmdline output
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
  },
}
