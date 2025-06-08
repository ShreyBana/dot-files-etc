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
;; (global-hl-line-mode t)

;;; -- FONT & THEME --
(set-face-attribute
 'default nil
 :family "Hack Nerd Font Propo"
 :height 170
 :weight 'regular)

(use-package ef-themes
  :custom
  (ef-dream-palette-overrides 
   '((bg-main "#161417")
     (bg-mode-line "#5C4866")
     (builtin magenta-warmer)
     (variable magenta-warmer)
     (type green-cooler)
     (fnname cyan)
     (string red)
     (cursor yellow-cooler)
     (rainbow-1 magenta-warmer)))
  :config
  (load-theme 'ef-dream :no-confirm))
(use-package spacious-padding
  :hook
  (server-after-make-frame . spacious-padding-mode)
  :custom
  (spacious-padding-width
   '(:internal-border-width 10
     :header-line-width 4
     :mode-line-width 4
     :tab-width 4
     :right-divider-width 30
     :scroll-bar-width 8
     :fringe-width 8)))
(setq treesit-font-lock-level 4)

(use-package lin
  :config
  (lin-global-mode 1))

(use-package pulsar
  :config
  (pulsar-global-mode 1))

;;; -- ICONS --
(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Hack Nerd Font Propo"))
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode t))
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-corfu)

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
  :hook
  (server-after-make-frame . (lambda ()
			       (dashboard-open)
                               ;; Have to call this otherwise the content
                               ;; doesn't center correctly.
                               (dashboard-refresh-buffer)
                               (dashboard-refresh-buffer)))
  :init
  (setq dashboard-banner-logo-title "* E M A C S *")
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((projects . 4)
			  (bookmarks . 4)
			  (recents  . 4)
                          (agenda . 4)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner "/home/shrey_bana/pictures/adafruit-svgrepo-com.svg")
  (setq dashboard-vertically-center-content t))

;;; EDIFF
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;;; -- ESHELL --
(use-package eshell
  :straight (:type built-in)
  :hook ((eshell-mode . (lambda () (display-fill-column-indicator-mode 0)))
	 (eshell-mode . (lambda () (hl-line-mode 0)))))
(use-package eshell-prompt-extras
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

;;; VTerm
(use-package vterm
  :straight t
  :bind (("C-c t" . vterm)
         ("C-c <escape>" . vterm-send-escape)
         :map vterm-mode-map
         ("C-c C-t" . vterm-copy-mode)
         ("C-c C-y" . vterm-yank))
  :custom
  ;; UI settings
  (vterm-max-scrollback 10000)
  (vterm-always-compile-module t)
  ;; Cursor type (box gives terminal-like feel)
  ;; (vterm-cursor-type 'box)
  ;; Enable undercurl and other term features
  (vterm-term-environment-variable "xterm-256color")
  :hook
  (vterm-mode . (lambda ()
                  (display-fill-column-indicator-mode 0)
                  ;; Disable line numbers which can cause display issues
                  (display-line-numbers-mode -1)
                  ;; Disable hl-line which can cause display issues
                  (when (bound-and-true-p global-hl-line-mode)
                    (setq-local global-hl-line-mode nil))
                  ;; Disable cursor blinking for better performance
                  (setq-local blink-cursor-mode nil)
                  ;; Smoother scrolling in vterm
                  (setq-local scroll-margin 0)
                  (setq-local scroll-conservatively 101)
                  ;; Match terminal background with theme (optional)
                  ;; Uncomment and modify based on your theme
                  ;; (setq-local vterm-color-black (face-background 'default))
                  ))
  :config
  ;; Make the terminal more responsive
  (setq vterm-timer-delay 0.01)
  
  ;; Integrate vterm with directory tracking
  (setq vterm-eval-cmds '(("find-file" find-file)
                          ("message" message)
                          ("vterm-clear-scrollback" vterm-clear-scrollback)
                          ("dired" dired)))

  ;; Help with copying and pasting
  (setq vterm-copy-exclude-prompt t))
(defun project-vterm ()
  "Open vterm at the root of the current project."
  (interactive)
  (let* ((default-directory (project-root (project-current)))
         (name (format "*vterm: %s*" (project-name (project-current))))
         (buffer (get-buffer name)))
    (if buffer (switch-to-buffer buffer)
      (vterm name))))

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

(use-package lin
  :config
  (setq lin-mode-hooks
      '(bongo-mode-hook
        dired-mode-hook
        elfeed-search-mode-hook
        git-rebase-mode-hook
        grep-mode-hook
        ibuffer-mode-hook
        ilist-mode-hook
        ledger-report-mode-hook
        log-view-mode-hook
        magit-log-mode-hook
        mu4e-headers-mode-hook
        notmuch-search-mode-hook
        notmuch-tree-mode-hook
        occur-mode-hook
        org-agenda-mode-hook
        pdf-outline-buffer-mode-hook
        proced-mode-hook
        tabulated-list-mode-hook))
  (lin-global-mode 1))

(use-package denote)

(use-package password-store)
(use-package pass)
(use-package bluetooth)

(provide 'setup-ui)
