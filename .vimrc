syntax on
set term=xterm-256color
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
filetype indent off
set cindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set rnu
set encoding=UTF-8
set cursorline

"--VIM PLUG--"
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-python/python-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ryanoasis/vim-devicons'
Plug 'pacha/vem-tabline'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

"--COLOR SCHEMING--"
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'
let g:python_highlight_func_calls = 1
let g:python_highlight_operators = 1

"--KEY BINDINGS--"
let mapleader = "."
map <C-g> :FZF<CR>
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!clear; g++ -std=c++20 -Wall '.shellescape('%').' -o '.shellescape('%:r')<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Space>h :wincmd h<CR>
nnoremap <Space>j :wincmd j<CR>
nnoremap <Space>k :wincmd k<CR>
nnoremap <Space>l :wincmd l<CR>
nnoremap H gT
nnoremap L gt
