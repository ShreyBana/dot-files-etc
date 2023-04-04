(use-package modus-themes
  :ensure t
  :init
  (setq modus-themes-common-palette-overrides
      '((comment yellow-cooler)
        (string green-cooler)))
  (setq modus-themes-vivendi-color-overrides
      '((bg-main . "#25152a")))
  :config
  (load-theme 'modus-vivendi))

;(load-theme 'doom-gruvbox t)
;(use-package zenburn-theme
;  :ensure t
;  :config
;  (load-theme 'zenburn t))

(provide 'setup-theme)
