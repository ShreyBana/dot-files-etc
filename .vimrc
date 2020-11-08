syntax on

set termguicolors
set term=xterm-256color
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
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
map <C-t> :NERDTreeToggle<CR>
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!g++ -std=c++17 -Wall '.shellescape('%').' -o '.shellescape('%:r')<CR>

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-python/python-syntax'
call plug#end()
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" python syntax highlights
let g:python_highlight_func_calls = 1
let g:python_highlight_operators = 1
