set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" cycling colors for parens, brackets, etc.
Plugin 'https://github.com/kien/rainbow_parentheses.vim'
" tool for changing surrounding chars
Plugin 'https://github.com/tpope/vim-surround'
" autocreate matching pairs for parens, etc.
Plugin 'https://github.com/jiangmiao/auto-pairs'
" tool for block comments
Plugin 'https://github.com/tpope/vim-commentary'
" make vim pretty!
Plugin 'flazz/vim-colorschemes'
" show indentation levels
Plugin 'Yggroot/indentLine'
" Fuzzy file finder
Plugin 'https://github.com/ctrlpvim/ctrlp.vim.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
syntax enable
colorscheme gruvbox

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set mouse=a
set list
set number
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set colorcolumn=100
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set laststatus=2
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
"set indent line char
let g:indentLine_char = '│'
let mapleader = "\<Space>"
nnoremap <silent> <leader>p :CtrlP<CR>
