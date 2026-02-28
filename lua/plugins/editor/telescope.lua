-- ~/.config/nvim/lua/plugins/editor/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  -- Use the release branch (0.1.x) NOT 'main'
  version = '*',
  -- Or if you prefer a specific version:
  -- tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      oldfiles = {
        prompt_title = "Recent Files",
        cwd_only = false,
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    
    -- Load extensions
    pcall(function()
      require("telescope").load_extension("fzf")
    end)
  end,
}
