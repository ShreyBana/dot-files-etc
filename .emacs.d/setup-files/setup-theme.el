(use-package modus-themes
  :ensure t
  :init
  (setq
      modus-themes-common-palette-overrides
      '((comment yellow-cooler)
        (string green-cooler))
      modus-vivendi-palette-overrides
      '((bg-main "#282828")
	(fg-main "#d9d4cb")
	(bg-hl-line bg-inactive)
	(fnname "#f4974f")
	(keyword red)
	(preprocessor red)))
  :config
  (load-theme 'modus-vivendi :no-confirm))

;(load-theme 'doom-gruvbox t)
;(use-package zenburn-theme
;  :ensure t
;  :config
;  (load-theme 'zenburn t))

(provide 'setup-theme)
