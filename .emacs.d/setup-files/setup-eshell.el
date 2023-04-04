(use-package eshell
  :hook ((eshell-mode . (lambda () (display-fill-column-indicator-mode 0)))
	 (eshell-mode . (lambda () (hl-line-mode 0)))))

(use-package eshell-prompt-extras
  :ensure t
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(use-package fish-completion
  :ensure t
  :config (when (executable-find "fish") (global-fish-completion-mode)))


(provide 'setup-eshell)
