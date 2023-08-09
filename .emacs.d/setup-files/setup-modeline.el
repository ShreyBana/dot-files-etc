(use-package emacs
  :config
  (column-number-mode t)
  :custom-face
  (mode-line ((t (:family "RobotoMono Nerd Font Propo" :height 0.95))))
  (mode-line-active ((t (:family "RobotoMono Nerd Font Propo" :height 0.95))))
  (mode-line-inactive ((t (:family "RobotoMono Nerd Font Propo" :height 0.95)))))

(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-hud t)
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-support-imenu t)
  (doom-modeline-hud t)
  (doom-modeline-enable-word-count t)
  (doom-modeline-height 15))

(provide 'setup-modeline)
