
(use-package purescript-mode
  :ensure t
  :hook (;(purescript-mode . eglot-ensure)
	 (purescript-mode . company-mode)
	 (purescript-mode . turn-on-purescript-simple-indent)
	 (purescript-mode . turn-on-purescript-indentation)))

(provide 'setup-purescript)
