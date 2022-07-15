return require('nvim-tree').setup {
  git = {
    ignore = false
  },
  view = {
    adaptive_size = false,
    side = "right"
  },
  renderer = {
    indent_markers = {
      enable = true
    },
    icons = {
      git_placement = "after"
    }
  },
}
