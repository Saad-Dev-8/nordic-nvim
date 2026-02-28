-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider '-' as part of word
opt.iskeyword:append("-")

-- Session settings
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Scroll offset
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Enable mouse mode
opt.mouse = "a"

-- Undo history
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undolevels = 10000
