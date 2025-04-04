(use-package nix-ts-mode
  :hook (nix-ts-mode . eglot-ensure)
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-ts-mode)))

(provide 'setup-nix)

