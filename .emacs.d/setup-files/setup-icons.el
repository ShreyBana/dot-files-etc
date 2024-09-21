;; (use-package all-the-icons :ensure t
;;   :if (display-graphic-p))

;; (use-package all-the-icons-completion
;;   :ensure t
;;   :after all-the-icons
;;   :hook
;;   (server-after-make-frame-hook . (lambda () (all-the-icons-completion-mode))))

(use-package nerd-icons :ensure t
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )
(use-package nerd-icons-completion
  :ensure t
  :config
  (nerd-icons-completion-mode))


(provide 'setup-icons)
