-- general settings
vim.o.number = true

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.virtualedit = 'onemore'

vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 10000

vim.o.wildmode = 'list:longest'
vim.o.inccommand = 'nosplit'

vim.o.cursorline = true

vim.o.hlsearch = true
vim.keymap.set('n', '<cr>', ':noh<cr><cr>')

vim.o.mouse = 'a'
vim.opt.colorcolumn = "100"

-- plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '$HOME/.config/nvim/plugged')

-- junegunn
Plug('junegunn/fzf', {dir = '~/.fzf', ['do'] = './install --all'})
Plug 'junegunn/fzf.vim'

-- tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

-- utilities
Plug 'jremmen/vim-ripgrep'
Plug 'sgur/vim-editorconfig'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'HiPhish/rainbow-delimiters.nvim'

-- themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'EdenEast/nightfox.nvim'

-- lsp
Plug'williamboman/mason.nvim'
Plug'williamboman/mason-lspconfig.nvim'
Plug'neovim/nvim-lspconfig'

-- autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- code snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- parser/syntax highlighting
Plug'nvim-treesitter/nvim-treesitter'

-- fuzzy finder
Plug'nvim-lua/plenary.nvim'
Plug'nvim-telescope/telescope.nvim'
Plug'nvim-telescope/telescope-fzf-native.nvim'

-- linting/formatting
Plug'jose-elias-alvarez/null-ls.nvim'

vim.call('plug#end')

-- Global mappings.
-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- general shortcuts
vim.keymap.set('n', '<leader>ev', ':edit $MYVIMRC<cr>', {desc = 'Edit Vim config'})
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>', {desc = 'Source Vim config'})
vim.keymap.set('n', '<leader>ek', ':edit ~/.config/kitty/kitty.conf<cr>', {desc = 'Edit kitty config'})
vim.keymap.set('n', '<leader>ez', ':edit ~/.zshrc<cr>', {desc = 'zsh config.'})
vim.keymap.set('n', '<leader>l', ':redraw!<cr>:nohl<cr><esc>', {desc = 'redraw'})
vim.keymap.set('n', '<leader>v', ':vsplit<cr><c-w>l', {desc = 'create vertical split'})
vim.keymap.set('n', '<leader>h', ':split<cr><c-w>l', {desc = 'create vertical split'})
vim.keymap.set('n', '<leader>w', ':write<cr>', {desc = 'write current file'})
vim.keymap.set('n', '<leader>q', ':quit<cr>', {desc = 'quit'})
vim.keymap.set('n', 'Y', 'y$', {desc = 'yank until end of line'})
vim.keymap.set('n', '<leader>j', ':%!python -m json.tool<cr>', {desc = 'format json'})
vim.keymap.set('n', '<leader>t', ':NERDTreeToggle<cr>', {desc = 'enter/leave NERDTree'})
vim.keymap.set('v', 'sy', '"*y', {desc = 'yank into clipboard'})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- autocomplete
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup language servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = { "pyright" }
}

require("lspconfig").pyright.setup {
    capabilities = capabilities,
}

require'lspconfig'.lua_ls.setup{
    settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

-- treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vim", "vimdoc", "python", },
  auto_install = false,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-m>",
    }
  }
}

-- colorscheme
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme nightfox')

-- lualine
require('lualine').setup {options = {theme = "ayu_mirage"}}

-- bufferline
require("bufferline").setup{}

-- rainbow delimiters
require('rainbow-delimiters.setup').setup{}

-- autoformat
local null_ls = require("null-ls")
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black,
  }
}

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
