(use-package eshell
  :straight (:type built-in)
  :hook ((eshell-mode . (lambda () (display-fill-column-indicator-mode 0)))
	 (eshell-mode . (lambda () (hl-line-mode 0)))))

(use-package eshell-prompt-extras
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

(use-package fish-completion
  :config (when (executable-find "fish") (global-fish-completion-mode)))

(provide 'setup-eshell)
