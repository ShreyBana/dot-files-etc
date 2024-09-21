
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :init
  (setq dashboard-banner-logo-title "Welcome to Emacs 🐐!")
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((projects . 8)
			  (bookmarks . 8)
			  (recents  . 8)
                          (agenda . 8)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; vertically center content
  (setq dashboard-vertically-center-content t))
;; (setq dashboard-startup-banner "/home/shrey_bana/doom-emacs-logo.svg"))

(add-hook 'server-after-make-frame-hook (lambda()
    ;(set-cursor-color "#6c9ef8")
    (switch-to-buffer dashboard-buffer-name)
    (dashboard-mode)
    (dashboard-insert-startupify-lists)
    (dashboard-refresh-buffer)))

(provide 'setup-dashboard)
