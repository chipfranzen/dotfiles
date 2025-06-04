-- NvimTree compatibility
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers
vim.opt.cursorline = true
vim.opt.number = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- Search behavior
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Interface options
vim.opt.colorcolumn = "99"
vim.opt.scrolloff = 8
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.wrap = false

-- Performance
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }

-- Persistent Undo
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
