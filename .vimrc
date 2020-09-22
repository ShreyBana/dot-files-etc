syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set nowrap
set relativenumber
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set statusline+=%F

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
call plug#end()
set t_Co=256
set background=dark
colorscheme novum
let g:airline_theme='dracula'
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
map <C-t> :NERDTreeToggle<CR>
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r')<CR>
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
