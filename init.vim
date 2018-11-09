" nvim settings
set mouse=a
set number
set smartindent
set expandtab
set cursorline
set hlsearch
set colorcolumn=100

set shiftwidth=2
set softtabstop=2
set tabstop=2

set ignorecase
set smartcase

set virtualedit=onemore

set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.config/nvim/undo

set wildmode=longest,list:longest
set tags+=./.git/tags

set lazyredraw
set noshowmode

set noerrorbells visualbell t_vb=

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

if (has("termguicolors"))
  set termguicolors
endif

set inccommand=nosplit

call plug#begin($HOME . '/.config/nvim/plugged')

" junegunn
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

" tpope
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'

" ruby
Plug 'vim-ruby/vim-ruby'

" language server
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'

" linting
Plug 'w0rp/ale'

" utilities
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'kien/rainbow_parentheses.vim'

Plug 'sgur/vim-editorconfig'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify'
Plug 'christoomey/vim-tmux-navigator'

" terraform
Plug 'hashivim/vim-terraform'

" themes
Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
Plug 'KeitaNakamura/neodark.vim'
call plug#end()

" theme
set background=dark
" colorscheme gruvbox
colorscheme neodark
let g:neodark#solid_vertsplit = 1

" keybindings
let mapleader = "\<Space>"
nnoremap <silent> <leader>ev :edit $HOME/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>sv :source $HOME/.config/nvim/init.vim<cr>

nnoremap <silent> <leader>l :redraw!<cr>:nohl<cr><esc>
nnoremap <silent> <leader>v :vsplit<cr><c-w>l
nnoremap <silent> <leader>h :split<cr><c-w>j
nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> <leader>q :quit<cr>
nnoremap <silent> <leader>Q :qall<cr>

nnoremap <silent> <leader>js :%!python -m json.tool<cr>

" fzf
nnoremap <silent> <leader>p :call fzf#run({ 'source': 'ag -g ""', 'sink': 'e', 'window': 'enew' })<cr>

" easy align
vmap <silent> <cr> <Plug>(EasyAlign)

" ag
nnoremap <leader>a :Ag<space>

" copy/paste from system clipboard (osx)
noremap <silent> <leader>sy "*y
noremap <silent> <leader>sp "*p
noremap <silent> <leader>sY "*y
noremap <silent> <leader>sP "*P

" grep under cursor
nnoremap <silent> <leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" configure grep to use ag
set grepprg=ag\ --nogroup\ --nocolor

" vim-ruby
let ruby_operators = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1

" neomake
let g:neomake_ruby_enabled_makers = []

" supertab
let g:SuperTabDefaultCompletionType = "context"

" lightline
let g:lightline = {
            \ 'colorscheme': 'neodark',
            \ 'mode_map': { 'c': 'NORMAL' },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'LightLineModified',
            \   'readonly': 'LightLineReadonly',
            \   'fugitive': 'LightLineFugitive',
            \   'filename': 'LightLineFilename',
            \   'fileformat': 'LightLineFileformat',
            \   'filetype': 'LightLineFiletype',
            \   'fileencoding': 'LightLineFileencoding',
            \   'mode': 'LightLineMode',
            \ },
            \ }

function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" auto complete
set completeopt=noinsert,menuone,noselect
set shortmess+=c

" autocmd BufEnter * call ncm2#enable_for_buffer()

" inoremap <c-c> <ESC>
" inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" language server
let g:LanguageClient_serverCommands = {
  \ 'python': ['pyls'],
  \ }

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
inoremap <silent> <C-c> <C-x><C-o>


" ale
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1

let g:ale_linters = {
  \ 'python': ['flake8'],
  \ }

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['black'],
  \ }

" format json
nnoremap <leader>j :%!python -m json.tool<cr>
