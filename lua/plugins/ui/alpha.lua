-- ~/.config/nvim/lua/plugins/ui/alpha.lua

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local theme = require("core.theme")

    -- Dynamic header based on theme
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

    -- Use theme-specific header or default to nord
    dashboard.section.header.val = headers[theme.current_theme] or headers.nord

    -- Helper function for telescope commands
    local function telescope_find_files()
      return ':lua require("telescope.builtin").find_files()<CR>'
    end

    local function telescope_oldfiles()
      return ':lua require("telescope.builtin").oldfiles()<CR>'
    end

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "  Find file", telescope_find_files()),
      dashboard.button("r", "  Recent files", telescope_oldfiles()),
      dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Footer with theme info
    dashboard.section.footer.val = function()
      local theme_name = theme.current_theme:gsub("^%l", string.upper)
      return string.format("❄️  %s  Edition  •    %s", theme_name, os.date("%Y-%m-%d %H:%M"))
    end

    -- Set highlights
    dashboard.section.header.opts.hl = "Type"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    -- Layout
    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    -- Hide tabline on dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function()
        vim.opt.showtabline = 2
        vim.opt.laststatus = 3
      end,
    })
  end,
}
