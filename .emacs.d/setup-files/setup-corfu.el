(use-package corfu
  :ensure t
  ;; :custom
  ;; (corfu-cycle t)
  :custom
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
  (corfu-popupinfo-delay 0.25)
  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  :hook
  (eshell-mode-hook . (lambda ()
                        (setq-local corfu-auto t)
                        (corfu-mode)))
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.1
	corfu-popupinfo-mode t ;; For popup doc.
        corfu-quit-no-match 'separator
        completion-styles '(orderless)))

;; Extensions
(use-package pcmpl-args
  :ensure t) ;; Extends eshell pcomplete to give completion from MAN pages

(provide 'setup-corfu)
