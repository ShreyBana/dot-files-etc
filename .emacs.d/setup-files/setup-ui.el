;;; EMACS UI TWEAKS
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
 :family "Iosevka Comfy" :height 60 :weight 'regular)
(global-hl-line-mode 0)

;;; FONT & THEME
(set-face-attribute
 'default nil
 :family "Hack Nerd Font Propo"
 :height 170
 :weight 'regular)

(use-package ef-themes
  :custom-face
  (ef-themes-underline-info ((t (:style dotted))))
  :config
  (setq ef-dream-palette-overrides
        '((bg-main "#0f0e10")
          (builtin magenta-warmer)
          (type green-cooler)
          (fnname cyan)
          (string red)
          (variable magenta-warmer)
          (cursor yellow-warmer)
          (rainbow-1 magenta-warmer)))
  (setq ef-symbiosis-palette-overrides
        '((bg-main "#0D060B")
          (keyword "#aba731")
          (underline-info blue)
          (info blue)))
  (load-theme 'ef-symbiosis :no-confirm))
(use-package spacious-padding
  :hook
  (server-after-make-frame . spacious-padding-mode))
(use-package standard-themes)
(use-package treesit
  :straight (:type built-in)
  :init
  (setq treesit-font-lock-level 3))

;;; NERD/ICONS
(defun init/setup-icons ()
  (use-package nerd-icons)
  (use-package nerd-icons-ibuffer
    :hook (ibuffer-mode . nerd-icons-ibuffer-mode))
  (use-package nerd-icons-completion
    :config
    (nerd-icons-completion-mode t))
  (use-package nerd-icons-dired
    :hook
    (dired-mode . nerd-icons-dired-mode))
  (use-package nerd-icons-corfu))
(use-package nerd-icons
  :hook (server-after-make-frame . init/setup-icons))

;;; MODELINE
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

;;; DASHBOARD
(use-package dashboard
  :hook
  (server-after-make-frame . (lambda ()
                               (dashboard-setup-startup-hook)
                               (dashboard-refresh-buffer)))
  :init
  (setq dashboard-banner-logo-title "*E M A C S*")
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((projects . 5)
			  (bookmarks . 5)
			  (recents  . 5)
                          (agenda . 5)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content t)
  ;; vertically center content
  (setq dashboard-vertically-center-content t)
  (setq dashboard-startup-banner 'logo))

;;; ESHELL
(use-package eshell
  :straight (:type built-in)
  :hook ((eshell-mode . (lambda () (display-fill-column-indicator-mode 0)))
	 (eshell-mode . (lambda () (hl-line-mode 0)))))
(use-package eshell-prompt-extras
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

;;; DIRED 
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

;;; VTerm
(use-package vterm
  :custom
  ;; General settings
  (vterm-max-scrollback 10000)
  ;; (vterm-buffer-name-string "vterm: %s")
  (vterm-timer-delay 0.01)
  
  ;; Shell settings
  (vterm-shell (getenv "SHELL"))
  
  ;; Terminal type
  (vterm-term-environment-variable "xterm-256color")
  
  ;; Cursor settings
  (vterm-set-bold-hightbright t)
  
  ;; Mouse support
  (vterm-enable-manipulate-selection-data-by-osc52 t)
  
  :bind (("C-c t" . vterm)
         :map vterm-mode-map
         ("C-c C-j" . vterm-copy-mode)
         ("C-c C-k" . vterm-copy-mode-done)
         ("C-c C-e" . vterm-send-escape)  ;; Add keybinding for sending escape
         ("C-c C-t" . vterm-copy-mode)
         ("C-c C-y" . vterm-yank)
         ("C-c C-q" . vterm-send-next-key)
         ("<escape>" . evil-normal-state)
         ("C-d" . nil))  ;; Prevent accidental closure
  
  :hook
  (vterm-mode . (lambda ()
                  (display-fill-column-indicator-mode 0)
                  (setq-local scroll-margin 0)
                  (setq-local scroll-conservatively 101)
                  (when (bound-and-true-p global-hl-line-mode)
                    (setq-local global-hl-line-mode nil))
                  ;; (set-window-dedicated-p (selected-window) t)
                  (display-line-numbers-mode 0))))

;;; EDIFF
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; MISC 
;; Auto-Pairs
(electric-pair-mode)
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode)
  :config
  (set-face-attribute 'highlight-numbers-number nil :weight 'semi-bold))
(use-package rainbow-delimiters
  :config
  (setq rainbow-delimiters-max-face-count 5)
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

(use-package denote)

(use-package lin
  :config
  (lin-global-mode t))

(use-package pulsar
  :config
  (pulsar-global-mode t))

(use-package pass)
(use-package bluetooth)
(use-package sideline-flymake
  :hook (flymake-mode . sideline-mode)
  :init
  (setq sideline-flymake-display-mode 'point) ; 'point to show errors only on point
                                              ; 'line to show errors on the current line
  (setq sideline-backends-right '(sideline-flymake)))

(provide 'setup-ui)
