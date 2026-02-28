-- ~/.config/nvim/lua/plugins/ui/alpha.lua

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header with Nord colors
    dashboard.section.header.val = {
      "   ╔═                                                  ═╗  ",
      "   ║ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ║  ",
      "   ║ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ║  ",
      "   ║ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ║  ",
      "   ║ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ║  ",
      "   ║ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ║  ",
      "   ║ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ║  ",
      "   ╚═                                                  ═╝  ",
      "                  ⚡ Welcome to Neovim ⚡                  ",
      "                                                           ",
    }

    -- Button actions as strings (what alpha expects)
    local function telescope_find_files()
      return ':lua require("telescope.builtin").find_files()<CR>'
    end

    local function telescope_oldfiles()
      return ':lua require("telescope.builtin").oldfiles()<CR>'
    end

    local function telescope_live_grep()
      return ':lua require("telescope.builtin").live_grep()<CR>'
    end

    -- Set menu buttons with string commands
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "  Find file", telescope_find_files()),
      dashboard.button("r", "  Recent files", telescope_oldfiles()),
      dashboard.button("g", "  Find text", telescope_live_grep()),
      dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Footer with date
    dashboard.section.footer.val = os.date("  %Y-%m-%d    %H:%M:%S")

    -- Set highlight colors for Nord theme
    dashboard.section.header.opts.hl = "Type"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    -- Configure layout
    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    -- Disable dashboard if opening a file
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        if vim.fn.argc() > 0 then
          vim.cmd("AlphaClose")
        end
      end,
    })

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
