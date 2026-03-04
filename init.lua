-- ~/.config/nvim/init.lua

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key first
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core settings (these don't depend on plugins)
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load plugins (including theme)
require("lazy").setup("plugins")

-- Load theme AFTER plugins (this ensures theme plugins are installed)
-- But use defer to ensure plugins are fully loaded
vim.defer_fn(function()
  require("core.colorscheme")
end, 50)

-- Load Error lens
vim.defer_fn(function()
  local ok, error_lens = pcall(require, "lsp.error-lens")
  if ok then
    error_lens.setup()
    error_lens.setup_keymap()
    vim.notify("Error lens loaded", vim.log.levels.DEBUG)
  end
end, 500)
