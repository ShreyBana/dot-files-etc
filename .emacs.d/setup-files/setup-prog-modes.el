;;; -- BASIC --
(use-package jenkinsfile-mode)
(use-package fish-mode)
(use-package json-mode)
(use-package csv-mode)
(use-package smithy-mode)
(use-package markdown-mode)
(use-package kotlin-mode)
(use-package kotlin-ts-mode
  :straight (:type git :host github :repo "shreybana/kotlin-ts-mode")
  :mode ("\\.kt\\'" "\\.kts\\'")
  :hook (kotlin-ts-mode . (lambda ()
                           (setq-local display-fill-column-indicator-column 100)
                           (display-fill-column-indicator-mode 1))))
(use-package java-ts-mode
  :straight (:type built-in)
  :mode ("\\.java\\'")
  :hook (java-ts-mode . (lambda ()
                           (setq-local display-fill-column-indicator-column 100)
                           (display-fill-column-indicator-mode 1))))
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
(use-package c-ts-mode
  :straight (:type built-in)
  :mode ("\\.c\\'" "\\.C\\'"))
(use-package yaml-ts-mode
  :mode "\\.yml\\'")

;;; -- CLOJURE --
(use-package clojure-ts-mode
  :hook (clojure-ts-mode . paredit-mode))
(use-package cider)

;;; -- HASKELL --
(use-package haskell-ts-mode
  :mode "\\.hs\\'" 
  :hook
  (haskell-mode . eglot-ensure)
         ;(haskell-mode . company-mode))
  ; :hook (haskell-mode . ((lambda ()
  ; 			  (set (make-local-variable 'company-backends)
  ; 			       (append '((company-capf company-dabbrev-code))
  ; 				       company-backends)))))
  :config
  ; (set-face-attribute 'haskell-pragma-face nil :foreground "#fb4934")
  (set-face-attribute 'haskell-keyword-face nil :weight 'medium)
  (set-face-attribute 'haskell-operator-face nil :weight 'medium)
  ; (set-face-attribute 'font-lock-doc-face nil :foreground "#98971a" :slant 'oblique)
  (set-face-attribute 'haskell-definition-face nil :weight 'medium))
(use-package haskell-mode
  ;:after lsp-mode
  ;:after lsp-haskell
  :hook
  (haskell-mode . eglot-ensure)
         ;(haskell-mode . company-mode))
  ; :hook (haskell-mode . ((lambda ()
  ; 			  (set (make-local-variable 'company-backends)
  ; 			       (append '((company-capf company-dabbrev-code))
  ; 				       company-backends)))))
  :config
  ; (set-face-attribute 'haskell-pragma-face nil :foreground "#fb4934")
  (set-face-attribute 'haskell-keyword-face nil :weight 'medium)
  (set-face-attribute 'haskell-operator-face nil :weight 'medium)
  ; (set-face-attribute 'font-lock-doc-face nil :foreground "#98971a" :slant 'oblique)
  (set-face-attribute 'haskell-definition-face nil :weight 'medium))

;;; -- PURESCRIPT --
(use-package purescript-mode
  :hook ((purescript-mode . eglot-ensure)
	 (purescript-mode . turn-on-purescript-simple-indent)
	 (purescript-mode . turn-on-purescript-indentation)))

;;; -- NIX --
(use-package nix-ts-mode
  :hook (nix-ts-mode . eglot-ensure)
  :mode "\\.nix\\'")
(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(provide 'setup-prog-modes)
