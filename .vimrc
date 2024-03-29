"--SYNTAX & RELATED--"
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
filetype indent off
set nowrap
set smartcase
set noswapfile
set nobackup
set nocompatible
set undodir=~/.vim/undodir
set undofile
set incsearch
set rnu
set encoding=UTF-8
set cursorline
highlight Comment cterm=italic gui=italic

"--VIM PLUG--"
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-python/python-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ryanoasis/vim-devicons'
Plug 'pacha/vem-tabline'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'dense-analysis/ale'
Plug 'eslint/eslint'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'uiiaoo/java-syntax.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()
let g:vem_tabline_show_number = "buffnr"
"--ALE--"
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'css': ['prettier'], 'html': ['prettier'], 'json': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
"--Prettier--"

"--COLOR SCHEMING--"
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1
set background=dark
let g:airline_theme = "gruvbox"
colorscheme gruvbox
let g:python_highlight_func_calls = 1
let g:python_highlight_operators = 1
 let g:indent_blankline_char = ''

"--KEY BINDINGS--"
let mapleader = ";"
map <C-g> :FZF<CR>
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!clear; g++ -std=c++20 -Wall '.shellescape('%').' -o '.shellescape('%:r')<CR>
autocmd filetype c nnoremap <F8> :w <bar> exec '!clear; gcc -Wall '.shellescape('%').' -o '.shellescape('%:r')<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Space>h :wincmd h<CR>
nnoremap <Space>j :wincmd j<CR>
nnoremap <Space>k :wincmd k<CR>
nnoremap <Space>l :wincmd l<CR>
nnoremap <Space>b :buffers<CR>:buffer<Space>
nnoremap H gT
nnoremap L gt
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

"--AUTORUN--"
autocmd BufWritePre *.py execute ':Black'

"--STARTUP--"
"autocmd VimEnter * NERDTree
autocmd BufNewFile,BufRead *.fish set syntax=bash
