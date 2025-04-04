(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
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
(pixel-scroll-precision-mode t)

;; Auto-Pairs
(electric-pair-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Fonts Settings
(set-face-attribute
 'default nil
 :family "Hack Nerd Font Propo"
 :height 160
 :weight 'regular)

;; Custom Var Options
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Line Numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Char Ruler
(setq-default display-fill-column-indicator-column 80)
;(setq-default display-fill-column-indicator-character "||")
(set-face-attribute
 'fill-column-indicator nil
 :family "FiraCode Nerd Font Propo" :height 70 :weight 'bold)

(global-display-fill-column-indicator-mode t)

(global-hl-line-mode t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)
;; (custom-set-variables
;;  '(package-selected-packages
;;    '(doom-modeline all-the-icons use-package doom-themes gruvbox-theme)))
;; (custom-set-faces
;;  )
(setq package-enable-at-startup nil)
;; (use-package exec-path-from-shell)
;; (when (memq window-system '(mac ns x))
  ;; (exec-path-from-shell-initialize))

;; (setq use-package-always-ensure t)
(add-to-list 'load-path "~/.emacs.d/setup-files/")


(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; Better Doc & Help Pages
 (use-package helpful
   ;:custom
   ;(counsel-describe-function-function #'helpful-callable)
   ;(counsel-describe-varaible-function #'helpful-variable)
   :bind
   ;([remap describe-function] . counsel-describe-function)
   ([remap describe-command] . helpful-command)
   ;([remap describe-variable] . counsel-describe-variable)
   ([remap describe-key] . helpful-key))
 
 (use-package highlight-numbers
   :hook (prog-mode . highlight-numbers-mode)
   :config
   (set-face-attribute 'highlight-numbers-number nil :weight 'semi-bold))
 
 (global-set-key (kbd "M-b") 'switch-to-buffer)
; 
(use-package jenkinsfile-mode)
(use-package fish-mode)
(use-package json-mode)
(use-package csv-mode)
(use-package smithy-mode)
;; (use-package origami :ensure t
;;   :config
;;   (global-origami-mode))
;; ;; (use-package highlight-indent-guides :ensure t
;;   :config 
;;   (highlight-indent-guides-mode t))
;; ;; (use-package yasnippet :ensure t)

(require 'setup-evil)
(require 'setup-theme)
(require 'setup-modeline)
(require 'setup-orderless)
(require 'setup-vertico)
(require 'setup-consult)
(require 'setup-dashboard)
(require 'setup-corfu)
(require 'setup-git)
(require 'setup-org)
(require 'setup-eglot)
(require 'setup-copilot)
(require 'setup-haskell)
(require 'setup-purescript)
(require 'setup-javascript)
(require 'setup-markdown)
(require 'setup-kotlin)
(require 'setup-tree-sitter)
(require 'setup-page-break-lines)
(require 'setup-dired)
(require 'setup-elisp)
(require 'setup-eshell)
(require 'setup-nix)
(require 'setup-rust)
(require 'setup-direnv)
(require 'setup-docker)
(require 'setup-cape)
(require 'setup-project)
(require 'setup-clojure)
(require 'setup-rainbow-delimiters)
(require 'setup-just)
(require 'setup-editorconfig)
(require 'setup-dirvish)
(require 'setup-hl-todo)
(require 'setup-yasnippet)
(require 'setup-nerd-icons)

;(add-to-list 'after-make-frame-functions (lambda (frame) (set-cursor-color "#6c9ef8")))
(defun new-frame-setup (frame)
  (if (display-graphic-p frame)
      (setq neo-theme 'icons)))
;; Run for already-existing frames (For single instance emacs)
(mapc 'new-frame-setup (frame-list))
;; Run when a new frame is created (For emacs in client/server mode)
(add-hook 'after-make-frame-functions 'new-frame-setup)
;(add-hook 'after-make-frame-functions (lambda (frame) (set-cursor-color "#49cf66")))
(setq frame-inhibit-implied-resize t)
(setq x-gtk-use-system-tooltips nil)

(put 'downcase-region 'disabled nil)
(defun my-minibuffer-setup-hook ()
  (setq-local face-remapping-alist '((default (:height 1.1)))))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
