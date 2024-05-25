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

;; Auto-Pairs
(electric-pair-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Fonts Settings
(set-face-attribute
 'default nil
 :family "FiraCode Nerd Font Propo"
 :height 170
 :weight 'medium)

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
;; (set-face-attribute
;;  'fill-column-indicator nil
;;  :family "FiraCode Nerd Font Propo" :height 100 :weight 'bold)

(global-display-fill-column-indicator-mode t)

(global-hl-line-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 '(package-selected-packages
   '(doom-modeline all-the-icons use-package doom-themes gruvbox-theme)))
(custom-set-faces
 )

(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;(setq use-package-always-ensure t)
(add-to-list 'load-path "~/.emacs.d/setup-files/")


(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :ensure t
  :after all-the-icons
  :hook
  (server-after-make-frame-hook . (lambda () (all-the-icons-completion-mode))))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-set-undo-system 'undo-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Better Doc & Help Pages
(use-package helpful
  :ensure t
  ;:custom
  ;(counsel-describe-function-function #'helpful-callable)
  ;(counsel-describe-varaible-function #'helpful-variable)
  :bind
  ;([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ;([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package highlight-numbers
  :ensure t
  :hook (prog-mode . highlight-numbers-mode)
  :config
  (set-face-attribute 'highlight-numbers-number nil :weight 'semi-bold))


(use-package jenkinsfile-mode :ensure t)
(use-package fish-mode :ensure t)
(use-package json-mode :ensure t)
(use-package csv-mode :ensure t)
(use-package origami :ensure t
  :config
  (global-origami-mode))
;; (use-package yasnippet :ensure t)

(require 'setup-theme)
(require 'setup-modeline)
(require 'setup-vertico)
(require 'setup-consult)
(require 'setup-dashboard)
(require 'setup-corfu)
(require 'setup-git)
(require 'setup-org)
(require 'setup-eglot)
(require 'setup-haskell)
(require 'setup-purescript)
(require 'setup-javascript)
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
(require 'setup-orderless)
(require 'setup-dirvish)
(require 'setup-hl-todo)

;(add-to-list 'after-make-frame-functions (lambda (frame) (set-cursor-color "#6c9ef8")))
(defun new-frame-setup (frame)
  (if (display-graphic-p frame)
      (setq neo-theme 'icons)))
;; Run for already-existing frames (For single instance emacs)
(mapc 'new-frame-setup (frame-list))
;; Run when a new frame is created (For emacs in client/server mode)
(add-hook 'after-make-frame-functions 'new-frame-setup)
;(add-hook 'after-make-frame-functions (lambda (frame) (set-cursor-color "#49cf66")))

(put 'downcase-region 'disabled nil)
