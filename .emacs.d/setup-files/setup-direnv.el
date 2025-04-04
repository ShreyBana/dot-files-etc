
;; (use-package direnv
;;   :ensure t
;;   :config
;;   (setq direnv-always-show-summary nil)
;;   (setq direnv-use-faces-in-summary nil)
;;   (direnv-mode))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(provide 'setup-direnv)
