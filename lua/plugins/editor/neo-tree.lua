-- ~/.config/nvim/lua/plugins/editor/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    { "<leader>fe", "<cmd>Neotree reveal<CR>", desc = "Reveal in file explorer" },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["h"] = "close_node",
        ["l"] = "open",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}
