(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  :init
  (global-corfu-mode)
  :hook (eshell-mode-hook . (lambda ()
                                (setq-local corfu-auto nil)
                                (corfu-mode)))
  :config (setq corfu-auto t
                corfu-auto-delay 0.2
                corfu-quit-no-match 'separator
                completion-styles '(orderless)))

(provide 'setup-corfu)
