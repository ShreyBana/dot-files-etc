
(use-package js2-mode
  :ensure t
  :hook (js2-mode . eglot-ensure)
  :mode
  (("\\.js\\'" . js2-mode))
  :custom
  (js2-include-node-externs t)
  (js2-highlight-level 3)
  (js-indent-align-list-continuation t)
  :config
  (set-face-attribute 'js2-object-property nil :foreground "#83a598")
  (js2-mode-hide-warnings-and-errors)
  (setq js-indent-level 2))

(setq lsp-javascript-completions-complete-function-calls nil)

(provide 'setup-javascript)
