return require('nvim-treesitter.configs').setup {
  -- A list of parser names, or 'all'
  ensure_installed = { 'c', 'lua', 'rust', 'haskell', 'cpp', 'elm' }
}
