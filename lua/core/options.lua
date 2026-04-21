-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- Line numbers
opt.number         = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop    = 4
opt.shiftwidth = 4
opt.expandtab  = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = false
opt.incsearch  = true

-- Cursor
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background    = "dark"
opt.signcolumn    = "yes"

-- Editing
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Word chars
opt.iskeyword:append("-")

-- Sessions
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Scroll
opt.scrolloff     = 8
opt.sidescrolloff = 8

-- Mouse
opt.mouse = "a"

-- Undo — use stdpath instead of hardcoded $HOME/.vim
opt.undofile   = true
opt.undodir    = vim.fn.stdpath("data") .. "/undodir"
opt.undolevels = 10000

-- Make undodir if it doesn't exist
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
