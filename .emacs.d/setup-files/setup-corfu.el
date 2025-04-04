(use-package nerd-icons-corfu)

(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-auto t)
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
  (corfu-popupinfo-delay 0.2)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("C-SPC" . corfu-insert-separator))

  :init
  (global-corfu-mode)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  (setq corfu-auto t
        corfu-auto-delay 0.15
        corfu-quit-no-match 'separator
        corfu-popupinfo-mode t
        completion-styles '(orderless)))
;; Extensions
(use-package pcmpl-args) ;; Extends eshell pcomplete to give completion from MAN pages

(provide 'setup-corfu)
