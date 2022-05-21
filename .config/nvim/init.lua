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
set.wrap = true
set.linebreak = true
set.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'

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

-- PLUGINS
require('plugins.init')
require('plugins.lualine')
require('plugins.telescope')
require('plugins.nvim-tree')
require('plugins.treesitter')
require('plugins.bufferline')
require('plugins.gitsigns')
require('plugins.lsp.null-ls')
require('plugins.lsp.cmp')
require('plugins.lsp.init')

-- COLORS
set.termguicolors = true
set.background = 'dark'
vim.g.gruvbox_italic = true
vim.cmd('colorscheme gruvbox')
vim.cmd('hi darkolivegreen guifg=#556b2f')
-- purescript <==>
vim.cmd('hi! link purescriptModuleKeyword gruvboxred')
vim.cmd('hi! link purescriptModule gruvboxyellow')
vim.cmd('hi! link purescriptImportKeyword gruvboxred')
vim.cmd('hi! link purescriptImport gruvboxyellow')
vim.cmd('hi! link purescriptWhere gruvboxred')
vim.cmd('hi! link purescriptAsKeyword gruvboxred')
vim.cmd('hi! link purescriptImportAs gruvboxred')
vim.cmd('hi! link purescriptHidingKeyword gruvboxaqua')
vim.cmd('hi! link purescriptFunction gruvboxaqua')
vim.cmd('hi! link purescriptFunctionDecl gruvboxyellow')
vim.cmd('hi! link purescriptOperatorFunction gruvboxblue')
vim.cmd('hi! link purescriptConstructor gruvboxaqua')
vim.cmd('hi! link purescriptTypeVar gruvboxblue')
vim.cmd('hi! link purescriptOperatorType gruvboxblue')
vim.cmd('hi! link purescriptOperatorTypeSig gruvboxblue')
vim.cmd('hi! link purescriptDelimiter gruvboxfg4')
vim.cmd('hi! link purescriptDot gruvboxblue')
vim.cmd('hi! link purescriptConditional gruvboxred')
vim.cmd('hi! link purescriptConstructor gruvboxyellow')
-- haskell
vim.cmd('hi! link haskellImportKeywords gruvboxred')
vim.cmd('hi! link haskellForeignKeyword gruvboxred')
vim.cmd('hi! link haskellKeyword gruvboxred')
vim.cmd('hi! link haskellDeclKeyword gruvboxred')
vim.cmd('hi! link haskellType gruvboxyellow')
vim.cmd('hi! link haskellOperators gruvboxblue')
vim.cmd('hi! link haskellBrackets gruvboxfg4')
vim.cmd('hi! link haskellDelimiter gruvboxfg4')
-- javascript
vim.cmd('hi! link jsFuncName gruvboxyellow')
vim.cmd('hi! link jsFunction gruvboxorange')
vim.cmd('hi! link jsFuncCall gruvboxyellow')
vim.cmd('hi! link jsNoise gruvboxfg4')
vim.cmd('hi! link jsOperator gruvboxblue')
vim.cmd('hi! link jsDot gruvboxblue')
vim.cmd('hi! link jsBrackets gruvboxfg4')
vim.cmd('hi! link jsDestructuringBraces gruvboxfg4')
vim.cmd('hi! link Noise gruvboxfg4')
vim.cmd('hi! link jsVariableDef gruvboxblue')
vim.cmd('hi! link jsFuncArgs gruvboxblue')
vim.cmd('hi! link jsGlobalObjects gruvboxbluebold')
vim.cmd('hi! link jsGlobalNodeObjects gruvboxaquabold')
vim.cmd('hi! link jsDestructuringBlock gruvboxblue')
vim.cmd('hi! link jsObjectKey cleared')
vim.cmd('hi! link jsSpecial gruvboxpurple')
-- json
vim.cmd('hi! link jsonBraces Noise')
vim.cmd('hi! link jsonQuote Noise')
vim.cmd('hi! link jsonString gruvboxgreen')
vim.cmd('hi! link jsonKeyword gruvboxblue')
-- java
vim.cmd('hi! link javaFunction gruvboxyellow')
vim.cmd('hi! link javaOperator gruvboxblue')
vim.cmd('hi! link javaDelimiter gruvboxgray')
vim.cmd('hi! link javaSpecial gruvboxblue')
vim.cmd('hi! link javaIdentifier gruvboxfg1')
vim.cmd('hi! link javaType gruvboxorange')
vim.cmd('hi! link javaStorageClass gruvboxred')
vim.cmd('hi! link javaStructure gruvboxred')
vim.cmd('hi! link javaPackagePath gruvboxblue')
-- python
vim.cmd('hi! link pythonClassVar gruvboxbluebold')
vim.cmd('hi! link pythonFunction gruvboxyellow')
vim.cmd('hi! link pythonFunctionCall gruvboxyellow')
vim.cmd('hi! link pythonImport gruvboxaqua')
vim.cmd('hi! link pythonInclude gruvboxaqua')
vim.cmd('hi! link pythonDot gruvboxblue')
vim.cmd('hi! link pythonBuiltin gruvboxbluebold')
vim.cmd('hi! link pythonOperator gruvboxblue')
vim.cmd('hi! link pythonNone gruvboxpink')
vim.cmd('hi! link pythonNoise gruvboxgray')
vim.cmd('hi! link pythonDecorator gruvboxblue')
vim.cmd('hi! link pythonDecoratorName gruvboxblue')
vim.cmd('hi! link pythonDottedName gruvboxblue')
vim.cmd('hi! link pythonBrackets gruvboxgray')
