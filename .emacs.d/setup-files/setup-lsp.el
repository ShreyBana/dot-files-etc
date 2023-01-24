
(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-diagnostics-provider :none))
;  :ensure t
;  :commands (lsp lsp-deffered)
;  :init
;  (setq lsp-keymap-prefix "C-c l")
;  :config 
;  (lsp-enable-which-key-integration t))
;  
;(use-package lsp-haskell
;  :ensure t
;  :config
;  (add-hook 'haskell-mode-hook #'lsp)
;  (add-hook 'haskell-literate-mode-hook #'lsp))

; (use-package lsp-ui
;   :ensure t
;   :hook (lsp-mode . lsp-ui-mode))

(provide 'setup-lsp)
