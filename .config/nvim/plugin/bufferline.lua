return require('bufferline').setup({
  options = {
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    show_close_icon = false,
    diagnostics = "nvim_lsp",
    separator_style = "slant",
    sort_by = "directory",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    }
  }
})
