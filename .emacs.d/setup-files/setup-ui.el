;;; -- EMACS UI TWEAKS --
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(recentf-mode 1)
(global-auto-revert-mode t)
(set-fringe-mode 10)
(display-time-mode t)
;(display-battery-mode t)
(toggle-truncate-lines)
(pixel-scroll-precision-mode t)
;; Line Numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;; Char Ruler
(global-display-fill-column-indicator-mode t)
(setq-default display-fill-column-indicator-column 80)
(set-face-attribute
 'fill-column-indicator nil
 :family "FiraCode Nerd Font Propo" :height 70 :weight 'bold)
(global-hl-line-mode t)

;;; -- FONT & THEME --
(set-face-attribute
 'default nil
 :family "Hack Nerd Font Propo"
 :height 160
 :weight 'regular)

(use-package ef-themes
  :config
  (load-theme 'ef-dream :no-confirm))
(use-package spacious-padding
  :config
  (spacious-padding-mode 1))

;; -- ICONS --
(use-package nerd-icons)
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode t))
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;; -- MODELINE --
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

;; -- DASHBOARD --
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (setq dashboard-projects-switch-project-action 'magit-status)
  :init
  (setq dashboard-banner-logo-title "Welcome to Emacs 🦬!")
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((projects . 8)
			  (bookmarks . 8)
			  (recents  . 8)
                          (agenda . 8)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content t)
  ;; vertically center content
  (setq dashboard-vertically-center-content t))
;; (setq dashboard-startup-banner "/home/shrey_bana/doom-emacs-logo.svg"))

(add-hook 'server-after-make-frame-hook (lambda()
;;     ;(set-cursor-color "#6c9ef8")
    (dashboard-open)
    (dashboard-mode)))

;;; -- ESHELL --
(use-package eshell
  :straight (:type built-in)
  :hook ((eshell-mode . (lambda () (display-fill-column-indicator-mode 0)))
	 (eshell-mode . (lambda () (hl-line-mode 0)))))
(use-package eshell-prompt-extras
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

;;; -- DIRED --
(use-package dired
  :straight (:type built-in)
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))
(use-package dired-single)
(use-package dired-open
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))
(use-package dirvish
  :config
  (dirvish-override-dired-mode))

;;; -- MISC --
;; Auto-Pairs
(electric-pair-mode)
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode)
  :config
  (set-face-attribute 'highlight-numbers-number nil :weight 'semi-bold))
(use-package rainbow-delimiters
  :config
  (setq rainbow-delimiters-max-face-count 4)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))
(use-package page-break-lines)
;; REVIEW Should this be here?
(use-package paredit)

(provide 'setup-ui)
