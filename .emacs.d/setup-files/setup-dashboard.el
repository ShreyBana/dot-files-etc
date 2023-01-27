
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :init
  (setq dashboard-items '((projects . 5)
			  (bookmarks . 5)
			  (recents  . 5)
                          (agenda . 5)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner 'logo))

(add-hook 'server-after-make-frame-hook (lambda()
    (set-cursor-color "#6c9ef8")
    (switch-to-buffer dashboard-buffer-name)
    (dashboard-mode)
    (dashboard-insert-startupify-lists)
    (dashboard-refresh-buffer)))

(provide 'setup-dashboard)
