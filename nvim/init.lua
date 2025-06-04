-- general settings
vim.o.number = true
vim.o.showmode = false

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
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = './install --all' })
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
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

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
Plug 'nvim-treesitter/nvim-treesitter'

-- fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'

-- diagnostics display
Plug 'folke/trouble.nvim'

-- Autotag
Plug 'windwp/nvim-ts-autotag'

-- Mkdir
Plug 'jghauser/mkdir.nvim'

-- Trim (remove trailing whitespace)
Plug 'cappyzawa/trim.nvim'

-- Show linter/formatter errors
Plug 'mfussenegger/nvim-lint'
Plug 'stevearc/conform.nvim'

vim.call('plug#end')

-- Global mappings.
-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- general shortcuts
vim.keymap.set('n', '<leader>ev', ':edit $MYVIMRC<cr>', { desc = 'Edit Vim config' })
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>', { desc = 'Source Vim config' })
vim.keymap.set('n', '<leader>ek', ':edit ~/.config/kitty/kitty.conf<cr>', { desc = 'Edit kitty config' })
vim.keymap.set('n', '<leader>ez', ':edit ~/.zshrc<cr>', { desc = 'zsh config.' })
vim.keymap.set('n', '<leader>l', ':redraw!<cr>:nohl<cr><esc>', { desc = 'redraw' })
vim.keymap.set('n', '<leader>v', ':vsplit<cr><c-w>l', { desc = 'create vertical split' })
vim.keymap.set('n', '<leader>h', ':split<cr><c-w>l', { desc = 'create horizontal split' })
vim.keymap.set('n', '<leader>w', ':write<cr>', { desc = 'write current file' })
vim.keymap.set('n', '<leader>q', ':quit<cr>', { desc = 'quit' })
vim.keymap.set('n', 'Y', 'y$', { desc = 'yank until end of line' })
vim.keymap.set('n', '<leader>j', ':%!python -m json.tool<cr>', { desc = 'format json' })
vim.keymap.set('n', '<leader>t', ':NERDTreeToggle<cr>', { desc = 'enter/leave NERDTree' })
vim.keymap.set('v', 'sy', '"*y', { desc = 'yank into clipboard' })
vim.keymap.set('n', '<leader>c', ':let @+ = expand("%:p")<CR>', { desc = 'Copy absolute path' })

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
local cmp = require 'cmp'

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
  automatic_installation = true,
  ensure_installed = {
    "pyright",
    "svelte",      -- Added for SvelteKit
    "ts_ls",       -- TypeScript support for SvelteKit
    "tailwindcss", -- If using Tailwind
    "cssls",       -- CSS language server
    "html"         -- HTML language server
  }
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
}

require("lspconfig").lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
}

require("lspconfig").svelte.setup {
  capabilities = capabilities,
  -- Optional: specify root directory patterns for SvelteKit projects
  root_dir = require('lspconfig').util.root_pattern('package.json', 'svelte.config.js'),
}

require("lspconfig").ts_ls.setup {
  capabilities = capabilities,
}

require("lspconfig").tailwindcss.setup {
  capabilities = capabilities,
  -- Recognize Svelte files
  filetypes = { "svelte", "html", "css", "javascript", "typescript" },
}

-- treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "python",
    "svelte",
    "typescript",
    "javascript",
    "html",
    "css",
    "json",
    "norg",
  },
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

require("nvim-ts-autotag").setup {}

-- colorscheme
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme nightfox')

-- lualine
require('lualine').setup { options = { theme = "ayu_mirage" } }

-- bufferline
require("bufferline").setup {}

-- rainbow delimiters
require('rainbow-delimiters.setup').setup {}

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})

--fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

-- NERDTree

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 20
vim.g.NERDTreeMinimalUI = 1

-- trim
require('trim').setup({
  -- Enable trimming on save
  trim_on_write = true,
  -- Don't remove trailing whitespace on these filetypes
  ft_blocklist = {},
  -- Trim trailing lines at EOF
  trim_trailing_lines = true,
  -- Disable when multiple cursors are active
  disable_in_multi_cursor = true,
  -- Don't show notifications when trimming
  -- Set to true to see notifications
  highlight_on_trim = false,
})

require('lint').linters_by_ft = {
  python = { 'ruff' },
  typescript = { 'eslint' },
  svelte = { 'eslint' },
  javascript = { 'eslint' },
}

require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format" },
    typescript = { "prettier" },
    javascript = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
  },
  formatters = {
    ruff_format = {
      command = "ruff",
      args = { "format", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})


vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Customize built-in diagnostics display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Enable hover diagnostics
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 300

-- Add signs to gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Add key mapping to show diagnostics in a float window
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Configure trouble.nvim for better diagnostics display
require("trouble").setup {
  position = "bottom",               -- position of the list can be: bottom, top, left, right
  height = 10,                       -- height of the trouble list when position is top or bottom
  width = 50,                        -- width of the list when position is left or right
  icons = true,                      -- use devicons for filenames
  mode = "workspace_diagnostics",    -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "",                    -- icon used for open folds
  fold_closed = "",                  -- icon used for closed folds
  group = true,                      -- group results by file
  padding = true,                    -- add an extra new line on top of the list
  action_keys = {                    -- key mappings for actions in the trouble list
    close = "q",                     -- close the list
    cancel = "<esc>",                -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r",                   -- manually refresh
    jump = { "<cr>", "<tab>" },      -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" },        -- open buffer in new split
    open_vsplit = { "<c-v>" },       -- open buffer in new vsplit
    open_tab = { "<c-t>" },          -- open buffer in new tab
    jump_close = { "o" },            -- jump to the diagnostic and close the list
    toggle_mode = "m",               -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P",            -- toggle auto_preview
    hover = "K",                     -- opens a small popup with the full multiline message
    preview = "p",                   -- preview the diagnostic location
    close_folds = { "zM", "zm" },    -- close all folds
    open_folds = { "zR", "zr" },     -- open all folds
    toggle_fold = { "zA", "za" },    -- toggle fold of current file
    previous = "k",                  -- previous item
    next = "j"                       -- next item
  },
  indent_lines = true,               -- add an indent guide below the fold icons
  auto_open = false,                 -- automatically open the list when you have diagnostics
  auto_close = false,                -- automatically close the list when you have no diagnostics
  auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false,                 -- automatically fold a file trouble list at creation
  auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
