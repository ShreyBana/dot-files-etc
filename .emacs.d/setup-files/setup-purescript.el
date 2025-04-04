
(use-package purescript-mode
  :hook ((purescript-mode . eglot-ensure)
	 (purescript-mode . turn-on-purescript-simple-indent)
	 (purescript-mode . turn-on-purescript-indentation)))

(provide 'setup-purescript)
