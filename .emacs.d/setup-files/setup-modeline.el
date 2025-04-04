(use-package emacs
  :straight (:type built-in)
  :config
  (column-number-mode t)
  :custom-face
  (mode-line ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98))))
  (mode-line-active ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98))))
  (mode-line-inactive ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98)))))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-vcs-max-length 24)
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-support-imenu t)
  (doom-modeline-hud t)
  (doom-modeline-bar-width 9)
  (doom-modeline-enable-word-count 0))

(provide 'setup-modeline)
