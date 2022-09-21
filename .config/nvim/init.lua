local set = vim.opt

-- SYNTAX
set.syntax = 'on'
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.smartcase = true
set.wrap = false
set.linebreak = true
set.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'
set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true

-- META
set.swapfile = false
set.backup = false
set.compatible = false
set.undodir = '/Users/shrey.bana/.vim/undodir/'
set.undofile = true
set.incsearch = true
set.rnu = true
set.encoding = 'UTF-8'
set.cursorline = true
vim.cmd("au BufNewFile,BufRead *.purs setf purescript")
vim.cmd("au BufNewFile,BufRead *.sh let b:is_bash=1")

-- KEY-MAPPINGS
vim.g.mapleader = ';' 
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>ff' ,'<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg' ,'<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb' ,'<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh' ,'<cmd>Telescope help_tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>t' ,'<cmd>NvimTreeToggle<cr>', opts)
vim.api.nvim_set_keymap('n', 'H' ,'<cmd>BufferLineCyclePrev<cr>', opts)
vim.api.nvim_set_keymap('n', 'L' ,'<cmd>BufferLineCycleNext<cr>', opts)
vim.cmd("map <leader>h <C-w>h");
vim.cmd("map <leader>l <C-w>l");
vim.cmd("map <leader>k <C-w>k");
vim.cmd("map <leader>j <C-w>j");
vim.cmd("nnoremap <leader>bb :BufferLineMoveNext<CR>")
vim.cmd("nnoremap <leader>bf :BufferLineMovePrev<CR>")

-- PLUGINS
require('plugins.init')
require('plugins.lsp.null-ls')
require('plugins.lsp.cmp')
require('plugins.lsp.init')

-- COLORS
set.termguicolors = true
set.background = 'dark'
vim.g.gruvbox_italic = true
vim.cmd('colorscheme gruvbox')
vim.cmd('hi darkolivegreen guifg=#556b2f')
vim.cmd('hi! link Function gruvboxyellow')
vim.cmd('hi! link Noise gruvboxfg4')
vim.cmd('hi! link Operator gruvboxblue')
