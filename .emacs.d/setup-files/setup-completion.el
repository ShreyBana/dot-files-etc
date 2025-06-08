;;; -- VERTICO & FRIENDS --
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))
(use-package marginalia :after vertico
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (marginalia-align 'right)
  :init
  (marginalia-mode))
;; TODO Figure out how to load it in setup-ui.el
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode t))

;;; -- CONSULT --
(use-package consult
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :custom
  (completion-in-region-function #'consult-completion-in-region))
  ;:config ;(consult-preview-mode))
(use-package consult-eglot
  :after consult)

;;; -- CORFU & FRIENDS --
(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-auto t)
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
  (corfu-popupinfo-delay 0.2)
  (text-mode-ispell-word-completion t)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("C-SPC" . corfu-insert-separator))

  :init
  (global-corfu-mode)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  (setq corfu-auto t
        corfu-auto-delay 0.15
        corfu-quit-no-match 'separator
        corfu-popupinfo-mode t
        completion-styles '(orderless)))
;; Extends eshell pcomplete to give completion from MAN pages.
(use-package pcmpl-args)
;; Fish completions in eshell.
(use-package fish-completion
  :config (when (executable-find "fish") (global-fish-completion-mode)))
(use-package cape
  :ensure t
  :init
  ;; Add Cape completion sources to `completion-at-point-functions'
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  :custom
  (ispell-program-name "aspell") ;; Use "aspell" or "hunspell" if preferred
  (ispell-dictionary "en_US") ;; Set the default dictionary
  (ispell-alternate-dictionary "/home/shrey_bana/.dict-english")
  :config
  ;; Configure Ispell for spell-checking
  ;; (setq ispell-alternate-dictionary "/usr/share/dict/words") ;; Path to word list
  ;; Optional: Keybindings for Cape sources
  (global-set-key (kbd "M-d") #'cape-dabbrev) ;; Dynamic abbreviations
  (global-set-key (kbd "M-f") #'cape-file)    ;; File completion
  )

;;; -- EGLOT --
(use-package eglot
  :custom
  (eglot-ignored-server-capabilities '(:inlayHintProvider :signatureHelpProvider))
  (eglot-extend-to-xref t)
  :init
  (setq eglot-inlay-hints-mode nil)
  :hook ((kotlin-ts-mode . eglot-ensure)
         (nix-ts-mode . eglot-ensure)
         (c-ts-mode . eglot-ensure)
         (java-ts-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(smithy-mode . ("smithy-language-server" "0")))
  (setq eglot-report-progress 'messages)
  (add-to-list 'eglot-stay-out-of 'flymake))
(use-package eldoc
  :straight (:type built-in)
  :config
  (setq eldoc-echo-area-use-multiline-p nil)
  (advice-add 'eldoc-doc-buffer :after
              (lambda (&rest _)
                (when-let ((window (get-buffer-window "*eldoc*")))
                  (select-window window)))))

(use-package eldoc-box)

;;; -- LLM --
(use-package copilot)
  ;;:config (global-copilot-mode t))
(use-package copilot-chat
  :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
  :after (request org markdown-mode))
(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :init
  (setenv
   "OPENROUTER_API_KEY"
   (string-trim (shell-command-to-string "pass show openrouter/api-key")))
  (setenv "AIDER_DARK_MODE" "true")
  (setq aidermacs-backend 'vterm)
  :custom
  ; See the Configuration section below
  (aidermacs-use-architect-mode nil)
  ;; Enable/disable showing diffs after changes (default: t)
  (aidermacs-show-diff-after-change nil)
  (aidermacs-default-model "openrouter/anthropic/claude-3.7-sonnet"))

;;; -- MISC --
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

(provide 'setup-completion)
