
(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :ensure t
  :hook (sh-mode . tree-sitter-hl-mode))

(provide 'setup-tree-sitter)
