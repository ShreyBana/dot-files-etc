
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

;; UI Tweaks
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(recentf-mode 1)
(global-auto-revert-mode t)
(set-fringe-mode 10)
(display-time-mode t)
;(display-battery-mode t)
(toggle-truncate-lines)

;; Auto-Pairs
(electric-pair-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Fonts Settings
(set-face-attribute
 'default nil
 :family "Hack Nerd Font Propo"
 :height 170
 :weight 'regular)

;; Custom Var Options
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Char Ruler
(setq-default display-fill-column-indicator-column 80)

(global-display-fill-column-indicator-mode t)

(global-hl-line-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(add-to-list 'load-path "~/.emacs.d/setup-files/")
;; UI/UX
(require 'setup-icons)
(require 'setup-dashboard)
(require 'setup-evil)
(require 'setup-theme)
(require 'setup-modeline)
(require 'setup-orderless)
(require 'setup-vertico)
(require 'setup-consult)
(require 'setup-corfu)
(require 'setup-cape)
(require 'setup-page-break-lines)
(require 'setup-org)
(require 'setup-git)
(require 'setup-project)
(require 'setup-rainbow-delimiters)
(require 'setup-eshell)
(require 'setup-dired)
(require 'setup-dirvish)
(require 'setup-hl-todo)
;; Eglot
(require 'setup-eglot)

;; Misc
(require 'setup-direnv)
(require 'setup-docker)
(require 'setup-editorconfig)

;; Languages
(require 'setup-haskell)
(require 'setup-purescript)
(require 'setup-javascript)
(require 'setup-nix)
(require 'setup-rust)
(require 'setup-clojure)
(require 'setup-just)

;; Perf Tuning
(setq gc-cons-threshold (* 1024 1024 1024))
(use-package gcmh :ensure t
  :init
  (setq gcmh-high-cons-threshold (* 1024 1024 1024))
  (setq gcmh-idle-delay-factor 20)
  :config
  (gcmh-mode 1))
(setq jit-lock-defer-time 0.05)
(setq read-process-output-max (* 1024 1024))
(setq package-native-compile t)

;; Line Numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
