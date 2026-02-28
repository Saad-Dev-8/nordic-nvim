-- ~/.config/nvim/lua/plugins/utils/toggleterm.lua

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Vertical terminal" },
    { "<leader>tg", "<cmd>ToggleTerm dir=git_dir<CR>", desc = "Terminal in git root" },
  },
  config = function()
    require("toggleterm").setup({
      -- Size can be a number or function
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
      open_mapping = [[<c-\>]], -- Press Ctrl-\ to open terminal (optional)
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      -- Customize terminal colors for Nord theme
      highlights = {
        Normal = { link = "Normal" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
    })
    
    -- Optional: Send current line to terminal
    function _G.toggleterm_send_line()
      local line = vim.api.nvim_get_current_line()
      require("toggleterm").send_lines_to_terminal(line, false, { args = vim.v.count })
    end
    
    vim.keymap.set("n", "<leader>ts", "<cmd>lua toggleterm_send_line()<CR>", { desc = "Send line to terminal" })
  end,
}
