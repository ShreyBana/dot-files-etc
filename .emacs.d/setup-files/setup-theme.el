(use-package modus-themes
  :ensure t
  :init
  (set-cursor-color "#db7b5f")
  (setq
      modus-themes-common-palette-overrides
      '((comment yellow-cooler)
        (string green-cooler)
	(bg-hl-line bg-inactive)
	(bg-mode-line-active "#303030")
	(bg-changed-fringe "#1640b0")
	(border-mode-line-active bg-mode-line-active)))
  :config
  (load-theme 'modus-vivendi :no-confirm))

;; (use-package zenburn-theme :ensure t
;;   :config
;;   (load-theme 'zenburn :no-confirm))
(use-package spacious-padding :ensure t
  :config
  (spacious-padding-mode 1))

;; (use-package godlen-ratio :ensure t
;;   :config)

(provide 'setup-theme)
