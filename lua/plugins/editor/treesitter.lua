-- ~/.config/nvim/lua/plugins/editor/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  priority = 20,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "javascript",
        "typescript", "python", "html", "css",
        "json", "yaml", "bash", "markdown",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent    = { enable = true },
    })
  end,
}
