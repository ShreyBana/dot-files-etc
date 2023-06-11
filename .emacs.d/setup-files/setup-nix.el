
(use-package nix-mode
  :ensure t
  :hook ((nix-mode . eglot-ensure)
	 (nix-mode . company-mode)))

(provide 'setup-nix)

