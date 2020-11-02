syntax on

set termguicolors
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set expandtab
set smarttab
set autoindent
filetype indent off
set cindent
set nowrap
set relativenumber
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
map <C-t> :NERDTreeToggle<CR>
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!g++ -std=c++17 -Wall '.shellescape('%').' -o '.shellescape('%:r')<CR>

call plug#begin('~/.vim/plugged')
Plug 'jcherven/jummidark.vim'
Plug 'romkatv/powerlevel10k'
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-python/python-syntax'
Plug 'ycm-core/YouCompleteMe'
call plug#end()
set background=dark
colorscheme jummidark
" Enable highlighting of C++ attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" python syntax highlights
let g:python_highlight_func_calls = 1
let g:python_highlight_operators = 1
