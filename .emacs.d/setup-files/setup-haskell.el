;(use-package lsp-haskell
;  :ensure t)

(use-package haskell-mode
  :ensure t
  ;:after lsp-mode
  ;:after lsp-haskell
  :hook ((haskell-mode . eglot-ensure))
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

(provide 'setup-haskell)
