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
Plug 'netsgnut/arctheme.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'romkatv/powerlevel10k'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'gosukiwi/vim-atom-dark'
Plug 'pgavlin/pulumi.vim'
Plug 'tomasr/molokai'
Plug 'skywind3000/asyncrun.vim'
Plug 'Mizux/vim-colorschemes'
Plug 'dylnmc/novum.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'zefei/simple-dark'
Plug 'bfrg/vim-cpp-modern'
call plug#end()
set background=dark
colorscheme jummidark
let g:airline_theme='gruvbox'
" Enable highlighting of C++ attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" air-line
let g:airline_powerline_fonts = 1



if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
