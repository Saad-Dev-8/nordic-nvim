-- ~/.config/nvim/lua/plugins/utils/comment.lua

return {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
    { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
  },
  opts = {
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
