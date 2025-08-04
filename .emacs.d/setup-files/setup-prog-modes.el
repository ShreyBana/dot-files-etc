(use-package format-all)
;;; -- BASIC --
(use-package jenkinsfile-mode)
(use-package fish-mode)
(use-package json-mode)
(use-package csv-mode)
;; (use-package smithy-mode)
(use-package smithy-ts-mode
  :straight (:type git :local-repo "/home/shrey_bana/sdk/smithy-ts-mode")
  :mode "\\.smithy\\'")
(use-package markdown-mode)
;; (use-package kotlin-mode)
(use-package yaml-mode)
(use-package kotlin-ts-mode
  :straight (:type git :repo "shreybana/kotlin-ts-mode" :host github)
  :mode ("\\.kt\\'" "\\.kts\\'")
  :hook (kotlin-ts-mode . (lambda ()
                            (setq-local display-fill-column-indicator-column 90))))
(use-package java-ts-mode
  :straight (:type built-in)
  :hook (java-ts-mode . (lambda ()
                            (setq-local display-fill-column-indicator-column 90))))
(use-package dockerfile-mode)
(use-package emacs-lisp-mod
  :straight (:type built-in)
  :hook (emacs-lisp-mode . paredit-mode))
(use-package typescript-ts-mode
  :mode "\\.ts\\'")
(use-package rust-mode
  :hook ((rust-mode . eglot-ensure)))
(use-package justl
  :custom
  (justl-executable "/nix/store/j2lvlwr1cya4j7x6n4w6c1mrwrsfihyq-just-1.13.0/bin/just"))
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;;; -- CLOJURE --
(use-package clojure-mode
  :hook (clojure-mode . paredit-mode))
(use-package cider)

;;; -- HASKELL --
(use-package haskell-ts-mode
  :mode "\\.hs\\'"
  :custom
  (haskell-ts-font-lock-level 4)
  (haskell-ts-use-indent t)
  (haskell-ts-ghci "ghci")
  (haskell-ts-use-indent t)
  :config
  (add-to-list 'treesit-language-source-alist
   '(haskell . ("https://github.com/tree-sitter/tree-sitter-haskell" "v0.23.1"))))

;;; -- PURESCRIPT --
(use-package purescript-mode
  :hook ((purescript-mode . eglot-ensure)
	 (purescript-mode . turn-on-purescript-simple-indent)
	 (purescript-mode . turn-on-purescript-indentation)))

;;; -- NIX --
(use-package nixpkgs-fmt)
(use-package nix-mode)
(use-package nix-ts-mode
  :hook ((nix-ts-mode . eglot-ensure)
         (nix-ts-mode . format-all-mode))
  :mode "\\.nix\\'")
(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(provide 'setup-prog-modes)
