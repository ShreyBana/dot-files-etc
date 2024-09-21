
(use-package rust-mode
  :ensure t
  :hook ((rust-mode . eglot-ensure)))
	 ;(rust-mode . company-mode)))

(provide 'setup-rust)
