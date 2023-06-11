(setq modus-themes-vivendi-color-overrides
      '((bg-main . "#1d2021")
        (fg-main . "#c2c2c2")))
;; Don't show the splash screen
(setq inhibit-startup-message t)

;; UI Tweaks
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(recentf-mode 1)
(global-auto-revert-mode t)
(set-fringe-mode 10)
(display-time-mode t)
;; For laptop only
;(display-battery-mode t)
(toggle-truncate-lines)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Fonts Settings
(set-face-attribute
 'default nil :family "FiraCode Nerd Font Mono" :height 110 :weight 'regular)

;; Custom Var Options
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Line Numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Char Ruler
(setq-default display-fill-column-indicator-column 95)
(global-display-fill-column-indicator-mode t)

(global-hl-line-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.
;; See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-modeline all-the-icons use-package doom-themes gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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

;; Theme/Colors
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (set-face-attribute 'font-lock-constant-face nil :weight 'semi-bold)
  (set-face-attribute 'font-lock-keyword-face nil :weight 'semi-bold)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  (set-cursor-color "#dfaf7a"))

(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-hud t)
  (doom-modeline-mode 1)
  (custom-set-faces
  '(mode-line ((t (:family "Hack Nerd Font" :height 0.90))))
  '(mode-line-active ((t (:family "Hack Nerd Font" :height 0.90)))) ; For 29+
  '(mode-line-inactive ((t (:family "Hack Nerd Font" :height 0.90)))))
  :custom
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-support-imenu t)
  (doom-modeline-hud t)
  (doom-modeline-enable-word-count t)
  (doom-modeline-bar-width 10)
  (doom-modeline-height 11))

(use-package all-the-icons
  :if (display-graphic-p))

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

;(use-package highlight-indent-guides
;  :init
;  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;  (setq highlight-indent-guides-method 'character))

;(use-package rainbow-delimiters
;  :ensure t
;  :hook (prog-mode . rainbow-delimiters-mode))

; (use-package ivy
;   :ensure t
;   :diminish
;   :bind (("C-s" . swiper)
;          :map ivy-minibuffer-map
;          ("TAB" . ivy-alt-done)	
;          ("C-l" . ivy-alt-done)
;          ("C-j" . ivy-next-line)
;          ("C-k" . ivy-previous-line)
;          :map ivy-switch-buffer-map
;          ("C-k" . ivy-previous-line)
;          ("C-l" . ivy-done)
;          ("C-d" . ivy-switch-buffer-kill)
;          :map ivy-reverse-i-search-map
;          ("C-k" . ivy-previous-line)
;          ("C-d" . ivy-reverse-i-search-kill))
;   :config
;   (ivy-mode 1))
; 
; ;; More Help On Cmds
; (use-package ivy-rich
;   :ensure t
;   :init
;   (ivy-rich-mode 1))
; 
; ;; More Features For Builtins
; (use-package counsel
;   :ensure t
;   :bind (("M-x" . counsel-M-x)
; 	 ("C-x b" . counsel-ibuffer)
; 	 ("C-x C-f" . counsel-find-file)
; 	 :map minibuffer-local-map
; 	 ("C-r" . 'counsel-minibuffer-history)))


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
;  
;(use-package general
;  :ensure t
;  :config
;
;  (general-define-key "C-M-j" 'counsel-switch-buffer)
;  
;  (general-create-definer rune/leader-keys
;    :keymaps '(normal insert visual emacs)
;    :perfix "SPC"
;    :global-prefix "C-SPC"))
;
;(use-package projectile
;  :ensure t
;  :diminish projectile-mode
;  :config (projectile-mode)
;  :custom ((projectile-completion-system 'ivy))
;  :bind-keymap
;  ("C-c p" . projectile-command-map)
;  :init
;  (when (file-directory-p "~/sdk")
;    (setq projectile-project-search-path '("~/sdk" "~/euler")))
;  (setq projectile-switch-project-action #'projectile-dired))

; (use-package counsel-projectile
;   :ensure t
;   :config (counsel-projectile-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (setq rainbow-delimiters-max-face-count 1)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package highlight-numbers
  :ensure t
  :hook (prog-mode . highlight-numbers-mode)
  :config
  (set-face-attribute 'highlight-numbers-number nil :weight 'semi-bold))


(use-package jenkinsfile-mode :ensure t)
(use-package fish-mode :ensure t)
(use-package json-mode :ensure t)
(use-package yaml-mode :ensure t)

(require 'setup-org)
(require 'setup-git)
(require 'setup-vertico)
(require 'setup-consult)
;(require 'setup-lsp)
(require 'setup-dashboard)
(require 'setup-company)
(require 'setup-haskell)
(require 'setup-purescript)
(require 'setup-javascript)
(require 'setup-tree-sitter)
(require 'setup-page-break-lines)
(require 'setup-dired)
(require 'setup-eglot)
(require 'setup-elisp)
(require 'setup-eshell)
(require 'setup-magit)
(require 'setup-theme)
(require 'setup-corfu)
(require 'setup-ligatures)
(require 'setup-nix)
(require 'setup-rust)
(require 'setup-direnv)
(require 'setup-docker)
(require 'setup-clojure)
;(add-to-list 'after-make-frame-functions (lambda (frame) (set-cursor-color "#6c9ef8")))
(defun new-frame-setup (frame)
  (if (display-graphic-p frame)
      (setq neo-theme 'icons)))
;; Run for already-existing frames (For single instance emacs)
(mapc 'new-frame-setup (frame-list))
;; Run when a new frame is created (For emacs in client/server mode)
(add-hook 'after-make-frame-functions 'new-frame-setup)
;(add-hook 'after-make-frame-functions (lambda (frame) (set-cursor-color "#49cf66")))
