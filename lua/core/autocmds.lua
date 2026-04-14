-- ~/.config/nvim/lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings
local general = augroup("General", { clear = true })

-- Resize splits when window is resized
autocmd("VimResized", {
  group = general,
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Return to last edit position
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    -- Skip for special buffers
    if vim.bo.buftype ~= "" then return end
    
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create parent directories when saving
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    -- Skip for special buffers
    if vim.bo.buftype ~= "" then return end
    
    local file = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  once = true, -- only need to set it up once
  callback = function()
    local ok, error_lens = pcall(require, "lsp.error-lens")
    if ok then
      error_lens.setup()
      error_lens.setup_keymap()
    end
  end,
})
