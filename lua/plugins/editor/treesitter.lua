-- ~/.config/nvim/lua/plugins/editor/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc", "javascript",
      "typescript", "python", "html", "css",
      "json", "yaml", "bash", "markdown", "markdown_inline",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local ok = pcall(vim.treesitter.start, ev.buf)
        if not ok then
        end
      end,
    })
  end,
}
