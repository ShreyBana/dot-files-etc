(use-package modus-themes
  :ensure t
  :init
  (set-cursor-color "#dfaf7a")
  (setq
      modus-themes-common-palette-overrides
      '((comment yellow-cooler)
        (string green-cooler))
      modus-vivendi-palette-overrides
      '((bg-main "#282828")
	(fg-main "#d9d4cb")
	(bg-hl-line bg-inactive)
	(bg-mode-line-active "#454545")
	(border-mode-line-active bg-mode-line-active)
	(fnname "#f4974f")
	(bg-active "#4d4d4d")
	(keyword red)
	(preprocessor red)))
  :config
  (load-theme 'modus-vivendi :no-confirm))

;(load-theme 'doom-solarized-dark t)
;(use-package zenburn-theme
;  :ensure t
;  :config
;  (load-theme 'zenburn t))

(provide 'setup-theme)
