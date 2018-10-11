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


"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

if (has("termguicolors"))
  set termguicolors
endif

if (has("guifont"))
  set guifont=Fira\ Code
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
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'

" ruby
Plug 'vim-ruby/vim-ruby'

" utilities
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'kien/rainbow_parentheses.vim'

" terraform
Plug 'hashivim/vim-terraform'

" themes
Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
call plug#end()

" theme
set background=dark
colorscheme gruvbox

" keybindings
let mapleader = "\<Space>"
nnoremap <silent> <leader>ev :edit $HOME/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>so :source $HOME/.config/nvim/init.vim<cr>

nnoremap <silent> <leader>l :redraw!<cr>:nohl<cr><esc>
nnoremap <silent> <leader>v :vsplit<cr><c-w>l
nnoremap <silent> <leader>h :split<cr><c-w>j
nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> <leader>q :quit<cr>
nnoremap <silent> <leader>Q :qall<cr>

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
            \ 'colorscheme': 'jellybeans',
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
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
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
