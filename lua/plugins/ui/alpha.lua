-- ~/.config/nvim/lua/plugins/ui/alpha.lua

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha     = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local theme     = require("core.theme")

    local headers = {
      nord = {
        "                                                     ",
        "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                     ",
        "                  ⚡ Welcome to Neovim ⚡            ",
        "                                                     ",
      },
      tokyonight = {
        "                                                     ",
        "    ████████╗ ██████╗ ██╗  ██╗██╗   ██╗ ██████╗     ",
        "    ╚══██╔══╝██╔═══██╗██║ ██╔╝╚██╗ ██╔╝██╔═══██╗    ",
        "       ██║   ██║   ██║█████╔╝  ╚████╔╝ ██║   ██║    ",
        "       ██║   ██║   ██║██╔═██╗   ╚██╔╝  ██║   ██║    ",
        "       ██║   ╚██████╔╝██║  ██╗   ██║   ╚██████╔╝    ",
        "       ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝     ",
        "                                                     ",
        "              🌃 Tokyo Night Edition                ",
        "                                                     ",
      },
      catppuccin = {
        "                                                     ",
        "     ██████╗ █████╗ ████████╗██████╗ ██╗   ██╗     ",
        "    ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║   ██║     ",
        "    ██║     ███████║   ██║   ██████╔╝██║   ██║     ",
        "    ██║     ██╔══██║   ██║   ██╔═══╝ ██║   ██║     ",
        "    ╚██████╗██║  ██║   ██║   ██║     ╚██████╔╝     ",
        "     ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚═════╝      ",
        "                                                     ",
        "              🐱 Catppuccin Mocha                   ",
        "                                                     ",
      },
    }

    dashboard.section.header.val = headers[theme.current_theme] or headers.nord

    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "  Find file", ":lua require('telescope.builtin').find_files()<CR>"),
      dashboard.button("r", "  Recent files", ":lua require('telescope.builtin').oldfiles()<CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = function()
      local name = theme.current_theme:gsub("^%l", string.upper)
      return string.format("❄️  %s  Edition  •    %s", name, os.date("%Y-%m-%d %H:%M"))
    end

    dashboard.section.header.opts.hl  = "Type"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl  = "Comment"

    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    -- Hide statusline and tabline on the dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern  = "alpha",
      callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus  = 0
        -- Restore when leaving the alpha buffer (BufUnload pattern="<buffer>"
        -- was broken: "<buffer>" is a literal string, not a buffer-local pattern)
        vim.api.nvim_create_autocmd("BufLeave", {
          buffer  = vim.api.nvim_get_current_buf(),
          once    = true,
          callback = function()
            vim.opt.showtabline = 2
            vim.opt.laststatus  = 3
          end,
        })
      end,
    })
  end,
}
